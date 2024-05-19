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

            int count = 0;
            while (rs.next()) {
                count++;
                String leftPosition = (count % 2 == 1) ? "0px" : "645px";
                String topPosition = (count % 2 == 1) ? ((count - 1) / 2 * 215) + "px" : ((count - 2) / 2 * 215) + "px";

                out.println("<div style='width: 630px; height: 200px; left: " + leftPosition + "; top: " + topPosition + "; position: absolute; border: none; background-size: cover; background-color: transparent; cursor: pointer;'>");
                out.println("    <div style='width: 630px; height: 200px; left: 0px; top: 0px; position: absolute; opacity: 0.50; background: white; border-radius: 8px'></div>");
                out.println("    <div style='left: 203px; top: 20px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word'>" + rs.getString("게임명") + "<br/></div>");
                out.println("    <div style='left: 204px; top: 100px; position: absolute; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word; text-align: left;'>" + rs.getString("개발사명") + "<br/>" + rs.getString("시스템사양") + "</div>");
                out.println("    <div style='left: 203px; top: 57px; position: absolute; text-align: center; color: black; font-size: 24px; font-family: Inter; font-weight: 500; line-height: 33.60px; word-wrap: break-word'>" + rs.getFloat("가격") + "</div>");
                out.println("    <img style='width: 160px; height: 160px; left: 26px; top: 20px; position: absolute' src='" + rs.getString("이미지URL") + "' />");
                out.println("</div>");

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
