<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>recruitment_settlement_complete</title>
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css/recruitment/recruitment_settlement_complete.css">

</head>

<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main>
        <div class="settlement-complete-container">
            <!-- 정산 완료 헤더 -->
            <h2 class="settlement-title">정산 완료</h2>
    
            <!-- 메시지 -->
            <p class="settlement-message">모집장이 구매를 완료하면 알려드릴게요!</p>
    
            <!-- 상세정보 보기 버튼 -->
            <button class="details-btn"
                    onclick="location.href='/purchase_in_progress_member?recruitmentNo=${recruitmentNo}&boardNo=${boardNo}'">
                상세정보 보기
            </button>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <c:if test="${not empty alertMessage}">
        <script>
            alert("${alertMessage}");
        </script>
    </c:if>
</body>

</html>