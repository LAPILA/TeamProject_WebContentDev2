<%@ page language="java" import="java.sql.*, javax.naming.*, javax.sql.DataSource" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./SQLconstants.jsp"%>
<html>
<head>
    <title>검색 결과</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .game-info { margin-bottom: 20px; border-bottom: 1px solid #ccc; padding-bottom: 10px; }
        img { margin-top: 10px; }
    </style>
</head>
<body>
    <h2>검색 결과</h2>
    <%
        request.setCharacterEncoding("UTF-8");
        String searchQuery = request.getParameter("searchQuery"); // 'message'를 'searchQuery'로 변경
        searchQuery = (searchQuery == null || searchQuery.isEmpty()) ? "%" : searchQuery.trim();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Context initContext = new InitialContext();
            DataSource ds = (DataSource)initContext.lookup("java:comp/env/jdbc/YourDataSource");
            con = ds.getConnection();

            String query = "SELECT 게임ID, 게임명, 가격, 출시일, 이미지URL FROM 게임 WHERE 게임명 LIKE ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, "%" + searchQuery + "%");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                out.println("<div class='game-info'>"
                        + "<strong>게임 제목:</strong> " + rs.getString("게임명")
                        + "<br><strong>가격:</strong> " + rs.getFloat("가격")
                        + "<br><strong>출시일:</strong> " + rs.getDate("출시일")
                        + "<br><img src='" + rs.getString("이미지URL") + "' height='150' width='auto'>"
                        + "</div>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</body>
</html>
