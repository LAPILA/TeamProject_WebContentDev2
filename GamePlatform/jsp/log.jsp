<%@ page import="java.io.*, java.time.*, javax.servlet.http.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
    public void writeLog(String message, HttpServletRequest request, HttpSession session) {
        final String logFileName = "/var/lib/tomcat9/webapps/ROOT/WebContentDev2/GamePlatform/jsp/log.txt";
        File logFile = new File(logFileName);
        boolean isNewFile = !logFile.exists();

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(logFile, true))) {
            if (isNewFile) {
                writer.append("Date,Time,SessionID,URI,Referer,Browser,Message\n");
            }
            String logEntry = String.format("%s,%s,%s,%s,%s,%s,%s\n",
                    LocalDate.now(),
                    LocalTime.now(),
                    session.getId(),
                    request.getRequestURI(),
                    request.getHeader("referer"),
                    request.getHeader("User-Agent"),
                    message);
            writer.append(logEntry);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
%>

<html>
<head>
    <title>Log Page</title>
    <style>
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
            padding: 5px;
            text-align: left;
        }
    </style>
</head>
<body>
    <h1>Log Details</h1>
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
            try (BufferedReader reader = new BufferedReader(new FileReader(logFileName))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] logParts = line.split(",");
                    out.print("<tr>");
                    for (String part : logParts) {
                        out.print("<td>" + part + "</td>");
                    }
                    out.print("</tr>");
                }
            } catch (Exception e) {
                out.println("<p>Error reading log file: " + e.getMessage() + "</p>");
            }
        %>
    </table>
</body>
</html>
