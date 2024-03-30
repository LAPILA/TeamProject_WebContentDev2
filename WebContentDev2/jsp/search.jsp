<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <title>게임 관리 시스템</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #dddddd; text-align: left; padding: 8px; }
        th { background-color: #f2f2f2; }
    </style>
    <script language="javascript">
        // 전달받은 메시지 출력
        function showMessage(message) {
            if (message != null && message != "" && message.substring(0, 3) == " * ") {
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
    <h2>게임 검색</h2>
    <form name="formm" method="post" action="./searchResult.jsp">
        게임 제목: <input type="text" name="searchQuery" size="60">
        <input type="submit" value="게임 제목 검색">
    </form>
    <br>
    <button onClick="window.location='./insert.jsp';">새 게임 추가</button>
    <button onClick="window.location='./delete.jsp';">게임 삭제</button>

    <!-- 검색 결과를 표시할 부분 (selectSQL.jsp는 검색 결과를 출력하는 로직을 포함해야 함) -->
    <%-- 게임 목록 출력 --%>
    <%@ include file="./selectSQL.jsp"%>
</body>
</html>
