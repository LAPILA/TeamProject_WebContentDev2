<?php header('Content-Type: text/html; charset=UTF-8'); ?>
<?php 
    // 이전 페이지에서 전달 받은 검색 쿼리 확인
    $searchQuery = $_POST['searchQuery'] ?? '%'; 
    $searchQuery = "%$searchQuery%"; 

    // MySQL 드라이버 연결
    include("./SQLconstants.php");
    $conn = mysqli_connect($mySQL_host, $mySQL_id, $mySQL_password, $mySQL_database) or die("Can't access DB");

    // 게임 검색 실행 및 결과 출력
    $query = "SELECT g.게임ID, g.게임명, g.가격, g.출시일, g.이미지URL, g.시스템사양, g.연령등급, d.개발사명
              FROM 게임 g
              JOIN 개발사 d ON g.개발사ID = d.개발사ID
              WHERE g.게임명 LIKE ?";
    $stmt = mysqli_prepare($conn, $query);
    mysqli_stmt_bind_param($stmt, "s", $searchQuery);
    mysqli_stmt_execute($stmt);
    $resultSet = mysqli_stmt_get_result($stmt);

    while ($result = mysqli_fetch_array($resultSet)) {
        echo "\n<BR>게임ID: ".$result['게임ID'];
        echo "\n<BR>게임명: ".$result['게임명'];
        echo "\n<BR>가격: ".$result['가격'];
        echo "\n<BR>출시일: ".$result['출시일'];
        echo "\n<BR>시스템사양: ".$result['시스템사양'];
        echo "\n<BR>연령등급: ".$result['연령등급'];
        echo "\n<BR>개발사명: ".$result['개발사명'];
        echo "\n<BR><img src='".$result['이미지URL']."' height='280' width='180'><br>";
    }

    // MySQL 드라이버 연결 해제
    mysqli_free_result($resultSet);
    mysqli_close($conn);
?>

<?php
    // 로그 데이터 추출
    include("./log.php");
    writeLog($searchQuery."와(과) 관련된 게임을 찾았습니다.");
?>
