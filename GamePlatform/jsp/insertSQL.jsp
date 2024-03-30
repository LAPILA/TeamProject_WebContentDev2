<%@ page import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./SQLconstants.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    String gameName = request.getParameter("game_name");
    String price = request.getParameter("price");
    String developerId = request.getParameter("developer_id");
    String genre = request.getParameter("genre");
    String releaseDate = request.getParameter("release_date");
    String imageUrl = request.getParameter("image_url");
    String message = "";

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

        String sql = "INSERT INTO 게임 (게임명, 가격, 개발사ID, 장르, 출시일, 이미지URL) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, gameName);
        pstmt.setFloat(2, Float.parseFloat(price));
        pstmt.setInt(3, Integer.parseInt(developerId));
        pstmt.setString(4, genre);
        pstmt.setDate(5, java.sql.Date.valueOf(releaseDate));
        pstmt.setString(6, imageUrl);

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            message = "게임이 성공적으로 등록되었습니다.";
        } else {
            message = "게임 등록에 실패하였습니다.";
        }
    } catch (ClassNotFoundException e) {
        message = "드라이버 로딩 실패: " + e.getMessage();
    } catch (SQLException e) {
        message = "데이터베이스 에러: " + e.getMessage();
    } catch (NumberFormatException e) {
        message = "가격 형식 에러: " + e.getMessage();
    } finally {
        if (pstmt != null) {
            try { pstmt.close(); } catch (SQLException ex) { }
        }
        if (con != null) {
            try { con.close(); } catch (SQLException ex) { }
        }
    }

    if (!message.isEmpty()) {
%>
<script language="javascript">
    alert('<%=message%>');
    window.location.href = 'gameList.jsp';
</script>
<%
    }
%>
