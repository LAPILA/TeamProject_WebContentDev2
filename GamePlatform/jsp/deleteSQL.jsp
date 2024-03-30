<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="SQLconstants.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");
    String message = null;

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        // MySQL 드라이버 클래스 로드
        Class.forName("com.mysql.cj.jdbc.Driver");

        // 데이터베이스 연결
        con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

        // 관련 데이터 삭제를 위한 준비 쿼리
        String deleteRelatedQuery = "DELETE FROM 게임장르 WHERE 게임ID = ?";
        try (PreparedStatement relatedPstmt = con.prepareStatement(deleteRelatedQuery)) {
            relatedPstmt.setInt(1, Integer.parseInt(id));
            relatedPstmt.executeUpdate();
        }
        
        // 게임 삭제 쿼리 실행
        String query = "DELETE FROM 게임 WHERE 게임ID = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setInt(1, Integer.parseInt(id));

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            message = "게임 ID " + id + "이(가) 성공적으로 삭제되었습니다.";
        } else {
            message = "해당 게임 ID를 찾을 수 없습니다.";
        }
    } catch (ClassNotFoundException e) {
        message = "MySQL 드라이버 클래스를 찾을 수 없습니다: " + e.getMessage();
    } catch (SQLException e) {
        message = "데이터베이스 에러: " + e.getMessage();
    } catch (NumberFormatException e) {
        message = "ID 형식 에러: " + e.getMessage();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }
    }

    // 메시지를 JavaScript alert로 표시하고, 게임 목록 페이지로 리다이렉션
    if (message != null && !message.isEmpty()) {
%>
<script language="javascript">
    alert('<%=message%>');
    window.location.href = 'gameList.jsp';
</script>
<%
    }
%>
