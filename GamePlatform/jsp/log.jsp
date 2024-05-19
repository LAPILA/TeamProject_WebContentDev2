<%@ page import="java.io.*, java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%!
// 로그 메시지 기록 메서드
public void writeLog(String message, HttpServletRequest request) {
    String logFileName = "/var/lib/tomcat9/webapps/ROOT/WebContentDev2/GamePlatform/jsp/log.txt";
    try (BufferedWriter writer = new BufferedWriter(new FileWriter(logFileName, true))) {
        String logEntry = String.format("%s, %s, %s, %s, %s, %s, %s\n",
                new Date(),
                request.getSession().getId(),
                request.getRequestURI(),
                request.getHeader("referer") != null ? request.getHeader("referer") : "No referer",
                request.getHeader("User-Agent"),
                message);
        writer.write(logEntry);
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
            String logFileName = "/var/lib/tomcat9/webapps/ROOT/WebContentDev2/GamePlatform/jsp/log.txt";
            File file = new File(logFileName);
            if (file.exists()) {
                try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        if (line.trim().isEmpty()) continue;
                        String[] logParts = line.split(",", -1);
                        %>
                        <tr>
                            <% for (String part : logParts) { %>
                                <td><%= part %></td>
                            <% } %>
                        </tr>
                        <%
                    }
                } catch (Exception e) {
                    out.println("Error reading log file: " + e.getMessage());
                }
            } else {
                out.println("<tr><td colspan='6'>Log file does not exist.</td></tr>");
            }
        %>
    </table>
</body>
</html>
