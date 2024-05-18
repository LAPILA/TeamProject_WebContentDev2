<%@ page import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

            String query = "SELECT g.게임ID, g.게임명, g.가격, g.출시일, g.이미지URL, g.시스템사양, g.연령등급, d.개발사명 " +
                           "FROM 게임 g JOIN 개발사 d ON g.개발사ID = d.개발사ID " +
                           "WHERE g.게임명 LIKE ?";

            pstmt = con.prepareStatement(query);
            pstmt.setString(1, "%" + searchQuery + "%");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                out.println("<div class='game-info'>"
                        + "<strong>게임 ID:</strong> " + rs.getInt("게임ID")
                        + "<br><strong>게임 제목:</strong> " + rs.getString("게임명")
                        + "<br><strong>개발사:</strong> " + rs.getString("개발사명")
                        + "<br><strong>시스템 사양:</strong> " + rs.getString("시스템사양")
                        + "<br><strong>연령등급:</strong> " + rs.getString("연령등급")
                        + "<br><strong>가격:</strong> " + rs.getFloat("가격")
                        + "<br><strong>출시일:</strong> " + rs.getDate("출시일")
                        + "<br><img src='" + rs.getString("이미지URL") + "' height='150' width='auto'>"
                        + "</div>");
            }
        } catch (ClassNotFoundException e) {
            out.println("드라이버 로딩 실패: " + e.getMessage());
        } catch (SQLException e) {
            out.println("SQL 에러: " + e.getMessage());
        } catch (Exception e) {
            out.println("에러: " + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</body>
</html>
