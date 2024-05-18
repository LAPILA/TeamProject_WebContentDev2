<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./SQLconstants.jsp"%>
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

        try {
            // MySQL 드라이버 연결
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password);

            String query = "SELECT g.게임ID, g.게임명, g.가격, g.출시일, g.이미지URL, g.시스템사양, g.연령등급, d.개발사명 " +
                           "FROM 게임 g JOIN 개발사 d ON g.개발사ID = d.개발사ID " +
                           "WHERE g.게임명 LIKE ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, searchQuery);
            rs = pstmt.executeQuery();

            // 검색 결과를 표시하고 로그에 기록
            while (rs.next()) {
                // 검색 결과 표시
                out.println("<div class='game-info'>"
                        + "<strong>게임 ID:</strong> " + rs.getInt("게임ID")
                        + "<br><strong>게임 제목:</strong> " + rs.getString("게임명")
                        + "<br><strong>개발사:</strong> " + rs.getString("개발사명")
                        + "<br><strong>시스템 사양:</strong> " + rs.getString("시스템사양")
                        + "<br><strong>연령등급:</strong> " + rs.getString("연령등급")
                        + "<br><strong>가격:</strong> " + rs.getFloat("가격")
                        + "<br><strong>출시일:</strong> " + rs.getDate("출시일")
                        + "<br><img src='" + rs.getString("이미지URL") + "' height='150' width='auto'>"
                        + "</div>");

                // log.jsp에 로그 기록 요청
                request.setAttribute("게임ID", rs.getInt("게임ID"));
                request.setAttribute("게임명", rs.getString("게임명"));
                request.setAttribute("개발사명", rs.getString("개발사명"));
                request.setAttribute("시스템사양", rs.getString("시스템사양"));
                request.setAttribute("연령등급", rs.getString("연령등급"));
                request.setAttribute("가격", rs.getFloat("가격"));
                request.setAttribute("출시일", rs.getDate("출시일").toString()); // 날짜를 문자열로 변환
                request.setAttribute("이미지URL", rs.getString("이미지URL"));
                RequestDispatcher rd = request.getRequestDispatcher("/log.jsp");
                rd.include(request, response);
            }
        } catch (ClassNotFoundException e) {
            out.println("JDBC 드라이버 로딩 실패: " + e.getMessage());
        } catch (SQLException e) {
            out.println("데이터베이스 연결/쿼리 오류: " + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }
        }
    %>
</body>
</html>
