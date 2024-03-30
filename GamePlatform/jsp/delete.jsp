<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>게임 삭제</title>
    <script>
        // 삭제할 게임 ID 입력 유효성 검사
        function validateForm() {
            var x = document.forms["formm"]["id"].value;
            if (x == "" || isNaN(x)) {
                alert("유효한 게임 ID를 입력해주세요.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <br>
    <form name="formm" method="post" action="./deleteSQL.jsp" onsubmit="return validateForm()">
        삭제할 게임 ID: <input type="text" name="id" size="60">
        <input type="submit" value="삭제">
    </form>
    <br><br>
</body>
</html>
