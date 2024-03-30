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
            <th>개발사</th>
            <th>가격</th>
            <th>장르</th>
            <th>출시일</th>
            <th>이미지</th>
        </tr>
        <%
            try {
                InitialContext initContext = new InitialContext();
                DataSource ds = (DataSource)initContext.lookup("java:comp/env/jdbc/YourDataSource");
                try (Connection con = ds.getConnection()) {
                    String sql = "SELECT 게임.게임명, 개발사.개발사명, 게임.가격, 장르.장르명, 게임.출시일, 게임.이미지URL FROM 게임 " +
                                 "JOIN 개발사 ON 게임.개발사ID = 개발사.개발사ID " +
                                 "JOIN 게임장르 ON 게임.게임ID = 게임장르.게임ID " +
                                 "JOIN 장르 ON 게임장르.장르명 = 장르.장르명";
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    ResultSet rs = pstmt.executeQuery();
                    while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getString("게임명") %></td>
                            <td><%= rs.getString("개발사명") %></td>
                            <td><%= rs.getFloat("가격") %></td>
                            <td><%= rs.getString("장르명") %></td>
                            <td><%= rs.getString("출시일") %></td>
                            <td><img src="<%= rs.getString("이미지URL") %>" height="100" /></td>
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
