<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>새 게임 등록</title>
</head>
<body>
    <b> - 새 게임 등록 - </b>
    <form name="formm" method="post" action="insertSQL.jsp">
        <br> 게임 이름: <input type="text" name="game_name" size="60">
        <br> 개발자: <input type="text" name="developer" size="60">
        <br> 가격: <input type="text" name="price" size="60">
        <br> 장르: <input type="text" name="genre" size="60">
        <br> 출시일: <input type="text" name="release_date" size="60">
        <br> 이미지 URL: <input type="text" name="image_url" size="60">
        <br><input type="submit" value="등록">
    </form>
</body>
</html>
