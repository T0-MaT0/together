<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Wishlist</title>
<link rel="stylesheet" href="/resources/css/my_info/Wishlist.css">
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
                <section class="wishlist-section">
                    <h2>찜한 상품</h2>
                    <div class="wishlist-container">
                        <div class="wishlist-tabs">
                            <span class="tab active">전체</span>
                            <span class="tab">식품</span>
                            <span class="tab">패션잡화</span>
                            <span class="tab">패션잡화</span>
                            <span class="tab">패션잡화</span>
                        </div>
                        <div class="wishlist-summary">전체 3</div>
                    </div>
                
                    <div class="wishlist-items">
                        <div class="wishlist-item">
                            <a href="#" class="wishlist-link">
                                <img src="상품1.png" alt="초콜릿" class="wishlist-img">
                            </a>
                            <div class="wishlist-info">
                                <p class="wishlist-title">[여수 쑥] 여수 쑥 수제 생초콜릿 파베초콜릿 특별한 선물 해풍 쑥 인절미생초콜릿 비닐포장</p>
                                <p class="wishlist-discount">정가 <s>199,000원</s></p>
                                <p class="wishlist-price">모집 4인 50,000원</p>
                                <p class="wishlist-category">쑥 수제생초콜릿 | 식품</p>
                            </div>
                            <button class="remove-btn">×</button>
                        </div>
                
                        <div class="wishlist-item">
                            <a href="#" class="wishlist-link">
                                <img src="상품2.png" alt="운동화" class="wishlist-img">
                            </a>
                            <div class="wishlist-info">
                                <p class="wishlist-title">나이키 에어포스 1 07 LV8 WB 팀장 포스 카카오 와우 코코넛 밀크 미드나잇 네이비</p>
                                <p class="wishlist-discount">나의 모집가 <s>199,000원</s></p>
                                <p class="wishlist-price">4인 170,000원</p>
                                <p class="wishlist-category">브랜드관 | 패션잡화</p>
                            </div>
                            <button class="remove-btn">×</button>
                        </div>
                
                        <div class="wishlist-item">
                            <a href="#" class="wishlist-link">
                                <img src="상품3.png" alt="세트" class="wishlist-img">
                            </a>
                            <div class="wishlist-info">
                                <p class="wishlist-title">경덕주 125 1세트 (2병)</p>
                                <p class="wishlist-discount">정가 <s>28,000원</s></p>
                                <p class="wishlist-price">모집 2인 14,00원</p>
                                <p class="wishlist-category">제이농업회사법인 | 식품</p>
                            </div>
                            <button class="remove-btn">×</button>
                        </div>
                    </div>
                </section>
            </section>
        </div>
    </main>


</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</html>