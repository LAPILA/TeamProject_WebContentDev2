<?php
header('Content-Type: text/html; charset=UTF-8');

// 데이터베이스 연결 정보를 가져옵니다.
include("./SQLconstants.php");

// 폼 데이터에서 전달 받은 값들을 변수에 저장합니다.
$gameName = $_POST['game_name'];
$price = $_POST['price'];
$developerID = $_POST['developer_id'];
$systemRequirement = $_POST['system_requirement']; 
$genre = $_POST['genre'];
$releaseDate = $_POST['release_date'];
$imageUrl = $_POST['image_url'];
$message = "";

// 데이터베이스에 연결을 시도합니다.
$conn = mysqli_connect($mySQL_host, $mySQL_id, $mySQL_password, $mySQL_database);
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// 게임 정보를 추가하는 쿼리를 준비하고 실행합니다.
$query = "INSERT INTO 게임 (게임명, 가격, 개발사ID, 시스템사양, 장르, 출시일, 이미지URL) VALUES (?, ?, ?, ?, ?, ?, ?)";
$stmt = mysqli_prepare($conn, $query);
mysqli_stmt_bind_param($stmt, "sdissss", $gameName, $price, $developerID, $systemRequirement, $genre, $releaseDate, $imageUrl);

if (mysqli_stmt_execute($stmt)) {
    $message = "게임('" . $gameName . "')이(가) 성공적으로 추가되었습니다.";
} else {
    $message = "게임 추가에 실패했습니다. Error: " . mysqli_error($conn);
}

// 사용한 자원을 해제하고 데이터베이스 연결을 닫습니다.
mysqli_stmt_close($stmt);
mysqli_close($conn);

// 로그 데이터를 기록합니다.
include("./log.php");
writeLog($message);

// 메시지를 다음 페이지로 전달하고, 사용자를 해당 페이지로 리다이렉트합니다.
?>
<form name="frm" method="post" action="./search.php">
    <input type="hidden" name="message" value=" * <?php echo htmlspecialchars($message); ?>">
</form>
<script language="javascript">
    document.frm.submit();
</script>
