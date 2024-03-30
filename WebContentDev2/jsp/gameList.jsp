<%@ page import="java.sql.*, javax.naming.*, javax.sql.DataSource" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="SQLconstants.jsp"%>
<html>
<head>
    <title>게임 목록</title>
</head>
<body>
    <h2>게임 목록</h2>
    <table border="1">
        <tr>
            <th>게임 이름</th>
            <th>개발자</th>
            <th>가격</th>
            <th>장르</th>
            <th>출시일</th>
        </tr>
        <%
            try {
                InitialContext initContext = new InitialContext();
                DataSource ds = (DataSource)initContext.lookup("java:comp/env/jdbc/YourDataSource");
                try (Connection con = ds.getConnection()) {
                    PreparedStatement pstmt = con.prepareStatement("SELECT name, developer, price, genre, release_date FROM games");
                    ResultSet rs = pstmt.executeQuery();
                    while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("developer") %></td>
                            <td><%= rs.getFloat("price") %></td>
                            <td><%= rs.getString("genre") %></td>
                            <td><%= rs.getString("release_date") %></td>
                        </tr>
                        <%
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
</body>
</html>
