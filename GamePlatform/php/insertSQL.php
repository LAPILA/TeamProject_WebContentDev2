<?php
header('Content-Type: text/html; charset=UTF-8');

// 데이터베이스 연결 정보 포함
include("./SQLconstants.php");

// 폼 데이터에서 전달 받은 값
$gameName = $_POST['game_name'];
$price = $_POST['price'];
$developerId = $_POST['developer_id'];
$genre = $_POST['genre'];
$releaseDate = $_POST['release_date'];
$imageUrl = $_POST['image_url'];
$message = "";

// 데이터베이스에 연결
$conn = mysqli_connect($mySQL_host, $mySQL_id, $mySQL_password, $mySQL_database);
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// 트랜잭션 시작
mysqli_begin_transaction($conn);

try {
    // 게임 정보 삽입 쿼리 준비
    $query = "INSERT INTO 게임 (게임명, 가격, 개발사ID, 출시일, 이미지URL) VALUES (?, ?, ?, ?, ?)";
    $stmt = mysqli_prepare($conn, $query);
    mysqli_stmt_bind_param($stmt, "sdis", $gameName, $price, $developerId, $releaseDate, $imageUrl);
    
    // 쿼리 실행
    mysqli_stmt_execute($stmt);
    $gameId = mysqli_insert_id($conn); // 생성된 게임 ID 얻기

    // 장르 정보 추가 (장르와 게임ID가 유효한 경우)
    if (!empty($genre) && $gameId != 0) {
        $queryGenre = "INSERT INTO 게임장르 (게임ID, 장르명) VALUES (?, ?)";
        $stmtGenre = mysqli_prepare($conn, $queryGenre);
        mysqli_stmt_bind_param($stmtGenre, "is", $gameId, $genre);
        mysqli_stmt_execute($stmtGenre);
        mysqli_stmt_close($stmtGenre);
    }

    // 트랜잭션 커밋
    mysqli_commit($conn);
    $message = "게임('" . $gameName . "')이(가) 성공적으로 추가되었습니다.";
} catch (Exception $e) {
    // 오류 발생 시 트랜잭션 롤백
    mysqli_rollback($conn);
    $message = "게임 추가에 실패했습니다. 오류: " . $e->getMessage();
} finally {
    mysqli_stmt_close($stmt);
    mysqli_close($conn);
}

// 로그 데이터 추출 및 기록
include("./log.php");
writeLog($message);

// 메시지 전달을 위한 자바스크립트
echo "<script>alert('" . $message . "');</script>";
echo "<script>window.location.href = 'gameList.php';</script>";
?>
