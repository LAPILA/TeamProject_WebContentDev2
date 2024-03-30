<%@ page import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./SQLconstants.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>게임 목록</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #dddddd; text-align: left; padding: 8px; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h2>게임 목록</h2>
    <table>
        <tr>
            <th>게임ID</th>
            <th>게임명</th>
            <th>가격</th>
            <th>출시일</th>
            <th>이미지 URL</th>
        </tr>
        <%
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);
                stmt = con.createStatement();
                String query = "SELECT 게임ID, 게임명, 가격, 출시일, 이미지URL FROM 게임";
                rs = stmt.executeQuery(query);
                while (rs.next()) {
                    out.println("<tr>"
                                + "<td>" + rs.getInt("게임ID") + "</td>"
                                + "<td>" + rs.getString("게임명") + "</td>"
                                + "<td>" + rs.getFloat("가격") + "</td>"
                                + "<td>" + rs.getDate("출시일") + "</td>"
                                + "<td><a href='" + rs.getString("이미지URL") + "'>이미지 보기</a></td>"
                                + "</tr>");
                }
            } catch (ClassNotFoundException e) {
                out.println("드라이버 로딩 실패: " + e.getMessage());
            } catch (SQLException e) {
                out.println("SQL 에러: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                if (con != null) try { con.close(); } catch (SQLException e) {}
            }
        %>
    </table>
</body>
</html>
