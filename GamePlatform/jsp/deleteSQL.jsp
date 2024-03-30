<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="SQLconstants.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");
    String message = "";

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

        // 해당 게임 ID를 참조하는 '리뷰' 테이블의 데이터 삭제
        String deleteReviews = "DELETE FROM 리뷰 WHERE 게임ID = ?";
        pstmt = con.prepareStatement(deleteReviews);
        pstmt.setInt(1, Integer.parseInt(id));
        pstmt.executeUpdate();
        pstmt.close();

        // 해당 게임 ID를 참조하는 '게임장르' 테이블의 데이터 삭제
        String deleteGameGenres = "DELETE FROM 게임장르 WHERE 게임ID = ?";
        pstmt = con.prepareStatement(deleteGameGenres);
        pstmt.setInt(1, Integer.parseInt(id));
        pstmt.executeUpdate();
        pstmt.close();

        // 해당 게임 ID를 참조하는 '구매한게임' 테이블의 데이터 삭제 
        String deletePurchases = "DELETE FROM 구매한게임 WHERE 게임ID = ?";
        pstmt = con.prepareStatement(deletePurchases);
        pstmt.setInt(1, Integer.parseInt(id));
        pstmt.executeUpdate();
        pstmt.close();

        // 마지막으로, '게임' 테이블에서 게임 삭제
        String deleteGame = "DELETE FROM 게임 WHERE 게임ID = ?";
        pstmt = con.prepareStatement(deleteGame);
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
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { }
        if (con != null) try { con.close(); } catch (SQLException ex) { }
    }

    // 메시지를 JavaScript alert로 표시하고, 게임 목록 페이지로 리다이렉션
    if (!message.isEmpty()) {
%>
<script language="javascript">
    alert('<%=message%>');
    window.location.href = 'gameList.jsp';
</script>
<%
    }
%>
