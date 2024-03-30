<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql."%>
<%@ page import="javax.sql.DataSource"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게임 검색</title>
</head>
<body>
    <div style="text-align: center;">
        <h2>로고 사이트 이름</h2>

        <form action="search.jsp" method="post">
            <input type="text" name="searchQuery" placeholder="게임 검색"/>
            <input type="submit" value="Search"/>
        </form>

        <%
        String searchQuery = request.getParameter("searchQuery");
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            DataSource dataSource = (DataSource)getServletContext().getAttribute("dataSource");
            try (Connection conn = dataSource.getConnection();
                 PreparedStatement stmt = conn.prepareStatement("SELECT FROM 게임 WHERE 게임명 LIKE ?")) {
                stmt.setString(1, "%" + searchQuery + "%");
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        out.println("<p>" + rs.getString("게임명") + "</p>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        %>
    </div>
</body>
</html>