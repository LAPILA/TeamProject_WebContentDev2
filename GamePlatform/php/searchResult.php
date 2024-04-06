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
    $searchQuery = isset($_POST['searchQuery']) ? trim($_POST['searchQuery']) : "";
    $searchQuery = $searchQuery ? "%" . $searchQuery . "%" : "%";

    include("./SQLconstants.php");
    $conn = mysqli_connect($mySQL_host, $mySQL_id, $mySQL_password, $mySQL_database);

    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }

    $query = "SELECT 게임ID, 게임명, 가격, 출시일, 이미지URL FROM 게임 WHERE 게임명 LIKE ?";
    $stmt = mysqli_prepare($conn, $query);

    mysqli_stmt_bind_param($stmt, "s", $searchQuery);

    mysqli_stmt_execute($stmt);

    $result = mysqli_stmt_get_result($stmt);

    while ($row = mysqli_fetch_assoc($result)) {
        echo "<div class='game-info'>";
        echo "<strong>게임 제목:</strong> " . htmlspecialchars($row['게임명']) . "<br>";
        echo "<strong>가격:</strong> " . htmlspecialchars($row['가격']) . "<br>";
        echo "<strong>출시일:</strong> " . htmlspecialchars($row['출시일']) . "<br>";
        echo "<img src='" . htmlspecialchars($row['이미지URL']) . "' height='150' width='auto'>";
        echo "</div>";
    }

    mysqli_stmt_close($stmt);
    mysqli_close($conn);
    ?>
</body>
</html>
