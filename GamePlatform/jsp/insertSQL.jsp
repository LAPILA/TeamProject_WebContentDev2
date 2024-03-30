<%@ page import="java.sql.*, javax.sql.DataSource" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./SQLconstants.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    String gameName = request.getParameter("game_name");
    String price = request.getParameter("price");
    String developerId = request.getParameter("developer_id");
    String genre = request.getParameter("genre");
    String releaseDate = request.getParameter("release_date");
    String imageUrl = request.getParameter("image_url");
    String message = message.replace("'", "\\'");

    try {
        Class.forName(jdbc_driver);
        try (Connection con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);
             PreparedStatement pstmt = con.prepareStatement("INSERT INTO 게임 (게임명, 가격, 개발사ID, 장르, 출시일, 이미지URL) VALUES (?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, gameName);
            pstmt.setFloat(2, Float.parseFloat(price));
            pstmt.setInt(3, Integer.parseInt(developerId));
            pstmt.setString(4, genre);
            pstmt.setDate(5, java.sql.Date.valueOf(releaseDate));
            pstmt.setString(6, imageUrl);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                message = "게임(" + gameName + ")이(가) 성공적으로 추가되었습니다.";
            } else {
                message = "게임 추가에 실패했습니다.";
            }
        }
    } catch (ClassNotFoundException e) {
        message = "JDBC 드라이버 로딩 실패: " + e.getMessage();
    } catch (SQLException e) {
        message = "데이터베이스 오류: " + e.getMessage();
    } catch (NumberFormatException e) {
        message = "숫자 형식 오류: " + e.getMessage();
    }

    if (!message.isEmpty()) {
%>
<script language="javascript">
    alert('<%=message%>');
    window.location.href = 'gameList.jsp'; // 등록 후 게임 목록 페이지로 리다이렉션
</script>
<%
    }
%>
