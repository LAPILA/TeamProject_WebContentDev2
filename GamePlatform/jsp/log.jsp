<%@ page import="java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <th>Time</th>
            <th>SessionID</th>
            <th>URI</th>
            <th>Referer</th>
            <th>Browser</th>
            <th>Message</th>
        </tr>
        <%
            String logFileName = "/var/lib/tomcat9/webapps/ROOT/WebContentDev2/GamePlatform/jsp/log.txt"; // 파일 경로
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
                out.println("<tr><td colspan='7'>Log file does not exist.</td></tr>");
            }
        %>
    </table>
</body>
</html>
