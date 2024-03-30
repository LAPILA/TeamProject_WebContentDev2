<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./SQLconstants.jsp"%>
<html>
<head>
    <title>검색 결과</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .game-info { margin-bottom: 20px; border-bottom: 1px solid #ccc; padding-bottom: 10px; }
        img { margin-top: 10px; height: 150px; width: auto; }
    </style>
</head>
<body>
    <h2>검색 결과</h2>
    <%
        request.setCharacterEncoding("UTF-8");
        String searchQuery = request.getParameter("searchQuery");
        searchQuery = (searchQuery == null || searchQuery.isEmpty()) ? "%" : searchQuery.trim();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // MySQL 드라이버 연결
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

            String query = "SELECT 게임ID, 게임명, 가격, 출시일, 이미지URL FROM 게임 WHERE 게임명 LIKE ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, "%" + searchQuery + "%");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                out.println("<div class='game-info'>"
                        + "<strong>게임 제목:</strong> " + rs.getString("게임명")
                        + "<br><strong>가격:</strong> " + rs.getFloat("가격")
                        + "<br><strong>출시일:</strong> " + rs.getDate("출시일").toString()
                        + "<br><img src='" + rs.getString("이미지URL") + "'>"
                        + "</div>");
            }
        } catch (ClassNotFoundException e) {
            out.println("JDBC 드라이버 로딩 실패: " + e.getMessage());
        } catch (SQLException e) {
            out.println("데이터베이스 연결/쿼리 오류: " + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ex) { /* Handle errors for JDBC */ }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { /* Handle errors for JDBC */ }
            if (con != null) try { con.close(); } catch (SQLException ex) { /* Handle errors for JDBC */ }
        }
    %>
</body>
</html>
