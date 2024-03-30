<%@ page import="java.sql.*, javax.naming.InitialContext, javax.sql.DataSource" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="SQLconstants.jsp"%>

<%
	// 입력받은 게임 정보
	request.setCharacterEncoding("UTF-8");
	String gameName = request.getParameter("game_name");
	String developer = request.getParameter("developer");
	String price = request.getParameter("price");
	String genre = request.getParameter("genre");
	String releaseDate = request.getParameter("release_date");
	String imageUrl = request.getParameter("image_url");
	String message = null;

	Connection con = null;
	PreparedStatement pstmt = null;

	try {
		// JNDI를 통한 DataSource 접근
		InitialContext initContext = new InitialContext();
		DataSource ds = (DataSource)initContext.lookup("java:comp/env/jdbc/YourDataSource");
		con = ds.getConnection();

		// 게임 정보를 데이터베이스에 안전하게 추가
		String sql = "INSERT INTO games (name, developer, price, genre, release_date, image_url) VALUES (?, ?, ?, ?, ?, ?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, gameName);
		pstmt.setString(2, developer);
		pstmt.setFloat(3, Float.parseFloat(price));
		pstmt.setString(4, genre);
		pstmt.setString(5, releaseDate);
		pstmt.setString(6, imageUrl);

		int rowsAffected = pstmt.executeUpdate();
		if (rowsAffected > 0) {
			message = "게임(" + gameName + ")이(가) 성공적으로 등록되었습니다.";
		} else {
			message = "게임(" + gameName + ")을(를) 등록할 수 없습니다.";
		}
	} catch (SQLException e) {
		message = "데이터베이스 오류: " + e.getMessage();
		e.printStackTrace();
	} catch (NamingException e) {
		message = "JNDI 리소스 찾기 오류: " + e.getMessage();
		e.printStackTrace();
	} catch (NumberFormatException e) {
		message = "가격 형식 오류: " + e.getMessage();
		e.printStackTrace();
	} finally {
		if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
		if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
	}
%>

<!-- 결과 메시지를 사용자에게 알림 -->
<script language="javascript">
	alert('<%=message%>');
	window.location.href = 'gameList.jsp'; // 등록 후 게임 목록 페이지로 리다이렉션
</script>
