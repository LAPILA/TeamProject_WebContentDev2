<%@ page import="java.sql.*, java.io.*, java.time.*, javax.servlet.http.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./SQLconstants.jsp"%>
<%@ include file="log.jsp" %> <!-- 로그 작성을 위한 JSP 파일 포함 -->
<!DOCTYPE html>
<html>
<head>
    <title>검색 결과</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .game-info { margin-bottom: 20px; border-bottom: 1px solid #ccc; padding-bottom: 10px; }
        img { margin-top: 10px; height: 150px; width: auto; }
    </style>
</head>
<body>
    <h2>검색 결과</h2>
    <%
        request.setCharacterEncoding("UTF-8");
        String searchQuery = request.getParameter("searchQuery");
        searchQuery = (searchQuery == null || searchQuery.isEmpty()) ? "%" : "%" + searchQuery.trim() + "%";

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        long startTime = System.currentTimeMillis();  // 시작 시간 기록

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

            String query = "SELECT g.게임ID, g.게임명, g.가격, g.출시일, g.이미지URL, g.시스템사양, g.연령등급, d.개발사명 " +
                           "FROM 게임 g JOIN 개발사 d ON g.개발사ID = d.개발사ID " +
                           "WHERE g.게임명 LIKE ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, searchQuery);
            rs = pstmt.executeQuery();

            StringBuilder results = new StringBuilder();
            while (rs.next()) {
                out.println("<div class='game-info'>" +
                        "<strong>게임 ID:</strong> " + rs.getInt("게임ID") + "<br>" +
                        "<strong>게임 제목:</strong> " + rs.getString("게임명") + "<br>" +
                        "<strong>개발사:</strong> " + rs.getString("개발사명") + "<br>" +
                        "<strong>시스템 사양:</strong> " + rs.getString("시스템사양") + "<br>" +
                        "<strong>연령등급:</strong> " + rs.getString("연령등급") + "<br>" +
                        "<strong>가격:</strong> " + rs.getFloat("가격") + "<br>" +
                        "<strong>출시일:</strong> " + rs.getDate("출시일") + "<br>" +
                        "<img src='" + rs.getString("이미지URL") + "' alt='" + rs.getString("게임명") + " 이미지'>" +
                        "</div>");
                results.append(rs.getString("게임명")).append(", ");
            }

            long endTime = System.currentTimeMillis();  // 종료 시간 기록
            long duration = endTime - startTime;  // 경과 시간 계산

            // 결과가 없을 경우 메시지 출력
            if (results.length() == 0) {
                out.println("<p>검색 결과가 없습니다.</p>");
            } else {
                // 로그 기록
                String logMessage = "검색 결과: " + results.toString();
                writeLog(logMessage, request, session);
            }
        } catch (ClassNotFoundException e) {
            out.println("JDBC 드라이버 로딩 실패: " + e.getMessage());
        } catch (SQLException e) {
            out.println("데이터베이스 연결/쿼리 오류: " + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ex) { }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { }
            if (con != null) try { con.close(); } catch (SQLException ex) { }
        }
    %>
</body>
</html>
