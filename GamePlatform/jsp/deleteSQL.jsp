<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./SQLconstants.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");
    String message = "";

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        // MySQL 드라이버 연결
        Class.forName(jdbc_driver);
        con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

        // 리뷰 삭제
        String sqlDeleteReviews = "DELETE FROM 리뷰 WHERE 게임ID = ?";
        pstmt = con.prepareStatement(sqlDeleteReviews);
        pstmt.setInt(1, Integer.parseInt(id));
        pstmt.executeUpdate();
        pstmt.close();

        // 게임장르 삭제
        String sqlDeleteGameGenres = "DELETE FROM 게임장르 WHERE 게임ID = ?";
        pstmt = con.prepareStatement(sqlDeleteGameGenres);
        pstmt.setInt(1, Integer.parseInt(id));
        pstmt.executeUpdate();
        pstmt.close();

        // 구매한게임 삭제
        String sqlDeletePurchases = "DELETE FROM 구매한게임 WHERE 게임ID = ?";
        pstmt = con.prepareStatement(sqlDeletePurchases);
        pstmt.setInt(1, Integer.parseInt(id));
        pstmt.executeUpdate();
        pstmt.close();
        
        // 실제 게임 데이터 삭제
        String sqlDeleteGame = "DELETE FROM 게임 WHERE 게임ID = ?";
        pstmt = con.prepareStatement(sqlDeleteGame);
        pstmt.setInt(1, Integer.parseInt(id));
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            message = "게임 ID " + id + "가 성공적으로 삭제되었습니다.";
        } else {
            message = "해당 게임 ID를 찾을 수 없습니다. 삭제에 실패했습니다.";
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

    // 메시지가 비어있지 않다면, 메시지를 출력하고 게임 목록 페이지로 리다이렉션합니다.
    if (!message.isEmpty()) {
%>
<%@ include file="./log.jsp"%>
<%
	// 로그 데이터 추출
	writeLog(message, request, session);
%>

<form name="frm" method="post" action="./gameList.jsp">
	<input type="hidden" name="message" value="<%=message%>">
</form>
<script language="javascript">
	document.frm.submit();
</script>
<%
    }
%>