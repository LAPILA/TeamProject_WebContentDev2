<?php header('Content-Type: text/html; charset=UTF-8'); ?>

<script type="text/javascript">
	// 싹다갈아엎어~~
    alert('<%= request.getAttribute("message") %>'); // 수정된 메시지 표시 방식
    window.location.href = "./search.php"; // 사용자를 search.jsp 페이지로 리다이렉트
</script>