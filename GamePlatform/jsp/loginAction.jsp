<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Action</title>
</head>
<body>
    <%
        String userID = request.getParameter("nameQuery");
        String password = request.getParameter("passwordQuery");

        String dbURL = "jdbc:mysql://3.138.183.93:3306/GamePlatForm_Task"; // 데이터베이스 URL 수정 필요
        String dbUser = "byul"; // 데이터베이스 사용자명 수정 필요
        String dbPassword = "Mmoon0920!"; // 데이터베이스 비밀번호 수정 필요

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            String sql = "SELECT * FROM 회원 WHERE 회원=? AND 비밀번호=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userID);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                out.println("Login Successful");
                response.sendRedirect("./search.jsp");
            } else {
                out.println("Invalid credentials. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>