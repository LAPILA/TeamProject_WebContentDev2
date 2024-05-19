<%@ page import="java.io.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>로그 기록</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .reset-button { margin-top: 20px; }
    </style>
</head>
<body>
    <h2>로그 기록</h2>

    <%
        // 로그 파일 경로 설정
        String logFilePath = application.getRealPath("/") + "log.txt";

        // 기록 리셋 요청 처리
        if ("reset".equals(request.getParameter("action"))) {
            try {
                new FileWriter(logFilePath, false).close();
                out.println("<p>로그 기록이 리셋되었습니다.</p>");
            } catch (IOException e) {
                e.printStackTrace();
                out.println("<p>로그 리셋 중 오류가 발생했습니다: " + e.getMessage() + "</p>");
            }
        }

        // 로그 기록을 위한 파라미터 가져오기 및 null 체크
        String 이전페이지 = (request.getAttribute("이전페이지") != null) ? request.getAttribute("이전페이지").toString() : "N/A";
        String 현재페이지 = (request.getAttribute("현재페이지") != null) ? request.getAttribute("현재페이지").toString() : "N/A";
        String 머무는시간 = (request.getParameter("timeSpent") != null) ? request.getParameter("timeSpent") : "N/A";
        String 검색글자 = (request.getAttribute("검색글자") != null) ? request.getAttribute("검색글자").toString() : "N/A";
        String 검색된게임 = (request.getAttribute("검색된게임") != null) ? request.getAttribute("검색된게임").toString() : "N/A";

        // 로그 파일에 기록
        FileWriter fileWriter = null;
        BufferedWriter bufferedWriter = null;
        try {
            fileWriter = new FileWriter(logFilePath, true);
            bufferedWriter = new BufferedWriter(fileWriter);

            String logEntry = 이전페이지 + "\t"
                            + 현재페이지 + "\t"
                            + 머무는시간 + "\t"
                            + 검색글자 + "\t"
                            + 검색된게임 + "\n";
            bufferedWriter.write(logEntry);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (bufferedWriter != null) try { bufferedWriter.close(); } catch (IOException ex) { ex.printStackTrace(); }
            if (fileWriter != null) try { fileWriter.close(); } catch (IOException ex) { ex.printStackTrace(); }
        }

        // 로그 파일 내용 읽기 및 출력
        List<String[]> logEntries = new ArrayList<>();
        try (BufferedReader bufferedReader = new BufferedReader(new FileReader(logFilePath))) {
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                logEntries.add(line.split("\t"));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    %>

    <table>
        <thead>
            <tr>
                <th>이전 페이지</th>
                <th>현재 페이지</th>
                <th>머무는 시간 (ms)</th>
                <th>검색 글자</th>
                <th>검색된 게임</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (String[] entry : logEntries) {
                    out.println("<tr>");
                    for (String field : entry) {
                        out.println("<td>" + field + "</td>");
                    }
                    out.println("</tr>");
                }
            %>
        </tbody>
    </table>

    <form method="post" action="log.jsp">
        <input type="hidden" name="action" value="reset">
        <button type="submit" class="reset-button">로그 기록 리셋</button>
    </form>
</body>
</html>
