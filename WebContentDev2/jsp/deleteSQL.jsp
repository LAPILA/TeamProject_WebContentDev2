<%@ page language="java" import="java.sql.*, javax.naming.*, javax.sql.DataSource" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="SQLconstants.jsp"%>
<%
	// 이전 페이지에서 전달 받은 게임 ID 확인
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String message = null;

	if (id != null && !id.trim().isEmpty()) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			// JNDI를 사용하여 연결
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/YourDB");
			con = ds.getConnection();

			// SQL 쿼리 실행
			String query = "DELETE FROM game WHERE id = ?;";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, Integer.parseInt(id));

			if (pstmt.executeUpdate() > 0) {
				message = "게임 ID " + id + "이(가) 삭제되었습니다.";
			} else {
				message = "해당 게임 ID를 찾을 수 없습니다.";
			}
		} catch (SQLException e) {
			message = "데이터베이스 에러: " + e.getMessage();
		} catch (NamingException e) {
			message = "JNDI 설정 에러: " + e.getMessage();
		} catch (NumberFormatException e) {
			message = "ID 형식 에러: " + e.getMessage();
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
			if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
	}
%>

<%@ include file="log.jsp" %>
<%
	// 로그 데이터 추출
	writeLog(message, request, session);
%>

<!-- 결과 메시지를 search.jsp 페이지에 표시 -->
<%@ include file="messageDisplay.jsp" %>
