<?php 
header('Content-Type: text/html; charset=UTF-8');

// MySQL 드라이버 연결 
include("./SQLconstants.php"); 
$conn = mysqli_connect($mySQL_host, $mySQL_id, $mySQL_password, $mySQL_database) or die("Can't access DB");

// 이전 페이지에서 전달 받은 게임 ID 확인
$id = $_POST['id'];

// 리뷰, 게임장르, 구매한 게임 삭제 및 게임 데이터 삭제 쿼리 실행
$sqlDeleteReviews = "DELETE FROM 리뷰 WHERE 게임ID = ?";
$sqlDeleteGameGenres = "DELETE FROM 게임장르 WHERE 게임ID = ?";
$sqlDeletePurchases = "DELETE FROM 구매한게임 WHERE 게임ID = ?";
$sqlDeleteGame = "DELETE FROM 게임 WHERE 게임ID = ?";

// Prepared statement를 사용하여 SQL 쿼리 실행
$stmt = mysqli_prepare($conn, $sqlDeleteReviews);
mysqli_stmt_bind_param($stmt, "i", $id);
mysqli_stmt_execute($stmt);

$stmt = mysqli_prepare($conn, $sqlDeleteGameGenres);
mysqli_stmt_bind_param($stmt, "i", $id);
mysqli_stmt_execute($stmt);

$stmt = mysqli_prepare($conn, $sqlDeletePurchases);
mysqli_stmt_bind_param($stmt, "i", $id);
mysqli_stmt_execute($stmt);

$stmt = mysqli_prepare($conn, $sqlDeleteGame);
mysqli_stmt_bind_param($stmt, "i", $id);
$rowsAffected = mysqli_stmt_execute($stmt);

// 삭제 결과에 따른 메시지 설정
if ($rowsAffected) {
    $message = "게임 ID ".$id."가 성공적으로 삭제되었습니다.";
} else {
    $message = "해당 게임 ID를 찾을 수 없습니다. 삭제에 실패했습니다.";
}

// 로그 데이터 추출 및 기록
include("./log.php");
writeLog($message);

// 메시지 전달을 위한 HTML 폼
?>
<form name="frm" method="post" action="./gameList.php">
    <input type="hidden" name="message" value="<?php echo htmlspecialchars($message); ?>">
</form>
<script language="javascript">
    document.frm.submit();
</script>
