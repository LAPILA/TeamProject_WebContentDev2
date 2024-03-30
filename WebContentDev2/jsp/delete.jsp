<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>게임 삭제</title>
</head>
<body>
    <br>
    <form name="formm" method="post" action="./deleteSQL.jsp">
        삭제할 게임 ID: <input type="text" name="id" size="60">
        <input type="button" value="삭제" onClick="javascript:document.formm.submit();">
    </form>
    <br><br>

    <!-- 삭제 후보 게임 목록 출력 -->
    <%@ include file="./selectSQL.jsp" %>
</body>
</html>
