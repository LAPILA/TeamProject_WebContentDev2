<?php header('Content-Type: text/html; charset=UTF-8'); ?>

<?php include("./SQLconstants.php"); ?>

<?php 
	// 이전 페이지에서 전달 받은 메시지 확인
	$gameName = $_POST['gameName'];
	$price = $_POST['price'];
	$developerID = $_POST['developerID'];
	$genre = $_POST['genre'];
	$releaseDate = $_POST['releaseDate'];
	$imageUrl = $_POST['imageUrl'];

	// MySQL 드라이버 연결 
	include("./SQLconstants.php"); 
	$con = mysqli_connect($mySQL_host,$mySQL_id,$mySQL_password,$mySQL_database) or die ("Can't access DB");

	$pstmt = $con.prepareStatement("INSERT INTO 게임 (게임명, 가격, 개발사ID, 장르, 출시일, 이미지URL) VALUES (?, ?, ?, ?, ?, ?)")
            
		$pstmt.setString(1, $gameName);
		$pstmt.setFloat(2, Float.parseFloat($price));
		$pstmt.setInt(3, Integer.parseInt($developerId));
		$pstmt.setString(4, $genre);
		// java.sql.Date 처리?
		$pstmt.setDate(5, java.sql.Date.valueOf($releaseDate));
		$pstmt.setString(6, $imageUrl);

		$rowsAffected = $pstmt.executeUpdate();
		if ($rowsAffected > 0) {
			$message = "게임('".$gameName."')이(가) 성공적으로 추가되었습니다.";
		} else {
			$message = "게임 추가에 실패했습니다.";
		}

// finally 어쩌구 추가해야하면 여기다 추가


