<%@ page language="java" import="java.sql.*, javax.naming.*, javax.sql.DataSource" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./SQLconstants.jsp"%>
<%
	// 이전 페이지에서 전달 받은 검색어 확인
	request.setCharacterEncoding("UTF-8");
	String message = request.getParameter("message");
	message = ((message == null) || message.equals("") || (message.indexOf(" * ") == 0)) ? "%" : message;

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		// JNDI를 통한 DataSource 접근
		Context initContext = new InitialContext();
		Context envContext = (Context) initContext.lookup("java:comp/env");
		DataSource ds = (DataSource) envContext.lookup("jdbc/YourDataSource");
		con = ds.getConnection();

		// 안전한 쿼리 실행
		String query = "SELECT * FROM games WHERE name LIKE ?";
		pstmt = con.prepareStatement(query);
		pstmt.setString(1, "%" + message + "%");
		rs = pstmt.executeQuery();

		// 결과 출력
		while (rs.next()) {
			out.println("<br>ID : " + rs.getString("id")
					+ "<br> 게임 제목: " + rs.getString("name")
					+ "<br> 개발자: " + rs.getString("developer")
					+ "<br> 가격: " + rs.getString("price")
					+ "<br> 장르: " + rs.getString("genre")
					+ "<br> 출시일: " + rs.getString("release_date")
					+ "<br> <img src='" + rs.getString("image_url") + "' height='280' width='180'><br><hr>");
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
		if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
		if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
	}
%>

<%@ include file="./log.jsp"%>
<%
	// 로그 데이터 추출 및 기록
	writeLog(message + "와 관련된 게임을 찾았습니다.", request, session);
%>
