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
        String userID = request.getParameter("userID");
        String gameID = request.getParameter("gameID");


        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

            String sql = "SELECT * FROM 구매한게임 WHERE 회원ID=? AND 게임ID=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userID);
            pstmt.setString(2, gameID);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                out.println("<script>alert('이미 구매한 게임입니다.'); history.back();</script>");
            } else {
                String buysql = "INSERT INTO 구매한게임 (회원ID, 게임ID, 구매일) VALUES (?, ?, CURRENT_DATE())";
                try{
                    pstmt = conn.prepareStatement(buysql);
                    pstmt.setString(1, userID);
                    pstmt.setString(2, gameID);
                    pstmt.executeUpdate();
                    pstmt.close();
                    
                    out.println("<script>alert('게임을 구매했습니다.'); history.back();</script>");


                    } catch (Exception e) {
                    e.printStackTrace();
                }
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