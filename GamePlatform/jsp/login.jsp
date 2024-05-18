<%@ page import="java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 로그 기록을 위한 파라미터 가져오기 및 null 체크
    String 게임ID = (request.getAttribute("게임ID") != null) ? request.getAttribute("게임ID").toString() : "N/A";
    String 게임명 = (request.getAttribute("게임명") != null) ? request.getAttribute("게임명").toString() : "N/A";
    String 개발사명 = (request.getAttribute("개발사명") != null) ? request.getAttribute("개발사명").toString() : "N/A";
    String 시스템사양 = (request.getAttribute("시스템사양") != null) ? request.getAttribute("시스템사양").toString() : "N/A";
    String 연령등급 = (request.getAttribute("연령등급") != null) ? request.getAttribute("연령등급").toString() : "N/A";
    String 가격 = (request.getAttribute("가격") != null) ? request.getAttribute("가격").toString() : "N/A";
    String 출시일 = (request.getAttribute("출시일") != null) ? request.getAttribute("출시일").toString() : "N/A";
    String 이미지URL = (request.getAttribute("이미지URL") != null) ? request.getAttribute("이미지URL").toString() : "N/A";

    FileWriter fileWriter = null;
    BufferedWriter bufferedWriter = null;

    try {
        // 로그 파일 경로 설정 및 추가 모드로 기록
        String logFilePath = application.getRealPath("/") + "log.txt";
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
%>
