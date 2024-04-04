<?php header('Content-Type: text/html; charset=UTF-8'); ?>

<?php include("./SQLconstants.php"); ?>

<?php 
	// 이전 페이지에서 전달 받은 메시지 확인
	$id = $_POST['id'];

	// MySQL 드라이버 연결 
	include("./SQLconstants.php"); 
	$conn = mysqli_connect($mySQL_host,$mySQL_id,$mySQL_password,$mySQL_database) or die ("Can't access DB");

	// 리뷰 삭제
	$sqlDeleteReviews = "DELETE FROM 리뷰 WHERE 게임ID = ?";
	$pstmt = $con.prepareStatement($sqlDeleteReviews);
	$pstmt.setInt(1, Integer.parseInt($id));
	$pstmt.executeUpdate();
	$pstmt.close();

	// 게임장르 삭제
	$sqlDeleteGameGenres = "DELETE FROM 게임장르 WHERE 게임ID = ?";
	$pstmt = $con.prepareStatement($sqlDeleteGameGenres);
	$pstmt.setInt(1, Integer.parseInt($id));
	$pstmt.executeUpdate();
	$pstmt.close();

	// 구매한게임 삭제
	$sqlDeletePurchases = "DELETE FROM 구매한게임 WHERE 게임ID = ?";
	$pstmt = $con.prepareStatement($sqlDeletePurchases);
	$pstmt.setInt(1, Integer.parseInt($id));
	$pstmt.executeUpdate();
	$pstmt.close();
	
	// 실제 게임 데이터 삭제
	$sqlDeleteGame = "DELETE FROM 게임 WHERE 게임ID = ?";
	$pstmt = $con.prepareStatement($sqlDeleteGame);
	$pstmt.setInt(1, Integer.parseInt($id));
	$rowsAffected = $pstmt.executeUpdate();

	if ($rowsAffected > 0) {
		$message = "게임 ID ".$id."가 성공적으로 삭제되었습니다.";
	} else {
		$message = "해당 게임 ID를 찾을 수 없습니다. 삭제에 실패했습니다.";
	}

	// 이게뭐임
//finally {
	//if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
	//if (con != null) try { con.close(); } catch (SQLException ex) {}
//}

// 메시지가 비어있지 않다면, 메시지를 출력하고 게임 목록 페이지로 리다이렉션합니다.
if (!$message.isEmpty()){
	?>
	<?php include("./log.php"); ?>
	<?php
		// 로그 데이터 추출
		writeLog($message);
	?>

// 와! 무진장 확인필요
	<form name = "frm" method = "post" action = "./gameList.php" >
		<input type = "hidden" name = "message" value = " * <?php echo str_replace("'", "", $message);?>" >
	</form>
	<script language="javascript">
		document.frm.submit();
	</script>

<?php

}

?>




