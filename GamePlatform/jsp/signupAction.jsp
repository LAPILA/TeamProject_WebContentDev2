<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Join Action</title>
</head>
<body>
    <%
        String userEmail = request.getParameter("emailQuery");
        String userName = request.getParameter("nameQuery");
        String password = request.getParameter("passwordQuery");
        String c_password = request.getParameter("c_passwordQuery");

        String dbURL = "jdbc:mysql://3.138.183.93:3306/GamePlatForm_Task"; // 데이터베이스 URL 수정 필요
        String dbUser = "byul"; // 데이터베이스 사용자명 수정 필요
        String dbPassword = "Mmoon0920!"; // 데이터베이스 비밀번호 수정 필요

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            String sql = "INSERT INTO 회원 (회원명, 비밀번호, 이메일, 가입일, 역할) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userName);
            pstmt.setString(2, password);
            pstmt.setString(3, userEmail);
            pstmt.setString(4, joinDate);
            pstmt.setString(5, userPosition);
            pstmt.executeUpdate();

            out.println("Join Successful");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
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
    <input type="button" value="이동" onclick="location.href='main.jsp'">
</body>
</html>