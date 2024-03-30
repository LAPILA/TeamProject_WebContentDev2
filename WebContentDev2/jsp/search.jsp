<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <title>게임 관리 시스템</title>
    <script language="javascript">
        // 전달받은 메시지 출력
        function showMessage(message) {
            if ((message != null) && (message != "") && (message.substring(0, 3) == " * ")) {
                alert(message);
            }
        }

        // 지정한 url로 이동하는 함수
        function move(url) {
            document.formm.action = url;
            document.formm.submit();
        }
    </script>
</head>
<body onLoad="showMessage('<%=request.getParameter("message")%>');">
    <!-- 화면 구성 -->
    <br>
    <form name="formm" method="post">
        &nbsp; &nbsp; &nbsp; 게임 제목: <input type="text" name="message" size="60">
    </form>
    &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    <input type="button" value="게임 제목 검색" onClick="javascript:move('./searchGame.jsp');">
    <input type="button" value="새 게임 추가" onClick="javascript:move('./insertGame.jsp');">
    <input type="button" value="게임 삭제" onClick="javascript:move('./deleteGame.jsp');">
    <br> <br> &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

    <!-- 게임 목록 출력 -->
    <%@ include file="./selectGameSQL.jsp"%>
</body>
</html>
