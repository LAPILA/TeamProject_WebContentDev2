<%@ page import="java.io.*, java.time.*, javax.servlet.http.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
    public void writeLog(String message, HttpServletRequest request, HttpSession session) {
        final String logFileName = "/var/lib/tomcat9/webapps/ROOT/WebContentDev2/GamePlatform/jsp/log.txt";
        File logFile = new File(logFileName);
        boolean isNewFile = !logFile.exists();  // 파일 여부 확인

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(logFile, true))) {
            if (isNewFile) {
                // 추가(정리)
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>로그 기록</title>
</head>
<body>
    <h2>로그 기록</h2>
    <form method="post" action="log.jsp">
        <input type="hidden" name="action" value="test">
        <button type="submit">테스트 로그 추가</button>
    </form>

    <%
        if ("test".equals(request.getParameter("action"))) {
            writeLog("테스트", request, session);
        }

        final String logFileName = "/var/lib/tomcat9/webapps/ROOT/WebContentDev2/GamePlatform/jsp/log.txt";
        try (BufferedReader reader = new BufferedReader(new FileReader(logFileName))) {
            String line;
            while ((line = reader.readLine()) != null) {
                out.println(line + "<br>");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    %>
</body>
</html>
