<%@ page import="java.sql.*, javax.sql.DataSource, java.io.*, java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./SQLconstants.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    String gameName = request.getParameter("game_name");
    String price = request.getParameter("price");
    String developerId = request.getParameter("developer_id");
    String genre = request.getParameter("genre");
    String releaseDate = request.getParameter("release_date");
    String imageUrl = request.getParameter("image_url");
    String message = "";
    int gameId = 0;

    long startTime = System.currentTimeMillis();  // 시작 시간 기록

    try {
        Class.forName(jdbc_driver);
        try (Connection con = DriverManager.getConnection(mySQL_database, mySQL_id, mySQL_password)) {
            con.setAutoCommit(false);
            try (PreparedStatement pstmt = con.prepareStatement("INSERT INTO 게임 (게임명, 가격, 개발사ID, 출시일, 이미지URL) VALUES (?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setString(1, gameName);
                pstmt.setFloat(2, Float.parseFloat(price));
                pstmt.setInt(3, Integer.parseInt(developerId));
                pstmt.setDate(4, java.sql.Date.valueOf(releaseDate));
                pstmt.setString(5, imageUrl);

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            gameId = generatedKeys.getInt(1);
                        }
                    }
                    message = "게임('" + gameName + "')이(가) 성공적으로 추가되었습니다.";
                } else {
                    message = "게임 추가에 실패했습니다.";
                }
            }

            // 장르 정보 추가
            if (!genre.isEmpty() && gameId != 0) {
                try (PreparedStatement pstmtGenre = con.prepareStatement("INSERT INTO 게임장르 (게임ID, 장르명) VALUES (?, ?)")) {
                    pstmtGenre.setInt(1, gameId);
                    pstmtGenre.setString(2, genre);
                    pstmtGenre.executeUpdate();
                }
            }
            
            con.commit();
        }
    } catch (Exception e) {
        message = "오류 발생: " + e.getMessage();
    } 

    long endTime = System.currentTimeMillis();  // 종료 시간 기록
    long duration = endTime - startTime;  // 경과 시간 계산

    // 로그 기록 요청
    String referer = request.getHeader("referer");
    String currentURL = request.getRequestURL().toString();
    request.setAttribute("이전페이지", referer);
    request.setAttribute("현재페이지", currentURL);
    request.setAttribute("머무는시간", duration);
    request.setAttribute("메시지", message);
    request.setAttribute("게임명", gameName);

    RequestDispatcher rd = request.getRequestDispatcher("/log.jsp");
    rd.include(request, response);

    if (!message.isEmpty()) {
%>
<script language="javascript">
    alert('<%=message%>');
    window.location.href = 'gameList.jsp'; // 게임 목록 페이지로 리다이렉션
</script>
<%
    }
%>
