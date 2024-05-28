<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="./SQLconstants.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Action</title>
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("nameQuery");
        String password = request.getParameter("passwordQuery");


        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

            String sql = "SELECT 회원ID FROM WHERE 회원명=? AND 비밀번호=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String userID = rs.getString("회원ID");

    %>

                <form id="redirectForm" action="main.jsp" method="POST">
                    <input type="hidden" name="userID" value="<%= userID %>">
                </form>
                <script type="text/javascript">
                    document.getElementById("redirectForm").submit();
                </script>

    <%
            } else {
                out.println("<script>alert('아이디 또는 비밀번호가 틀렸습니다.'); history.back();</script>");
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