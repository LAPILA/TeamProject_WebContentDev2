<?php header('Content-Type: text/html; charset=UTF-8'); ?>

<?php include("./SQLconstants.php"); ?>

<?php
// 폼 데이터에서 게임 정보를 받아옵니다.
$gameName = $_POST['game_name'];
$price = $_POST['price'];
$developerID = $_POST['developer_id'];
$genre = $_POST['genre'];
$releaseDate = $_POST['release_date'];
$imageUrl = $_POST['image_url'];

// 데이터베이스에 연결
$conn = mysqli_connect($mySQL_host, $mySQL_id, $mySQL_password, $mySQL_database);
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// 쿼리를 준비
$query = "INSERT INTO 게임 (게임명, 가격, 개발사ID, 장르, 출시일, 이미지URL) VALUES (?, ?, ?, ?, ?, ?)";
$stmt = mysqli_prepare($conn, $query);

// 쿼리 실행
mysqli_stmt_bind_param($stmt, "sdisss", $gameName, $price, $developerID, $genre, $releaseDate, $imageUrl);
$result = mysqli_stmt_execute($stmt);

if ($result) {
    $message = "게임('" . $gameName . "')이(가) 성공적으로 추가되었습니다.";
} else {
    $message = "게임 추가에 실패했습니다. Error: " . mysqli_error($conn);
}

// 데이터베이스 연결을 닫기
mysqli_stmt_close($stmt);
mysqli_close($conn);
?>


<?php 
	// 로그 데이터 추출
	include("./log.php");
	writeLog($message);
?>

<!-- 다음 페이지로 메시지 전달 -->
<form name="frm" method="post" action="./search.php">
	<input type='hidden' name='message' value='<?php echo $message; ?>'>
</form>
<script language="javascript">
	document.frm.submit();
</script>
