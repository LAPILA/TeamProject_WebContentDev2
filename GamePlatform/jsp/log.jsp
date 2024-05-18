<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
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
        } else {
            // 로그 기록을 위한 파라미터 가져오기 및 null 체크
            String 게임ID = (request.getAttribute("게임ID") != null) ? request.getAttribute("게임ID").toString() : "N/A";
            String 게임명 = (request.getAttribute("게임명") != null) ? request.getAttribute("게임명").toString() : "N/A";
            String 개발사명 = (request.getAttribute("개발사명") != null) ? request.getAttribute("개발사명").toString() : "N/A";
            String 시스템사양 = (request.getAttribute("시스템사양") != null) ? request.getAttribute("시스템사양").toString() : "N/A";
            String 연령등급 = (request.getAttribute("연령등급") != null) ? request.getAttribute("연령등급").toString() : "N/A";
            String 가격 = (request.getAttribute("가격") != null) ? request.getAttribute("가격").toString() : "N/A";
            String 출시일 = (request.getAttribute("출시일") != null) ? request.getAttribute("출시일").toString() : "N/A";
            String 이미지URL = (request.getAttribute("이미지URL") != null) ? request.getAttribute("이미지URL").toString() : "N/A";

            // Debugging print statements
            out.println("게임ID: " + 게임ID + "<br>");
            out.println("게임명: " + 게임명 + "<br>");
            out.println("개발사명: " + 개발사명 + "<br>");
            out.println("시스템사양: " + 시스템사양 + "<br>");
            out.println("연령등급: " + 연령등급 + "<br>");
            out.println("가격: " + 가격 + "<br>");
            out.println("출시일: " + 출시일 + "<br>");
            out.println("이미지URL: " + 이미지URL + "<br>");

            // 로그 파일에 기록
            FileWriter fileWriter = null;
            BufferedWriter bufferedWriter = null;
            try {
                fileWriter = new FileWriter(logFilePath, true);
                bufferedWriter = new BufferedWriter(fileWriter);

                String logEntry = 게임ID + "\t"
                                + 게임명 + "\t"
                                + 개발사명 + "\t"
                                + 시스템사양 + "\t"
                                + 연령등급 + "\t"
                                + 가격 + "\t"
                                + 출시일 + "\t"
                                + 이미지URL + "\n";
                bufferedWriter.write(logEntry);
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (bufferedWriter != null) try { bufferedWriter.close(); } catch (IOException ex) { ex.printStackTrace(); }
                if (fileWriter != null) try { fileWriter.close(); } catch (IOException ex) { ex.printStackTrace(); }
            }
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
                <th>게임 ID</th>
                <th>게임명</th>
                <th>개발사명</th>
                <th>시스템사양</th>
                <th>연령등급</th>
                <th>가격</th>
                <th>출시일</th>
                <th>이미지 URL</th>
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
