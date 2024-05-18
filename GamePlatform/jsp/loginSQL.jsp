<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./SQLconstants.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    String userID = request.getParameter("nameQuery");
    String userPW = request.getParameter("passwordQuery");

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        // MySQL 드라이버 연결
        Class.forName(jdbc_driver);
        con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);


        // 확인
        String sql = "SELECT * FROM 회원 WHERE 회원명=? AND 비밀번호=?";
        pstmt = conn.prepareSatement(sql);
        pstmt.setString(1, userID);
        pstmt.setString(2, userPW);
        int rowsAffected = pstmt.executeUpdate();


        if (rowsAffected > 0) {
            message = "success";
        } else {
            message = "fail";
        }
    } catch (ClassNotFoundException e) {
        message = "JDBC 드라이버 로딩에 실패했습니다: " + e.getMessage();
    } catch (SQLException e) {
        message = "데이터베이스 오류가 발생했습니다: " + e.getMessage();
    } catch (NumberFormatException e) {
        message = "잘못된 형식의 ID입니다: " + e.getMessage();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (con != null) try { con.close(); } catch (SQLException ex) {}
    }

    if (!message.isEmpty()) {
%>
<%@ include file="./log.jsp"%>
<%
	// 로그 데이터 추출
	writeLog(message, request, session);
%>

<form name="frm" method="post" action="./search.jsp">
	<input type="hidden" name="message" value="<%=message%>">
</form>
<script language="javascript">
	document.frm.submit();
</script>
<%
    }
%>

        
        
        if (rs.next()) {
            out.println("success");
        } else {
            out.println("fail");
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
        