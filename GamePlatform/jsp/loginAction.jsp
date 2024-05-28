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
        String userID = "";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

            String sql = "SELECT 회원ID FROM 회원 WHERE 회원명=? AND 비밀번호=?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            // 결과 확인
            if (rs.next()) {
                // 로그인 성공 시 해당 사용자의 ID를 가져와서 변수에 저장
                userID = rs.getString("회원ID");
            }
        } catch (Exception e) {
            // 예외 처리
            e.printStackTrace();
        } finally {
            // 리소스 해제
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        // 로그인 성공 여부에 따라 처리
        if (userID != "") {
    %>
            <form form id="redirectForm" method="post" action="main.jsp">
                <input type="hidden" name="userID" value = "<%= userID %>">
            </form>
            <script type="text/javascript">
                document.getElementById("redirectForm").submit();
            </script>
    <%

        } else {
            // 로그인 실패 시 메시지를 띄우고 이전 페이지로 이동
            out.println("<script>alert('아이디 또는 비밀번호가 틀렸습니다.'); window.history.back();</script>");
        }
    %>

</body>
</html>