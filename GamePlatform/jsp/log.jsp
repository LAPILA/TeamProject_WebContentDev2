<%@ page import="java.io.*, java.time.*, javax.servlet.http.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
    public void writeLog(String message, HttpServletRequest request, HttpSession session) {

        final String logFileName = "/var/lib/tomcat9/webapps/ROOT/WebContentDev2/GamePlatform/jsp/log.txt";
        File logFile = new File(logFileName);
        boolean isNewFile = !logFile.exists();  //파일 여부 확인

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(logFile, true))) {
            if (isNewFile) {
                //추가(정리)
                writer.append("Date,Time,SessionID,URI,Referer,Browser,Message\n");
            }

            // 엑셀용으로 뽑기
            String logEntry = String.format("\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"\n",
                    LocalDate.now(),
                    LocalTime.now(),
                    session.getId(),
                    escapeCsv(request.getRequestURI()),
                    escapeCsv(request.getHeader("referer")),
                    escapeCsv(request.getHeader("User-Agent")),
                    escapeCsv(message));
            writer.append(logEntry);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private String escapeCsv(String value) {
        return value != null ? "\"" + value.replace("\"", "\"\"") + "\"" : "\"\"";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그 테스트</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
        table { width: 80%; margin: 0 auto; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background-color: #f2f2f2; }
        button { font-size: 16px; padding: 10px 20px; }
    </style>
</head>
<body>
    <h1>로그 테스트 페이지</h1>
    <form method="post" action="log.jsp">
        <button type="submit" name="action" value="logTest">테스트 로그 기록</button>
    </form>
    <%
        String action = request.getParameter("action");
        if ("logTest".equals(action)) {
            writeLog("테스트", request, session);
            out.println("<p>로그가 기록되었습니다: 테스트</p>");
        }
    %>
    <h2>로그 기록</h2>
    <table>
        <thead>
            <tr>
                <th>Date</th>
                <th>Time</th>
                <th>SessionID</th>
                <th>URI</th>
                <th>Referer</th>
                <th>Browser</th>
                <th>Message</th>
            </tr>
        </thead>
        <tbody>
            <%
                final String logFileName = "/var/lib/tomcat9/webapps/ROOT/WebContentDev2/GamePlatform/jsp/log.txt";
                File logFile = new File(logFileName);
                if (logFile.exists()) {
                    try (BufferedReader reader = new BufferedReader(new FileReader(logFile))) {
                        String line;
                        while ((line = reader.readLine()) != null) {
                            if (line.startsWith("Date")) continue; // Skip the header line
                            String[] columns = line.split("\",\"");
                            out.println("<tr>");
                            for (String column : columns) {
                                out.println("<td>" + column.replace("\"", "") + "</td>");
                            }
                            out.println("</tr>");
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </tbody>
    </table>
</body>
</html>
