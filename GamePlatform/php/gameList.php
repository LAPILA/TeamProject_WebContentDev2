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

			$Connection con = null;
			$Statement stmt = null;
			$ResultSet rs = null;

			// mySQL 드라이버 연결
			include("./SQLconstants.php"); 
			$conn = mysqli_connect($mySQL_host,$mySQL_id,$mySQL_password,$mySQL_database) or die ("Can't access DB");

			// SQL 실행 요청 및 실행 결과
			$query = "SELECT 게임ID, 게임명, 가격, 출시일, 이미지URL FROM 게임";
			$rs = $stmt.executeQuery($query);

			// 문자열.문자열 오류 확인해야함
			while ($rs.next()) {
				echo "<tr>"."<td>" + $rs.getInt("게임ID") + "</td>"."<td>".$rs.getString("게임명")."</td>"."<td>".$rs.getFloat("가격")."</td>"."<td>".$rs.getDate("출시일")."</td>"."<td><a href='".$rs.getString("이미지URL")."'>이미지 보기</a></td>"."</tr>";
			}

			// 이게뭐임?
		//finally {
			//if (rs != null) try { rs.close(); } catch (SQLException e) {}
			//if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
			//if (con != null) try { con.close(); } catch (SQLException e) {}
		//}

		?>
	</table>
</body>
</html>



