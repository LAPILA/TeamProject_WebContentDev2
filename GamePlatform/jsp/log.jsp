<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String 게임ID = request.getAttribute("게임ID").toString();
    String 게임명 = request.getAttribute("게임명").toString();
    String 개발사명 = request.getAttribute("개발사명").toString();
    String 시스템사양 = request.getAttribute("시스템사양").toString();
    String 연령등급 = request.getAttribute("연령등급").toString();
    String 가격 = request.getAttribute("가격").toString();
    String 출시일 = request.getAttribute("출시일").toString();
    String 이미지URL = request.getAttribute("이미지URL").toString();

    FileWriter fileWriter = null;
    BufferedWriter bufferedWriter = null;

    try {
        // 로그 파일에 추가 모드로 기록
        fileWriter = new FileWriter(application.getRealPath("/") + "log.txt", true);
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
