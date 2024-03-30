<%-- 메시지를 표시하는 JSP 파일 --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    alert('<%= request.getAttribute("message") %>'); // 수정된 메시지 표시 방식
    window.location.href = "./search.jsp"; // 사용자를 search.jsp 페이지로 리다이렉트
</script>
