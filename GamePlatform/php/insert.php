<?php header('Content-Type: text/html; charset=UTF-8'); ?>
<HTML>

<head>
    <title>게임 등록</title>
</head>

<body>
    <h2>게임 등록</h2>
    <form name = "formm" method = "post" action = "./insertSQL.php">
        게임명: <input type="text" name="game_name" required><br>
        가격: <input type="text" name="price" required><br>
        개발사 ID: <input type="number" name="developer_id" required><br>
        장르: <input type="text" name="genre" ><br>
        출시일: <input type="date" name="release_date" required><br>
        이미지 URL: <input type="text" name="image_url"><br>
        <input type="submit" value="추가">
    </form>
</body>
</html>
	<BODY>
		<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
		<b> - 새 책 등록 - </b>
		<br> 
		<form name = "formm" method = "post" action = "./insertSQL.php">				
			<br> I &nbsp; &nbsp; D &nbsp;:  <INPUT TYPE = "text" name = "id" SIZE="60" >
			<br> 제 &nbsp; 목 : <INPUT TYPE = "text" NAME = "title" SIZE="60" >
			<br> 저 &nbsp; 자 : <INPUT TYPE = "text" NAME = "author" SIZE="60" >
			<br> 출판사 : <INPUT TYPE = "text" NAME = "publisher" SIZE="60" >
			<br> 출판일 : <INPUT TYPE = "text" NAME = "date" SIZE="60" >
			<br> 이미지 : <INPUT TYPE = "text" NAME = "image" SIZE="60" >
		</form>  
		&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
		<INPUT TYPE="button" value="등록" onClick="javascript:document.formm.submit();"> &nbsp; 
	</BODY>
</HTML>

<?php 
	// 로그 데이터 추출
	include("./log.php");
	writeLog( "새 책을 등록합니다" );
?>
