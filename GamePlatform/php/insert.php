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

<?php 
	// 로그 데이터 추출
	include("./log.php");
	writeLog( "새 게임을 등록합니다" );
?>
