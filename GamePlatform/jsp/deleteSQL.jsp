<%@ page import="java.sql.*, java.io.*, java.time.*, javax.servlet.http.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./SQLconstants.jsp"%>
<%@ include file="log.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");
    String message = "";
    long startTime = System.currentTimeMillis();  // Record start time

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        // Connect to MySQL using JDBC driver
        Class.forName(jdbc_driver);
        con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

        // Delete reviews
        String sqlDeleteReviews = "DELETE FROM 리뷰 WHERE 게임ID = ?";
        pstmt = con.prepareStatement(sqlDeleteReviews);
        pstmt.setInt(1, Integer.parseInt(id));
        pstmt.executeUpdate();
        pstmt.close();

        // Delete game genres
        String sqlDeleteGameGenres = "DELETE FROM 게임장르 WHERE 게임ID = ?";
        pstmt = con.prepareStatement(sqlDeleteGameGenres);
        pstmt.setInt(1, Integer.parseInt(id));
        pstmt.executeUpdate();
        pstmt.close();

        // Delete purchased games
        String sqlDeletePurchases = "DELETE FROM 구매한게임 WHERE 게임ID = ?";
        pstmt = con.prepareStatement(sqlDeletePurchases);
        pstmt.setInt(1, Integer.parseInt(id));
        pstmt.executeUpdate();
        pstmt.close();

        // Finally, delete the game
        String sqlDeleteGame = "DELETE FROM 게임 WHERE 게임ID = ?";
        pstmt = con.prepareStatement(sqlDeleteGame);
        pstmt.setInt(1, Integer.parseInt(id));
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            message = "Game ID " + id + " has been successfully deleted.";
        } else {
            message = "No game found with ID " + id + "; deletion failed.";
        }
    } catch (ClassNotFoundException e) {
        message = "Failed to load JDBC driver: " + e.getMessage();
    } catch (SQLException e) {
        message = "Database error: " + e.getMessage();
    } catch (NumberFormatException e) {
        message = "Invalid format for ID: " + e.getMessage();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (con != null) try { con.close(); } catch (SQLException ex) {}
    }

    long endTime = System.currentTimeMillis();
    long duration = endTime - startTime;
    HttpSession session = request.getSession(); // Ensure session is available

    writeLog(message + " - Processing time: " + duration + "ms", request, session);
    
    if (!message.isEmpty()) {
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
