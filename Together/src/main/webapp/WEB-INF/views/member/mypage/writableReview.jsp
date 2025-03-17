<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WritableReview</title>
<link rel="stylesheet" href="/resources/css/my_info/WritableReview.css">
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
                <section class="writable-reviews-section">
                    <h2 class="review-title">작성 가능한 리뷰</h2>
                    <p class="review-count">리뷰 3개</p>
                    <div class="review-container">
                        <div class="review-item">
                            <a href="#" class="review-link">
                                <img src="로쉐.png" alt="초콜릿" class="review-img">
                            </a>
                            <div class="review-info">
                                <p class="review-title"><a href="#">[다크초콜릿] 프리미엄 로쉐 초콜릿</a></p>
                                <p class="review-category">카테고리: 식품</p>
                                <p class="review-date">구매일자: 2025.02.10</p>
                            </div>
                            <button class="write-review-btn">리뷰쓰기</button>
                        </div>
                        
                        <div class="review-item">
                            <a href="#" class="review-link">
                                <img src="로쉐.png" alt="초콜릿" class="review-img">
                            </a>
                            <div class="review-info">
                                <p class="review-title"><a href="#">[다크초콜릿] 프리미엄 로쉐 초콜릿</a></p>
                                <p class="review-category">카테고리: 식품</p>
                                <p class="review-date">구매일자: 2025.02.10</p>
                            </div>
                            <button class="write-review-btn">리뷰쓰기</button>
                        </div>
                        
                        <div class="review-item">
                            <a href="#" class="review-link">
                                <img src="로쉐.png" alt="초콜릿" class="review-img">
                            </a>
                            <div class="review-info">
                                <p class="review-title"><a href="#">[다크초콜릿] 프리미엄 로쉐 초콜릿</a></p>
                                <p class="review-category">카테고리: 식품</p>
                                <p class="review-date">구매일자: 2025.02.10</p>
                            </div>
                            <button class="write-review-btn">리뷰쓰기</button>
                        </div>
                    </div>
                </section>
                
            </section>
        </div>
    </main>


</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</html>