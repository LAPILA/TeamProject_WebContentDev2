<%@ page import="java.sql.*, javax.naming.*, javax.sql.DataSource" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="SQLconstants.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>검색 결과</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #dddddd; text-align: left; padding: 8px; }
        th { background-color: #f2f2f2; }
        img { height: 100px; } /* 이미지 크기 조정 */
    </style>
</head>
<body>
    <h2>검색 결과</h2>
    <table>
        <tr>
            <th>게임 제목</th>
            <th>개발자</th>
            <th>가격</th>
            <th>장르</th>
            <th>출시일</th>
            <th>이미지</th>
        </tr>
        <%
            String searchQuery = request.getParameter("searchQuery");
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                Context initContext = new InitialContext();
                DataSource ds = (DataSource) initContext.lookup("java:comp/env/jdbc/YourDataSource");
                con = ds.getConnection();

                String query = "SELECT 게임명, 개발사명, 가격, 장르, 출시일, 이미지URL FROM 게임 WHERE 게임명 LIKE ?";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1, "%" + searchQuery + "%");
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("게임명") %></td>
                        <td><%= rs.getString("개발사명") %></td>
                        <td><%= rs.getFloat("가격") %></td>
                        <td><%= rs.getString("장르") %></td>
                        <td><%= rs.getDate("출시일").toString() %></td>
                        <td><img src="<%= rs.getString("이미지URL") %>" alt="게임 이미지"></td>
                    </tr>
                    <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </table>
    <br>
    <a href="./search.jsp">새 검색</a>
</body>
</html>
