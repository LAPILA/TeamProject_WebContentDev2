<?php header('Content-Type: text/html; charset=UTF-8'); ?>

<?php include("./SQLconstants.php"); ?>

<html>
	<head>
    <title>게임 목록</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #dddddd; text-align: left; padding: 8px; }
        th { background-color: #f2f2f2; }
    </style>
</head>

<body>
    <h2>게임 목록</h2>
    <table>
        <tr>
            <th>게임ID</th>
            <th>게임명</th>
            <th>가격</th>
            <th>출시일</th>
            <th>이미지 URL</th>
        </tr>
        <?php
        // MySQL 드라이버 연결
        $conn = mysqli_connect($mySQL_host, $mySQL_id, $mySQL_password, $mySQL_database);
        if (!$conn) {
            die("Connection failed: " . mysqli_connect_error());
        }

        // SQL 쿼리 실행
        $query = "SELECT 게임ID, 게임명, 가격, 출시일, 이미지URL FROM 게임";
        $result = mysqli_query($conn, $query);

        // 결과를 HTML 테이블에 출력
        while($row = mysqli_fetch_assoc($result)) {
            echo "<tr>";
            echo "<td>" . $row["게임ID"] . "</td>";
            echo "<td>" . $row["게임명"] . "</td>";
            echo "<td>" . $row["가격"] . "</td>";
            echo "<td>" . $row["출시일"] . "</td>";
            echo "<td><a href='" . $row["이미지URL"] . "'>이미지 보기</a></td>";
            echo "</tr>";
        }

        // 자원 해제
        mysqli_free_result($result);
        mysqli_close($conn);
        ?>
	</table>
</body>
</html>



