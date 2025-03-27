<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QnA</title>
<link rel="stylesheet" href="/resources/css/my_info/QnA.css">
<link rel="stylesheet" href="/resources/css/my_info/mypage.css">

</head>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<body>

	<main class="myinfo-container">

		<!-- 사이드바 -->
    <jsp:include page="/WEB-INF/views/member/mypage/mypage-sidebar.jsp" />


		<div class="myinfo-content-wrapper">

            <!-- 메인 콘텐츠 -->
            <section class="myinfo-main-content">
                <section class="qa-section" id="ask-section">
                    <h2 class="qa-title">1:1 문의</h2>
                    <p class="qa-count">현재까지 회원님의 문의 내역입니다.</p>
                    <div class="qa-container" id="ask-container">
                    </div>
                </section>
            </section>
        </div>
    </main>


</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="/resources/js/member/mypages.js"></script>
</html>