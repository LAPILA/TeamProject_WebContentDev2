<%@ page import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="SQLconstants.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    String gameName = request.getParameter("game_name");
    String developerId = request.getParameter("developer_id");
    String price = request.getParameter("price");
    String genre = request.getParameter("genre");
    String releaseDate = request.getParameter("release_date");
    String imageUrl = request.getParameter("image_url");
    String message = "";

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        // MySQL 드라이버 클래스 로드
        Class.forName("com.mysql.cj.jdbc.Driver");

        // 데이터베이스 연결
        con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

        // 게임 정보를 데이터베이스에 안전하게 추가
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
            message = "게임('" + gameName + "')이(가) 성공적으로 등록되었습니다.";
        } else {
            message = "게임('" + gameName + "')을(를) 등록할 수 없습니다.";
        }
    } catch (ClassNotFoundException e) {
        message = "JDBC 드라이버 로딩 실패: " + e.getMessage();
    } catch (SQLException e) {
        message = "데이터베이스 연결/쿼리 오류: " + e.getMessage();
    } catch (NumberFormatException e) {
        message = "형식 변환 오류: " + e.getMessage();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { /* Handle errors for JDBC */ }
        if (con != null) try { con.close(); } catch (SQLException ex) { /* Handle errors for JDBC */ }
    }
%>

<script language="javascript">
    alert('<%=message%>');
    window.location.href = 'gameList.jsp'; // 등록 후 게임 목록 페이지로 리다이렉션
</script>
