<%@ page import="java.io.*, java.time.*, javax.servlet.http.*, javax.servlet.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%! 
    public void writeLog(String message, HttpServletRequest request, HttpSession session) {
        // 로그 파일의 경로 설정
        String logFileName = getServletContext().getRealPath("./log.txt");

        try (FileWriter fw = new FileWriter(logFileName, true);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {

            // 로그 메시지 작성: 날짜, URI, 세션 ID, 레퍼러, 브라우저 정보, 사용자 메시지
            String logEntry = String.format("%s, %s, %s, %s, %s, %s%n",
                    LocalDateTime.now(),
                    session.getId(),
                    request.getRequestURI(),
                    request.getHeader("Referer"),
                    request.getHeader("User-Agent"),
                    message);
            out.println(logEntry);
        } catch (IOException e) {
            System.err.println("Error writing to log file: " + e.getMessage());
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Log Viewer</title>
    <style>
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
        }
        th {
            text-align: left;
        }
    </style>
</head>
<body>
    <h1>Log File Contents</h1>
    <table>
        <tr>
            <th>Date</th>
            <th>SessionID</th>
            <th>URI</th>
            <th>Referer</th>
            <th>Browser</th>
            <th>Message</th>
        </tr>
        <% 
            String logFileName = "./log.txt"; // 로그 파일 상대 경로 설정
            File file = new File(getServletContext().getRealPath(logFileName)); // 실제 파일 경로 변환
            if (file.exists()) {
                try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        if (line.trim().isEmpty()) continue; // 빈 줄 무시
                        String[] logParts = line.split(",", -1); // 로그 항목 분리
                        %>
                        <tr>
                            <% for (String part : logParts) { %>
                                <td><%= part %></td>
                            <% } %>
                        </tr>
                        <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='6'>Error reading log file: " + e.getMessage() + "</td></tr>");
                }
            } else {
                out.println("<tr><td colspan='6'>Log file does not exist or is empty.</td></tr>");
            }
        %>
    </table>
</body>
</html>
