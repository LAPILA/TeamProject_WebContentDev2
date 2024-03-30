<%@ page import="java.io.*, java.time.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
public void writeLog(String message, HttpServletRequest request, HttpSession session) {
    try {
        // 로그 파일 경로 지정
        final String logFileName = "/usr/local/tomcat/webapps/ROOT/WebContentDev2/jsp/log.txt";
        
        // BufferedWriter를 사용하여 파일에 데이터를 추가 모드로 쓰기
        BufferedWriter writer = new BufferedWriter(new FileWriter(logFileName, true));
        
        // 로그에 기록될 정보 구성
        writer.append("\nTime:\t" + LocalDate.now() + " " + LocalTime.now()
            + "\tSessionID:\t" + session.getId()
            + "\tURI:\t" + request.getRequestURI()
            + "\tPrevious:\t" + request.getHeader("referer")
            + "\tBrowser:\t" + request.getHeader("User-Agent")
            + "\tMessage:\t" + message);
        
        writer.close(); // BufferedWriter 닫기
    } catch (IOException e) {
        e.printStackTrace();
    }
}
%>
