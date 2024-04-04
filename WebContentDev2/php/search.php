<?php header('Content-Type: text/html; charset=UTF-8'); ?>
<!DOCTYPE html>
<HTML>
	<HEAD>      
	<title>게임 관리 시스템</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #dddddd; text-align: left; padding: 8px; }
        th { background-color: #f2f2f2; }
    </style>
		<script language="javascript">
			// 전달받은 메시지 출력
			function showMessage( message )
			{
				if ( ( message != null ) && ( message != "" ) && ( message.substring( 0, 3 ) == " * " )  ) 
				{
					alert( message );
				}
			}     
			// 지정한 url로 이동하는 함수 
			function move( url )	
	 		{
				document.formm.action = url;
				document.formm.submit();
			}
		</script>
	</HEAD>

	<BODY onLoad="showMessage( '' );" >
	<img src="img/로고 초안.png">
		<!-- 화면구성 -->

		<form name = "formm" method = "post" action="./searchResult.php">
			<input type="text" name="searchQuery" size="60">
        	<input type="submit" value="게임 제목 검색">
		</form> 
		</br>
		<button onClick="window.location='./insert.php';">새 게임 추가</button>
   		<button onClick="window.location='./delete.php';">게임 삭제</button>

		<?php include("./selectSQL.php"); ?>

</BODY>
</HTML>