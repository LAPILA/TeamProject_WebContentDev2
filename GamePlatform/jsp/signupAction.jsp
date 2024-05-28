<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="./SQLconstants.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Join Action</title>
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");
        String userEmail = request.getParameter("emailQuery");
        String userName = request.getParameter("nameQuery");
        String password = request.getParameter("passwordQuery");
        String c_password = request.getParameter("c_passwordQuery");


        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        boolean result = true;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

            String sql = "SELECT COUNT(*) FROM 회원 WHERE 회원ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userName);
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);
            rs.close();
            pstmt.close();

            

            if((count>0) || (password != c_password)){
                result = false;
            } else result = true;

            if(!result) out.println("<script>alert('비밀번호 확인이 틀렸습니다.'); history.back();</script>");
            else{
            
                sql = "INSERT INTO 회원 (회원명, 비밀번호, 이메일, 가입일, 역할) VALUES (?, ?, ?, CURRENT_DATE(), DEFAULT)";
                pstmt = conn.prepareStatement(sql2);
                pstmt.setString(1, userName);
                pstmt.setString(2, password);
                pstmt.setString(3, userEmail);
                pstmt.executeUpdate();
                pstmt.close();
                    
                out.println("<script>alert('회원가입 완료.'); history.back();</script>");}
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
        // 자원 해제
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
                if (conn != null) try { conn.close(); } catch (SQLException ex) {}
        }



    %>
</body>
</html>