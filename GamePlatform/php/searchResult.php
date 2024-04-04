<?php header('Content-Type: text/html; charset=UTF-8'); ?>

<html>
<head>
    <title>검색 결과</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .game-info { margin-bottom: 20px; border-bottom: 1px solid #ccc; padding-bottom: 10px; }
        img { margin-top: 10px; height: 150px; width: auto; }
    </style>
</head>

<body>
    <h2>검색 결과</h2>
    <?php

	// 이전 페이지에서 전달 받은 메시지 확인
	$searchQuery =  $_POST['searchQuery'];
	$searchQuery = ( ( $searchQuery == null ) || ( $searchQuery == "" ) ) ? "%" : $searchQuery.trim();

	include("./SQLconstants.php"); 
	$con = mysqli_connect($mySQL_host,$mySQL_id,$mySQL_password,$mySQL_database) or die ("Can't access DB");
	$query = "SELECT 게임ID, 게임명, 가격, 출시일, 이미지URL FROM 게임 WHERE 게임명 LIKE ?";
    $pstmt = $con.prepareStatement($query);
    $pstmt.setString(1, "%".$searchQuery."%");
    $rs = $pstmt.executeQuery();

	while ($rs.next()) {
		echo "<div class='game-info'>"."<strong>게임 제목:</strong> ".$rs.getString("게임명")."<br><strong>가격:</strong> ".$rs.getFloat("가격")."<br><strong>출시일:</strong> ".$rs.getDate("출시일").toString()."<br><img src='".$rs.getString("이미지URL")."' height='150' width='auto'>"."</div>";
	}

// finally 어쩌구 알제

	?>
</body>
</html>
