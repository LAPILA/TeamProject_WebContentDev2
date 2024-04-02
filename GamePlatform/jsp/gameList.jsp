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
                String query = "SELECT g.게임ID, g.게임명, g.가격, g.출시일, g.이미지URL, g.시스템사양, g.연령등급, d.개발사명 " +
                           "FROM 게임 g JOIN 개발사 d ON g.개발사ID = d.개발사ID " +
                           "WHERE g.게임명 LIKE ?";
                rs = stmt.executeQuery(query);
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
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                if (con != null) try { con.close(); } catch (SQLException e) {}
            }
        %>
    </table>
</body>
</html>
