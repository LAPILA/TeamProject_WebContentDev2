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
        String userEmail = request.getParameter("emailQuery");
        String userName = request.getParameter("nameQuery");
        String password = request.getParameter("passwordQuery");
        String c_password = request.getParameter("c_passwordQuery");
        String op = request.getParameter("b");
        boolean result = true;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

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

            if(password != c_password){
                result = false;
            }


            if(result){
                if(op.equals("signup")) {
                    response.sendRedirect("main.jsp");
                } else if(op.equals("check")) {
                    String sql2 = "INSERT INTO 회원 (회원ID, 회원명, 비밀번호, 이메일, 가입일, 역할) VALUES (?, '?', ?, ?, NOW(), 'USER')";
                try{
                    pstmt = conn.prepareStatement(sql2);
                    pstmt.setString(1, userName);
                    pstmt.setString(2, userName);
                    pstmt.setString(3, password);
                    pstmt.setString(4, userEmail);
                    pstmt.executeUpdate();
                    pstmt.close();
                    
                    out.println("<script>alert('회원가입 완료.'); history.back();</script>");


                    } catch (Exception e) {
                    e.printStackTrace();
            }

        }            else out.println("<script>alert('비밀번호 확인이 틀렸습니다.'); history.back();</script>");
        }
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