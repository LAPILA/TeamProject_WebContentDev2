<?php
header('Content-Type: text/html; charset=UTF-8');
include("./SQLconstants.php");

$gameName = $_POST['game_name'];
$price = floatval($_POST['price']); // 가격을 실수로 변환
$developerID = intval($_POST['developer_id']); // 개발사 ID를 정수로 변환
$systemRequirement = $_POST['system_requirement']; 
$genre = $_POST['genre'];
$releaseDate = $_POST['release_date'];
$imageUrl = $_POST['image_url'];

$conn = mysqli_connect($mySQL_host, $mySQL_id, $mySQL_password, $mySQL_database);
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "INSERT INTO 게임 (게임명, 가격, 개발사ID, 시스템사양, 장르, 출시일, 이미지URL) VALUES (?, ?, ?, ?, ?, ?, ?)";
$stmt = mysqli_prepare($conn, $query);

mysqli_stmt_bind_param($stmt, "sdissss", $gameName, $price, $developerID, $systemRequirement, $genre, $releaseDate, $imageUrl);

if (mysqli_stmt_execute($stmt)) {
    $message = "게임('" . $gameName . "')이(가) 성공적으로 추가되었습니다.";
} else {
    $message = "게임 추가에 실패했습니다. Error: " . mysqli_error($conn);
}

mysqli_stmt_close($stmt);
mysqli_close($conn);

include("./log.php");
writeLog($message);

echo "<script>alert('$message');</script>";
echo "<script>window.location.href='./gameList.php';</script>";
?>

<form name="frm" method="post" action="./gameList.php">
    <input type="hidden" name="message" value="<?php echo htmlspecialchars($message); ?>">
</form>
<script language="javascript">
    document.frm.submit();
</script>
