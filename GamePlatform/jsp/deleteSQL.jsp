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

        // 게임 삭제
        String sqlDeleteGame = "DELETE FROM 게임 WHERE 게임ID = ?";
        pstmt = con.prepareStatement(sqlDeleteGame);
        pstmt.setInt(1, Integer.parseInt(id));
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            message = "게임 ID" + id + "삭제 성공.";
        } else {
            message = "해당 게임 ID를 찾을 수 없습니다.";
        }
    } catch (Exception e) {
        message = "오류 발생: " + e.getMessage();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (con != null) try { con.close(); } catch (SQLException ex) {}
    }
if (!message.isEmpty()) {
%>
<script language="javascript">
    alert('<%=message%>'); // 메시지 출력
    window.location.href = 'gameList.jsp'; // 리다이렉션
</script>
<%
    }
%>
