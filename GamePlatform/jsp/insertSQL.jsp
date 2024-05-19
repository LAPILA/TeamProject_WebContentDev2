<%@ page import="java.sql.*, java.io.*, java.time.*, javax.servlet.http.*, javax.sql.DataSource" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./SQLconstants.jsp"%>
<%@ include file="./log.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    String gameName = request.getParameter("game_name");
    String price = request.getParameter("price");
    String developerId = request.getParameter("developer_id");
    String genre = request.getParameter("genre");
    String releaseDate = request.getParameter("release_date");
    String imageUrl = request.getParameter("image_url");
    String message = "";
    int gameId = 0;

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        // Load JDBC driver and establish connection
        Class.forName(jdbc_driver);
        con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);
        con.setAutoCommit(false); // Start transaction

        // Insert game into database
        String sqlInsertGame = "INSERT INTO 게임 (게임명, 가격, 개발사ID, 출시일, 이미지URL) VALUES (?, ?, ?, ?, ?)";
        pstmt = con.prepareStatement(sqlInsertGame, Statement.RETURN_GENERATED_KEYS);
        pstmt.setString(1, gameName);
        pstmt.setFloat(2, Float.parseFloat(price));
        pstmt.setInt(3, Integer.parseInt(developerId));
        pstmt.setDate(4, java.sql.Date.valueOf(releaseDate));
        pstmt.setString(5, imageUrl);
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    gameId = generatedKeys.getInt(1);
                }
            }
            message = "게임('" + gameName + "')이(가) 성공적으로 추가되었습니다.";
            // Insert genre information if applicable
            if (!genre.isEmpty() && gameId != 0) {
                String sqlInsertGenre = "INSERT INTO 게임장르 (게임ID, 장르명) VALUES (?, ?)";
                pstmt = con.prepareStatement(sqlInsertGenre);
                pstmt.setInt(1, gameId);
                pstmt.setString(2, genre);
                pstmt.executeUpdate();
            }
        } else {
            message = "게임 추가에 실패했습니다.";
        }

        con.commit(); // Commit transaction
    } catch (Exception e) {
        message = "오류 발생: " + e.getMessage();
        if (con != null) try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }
    }

    writeLog(message, request, session);

    if (!message.isEmpty()) {
%>
<script language="javascript">
    alert('<%=message%>');
    window.location.href = 'gameList.jsp'; 
</script>
<%
    }
%>
