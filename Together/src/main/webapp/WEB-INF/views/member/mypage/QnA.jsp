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
                <section class="qa-section">
                    <h2 class="qa-title">Q&A</h2>
                    <p class="qa-count">최근 3개월동안의 내역 제공됩니다.</p>
                    <div class="qa-container">
                        <div class="qa-item">
                            <a href="#" class="qa-link">
                                <img src="로쉐.png" alt="초콜릿" class="qa-img">
                            </a>
                            <div class="qa-info">
                                <p class="qa-title"><a href="#">[스마트스토어] 프리미엄 로쉐 초콜릿</a></p>
                                <p class="qa-category">카테고리: 초콜릿 바</p>
                                <p class="qa-answers">답변수: 2개</p>
                                <button class="qa-btn">답변 보기</button>
                            </div>
                        </div>
                        
                        <div class="qa-item">
                            <a href="#" class="qa-link">
                                <img src="로쉐.png" alt="초콜릿" class="qa-img">
                            </a>
                            <div class="qa-info">
                                <p class="qa-title"><a href="#">[스마트스토어] 프리미엄 로쉐 초콜릿</a></p>
                                <p class="qa-category">카테고리: 초콜릿 바</p>
                                <p class="qa-answers">답변수: 3개</p>
                                <button class="qa-btn">답변 보기</button>
                            </div>
                        </div>
                        
                        <div class="qa-item">
                            <a href="#" class="qa-link">
                                <img src="로쉐.png" alt="초콜릿" class="qa-img">
                            </a>
                            <div class="qa-info">
                                <p class="qa-title"><a href="#">[스마트스토어] 프리미엄 로쉐 초콜릿</a></p>
                                <p class="qa-category">카테고리: 초콜릿 바</p>
                                <p class="qa-answers">답변수: 1개</p>
                                <button class="qa-btn">답변 보기</button>
                            </div>
                        </div>
                    </div>
                </section>
            </section>
        </div>
    </main>


</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="/resources/js/member/mypages.js"></script>
</html>