<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>RecentPurchase</title>
<link rel="stylesheet" href="/resources/css/my_info/RecentPurchase.css">
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
                <section class="recent-purchases-section">
                    <h2 class="recent-purchase-title">최근 구매 상품</h2>
                    <h2 class="purchase-date">2025.02.12</h2>
                    <div class="recent-purchase-container">
                        <div class="recent-purchase-item">
                            <a href="#" class="purchase-link">
                                <img src="상품1.png" alt="초콜릿" class="purchase-img">
                            </a>
                            <div class="purchase-info">
                                <p class="purchase-title"><a href="#">[여수 쑥] 여수 쑥 수제 생초콜릿 파베초콜릿 특별한 선물 해풍 쑥 인절미생초콜릿 비닐포장</a></p>
                                <p class="purchase-price">17,500원</p>
                                <p class="purchase-category">브랜드 | 식품</p>
                            </div>
                            <button class="remove-btn">×</button>
                        </div>
                
                        <div class="recent-purchase-item">
                            <a href="#" class="purchase-link">
                                <img src="상품2.png" alt="운동화" class="purchase-img">
                            </a>
                            <div class="purchase-info">
                                <p class="purchase-title"><a href="#">나이키 에어포스 1 07 LV8 WB 팀장 포스 카카오 와우 코코넛 밀크 미드나잇 네이비</a></p>
                                <p class="purchase-discount">정가 <s>200,000원</s></p>
                                <p class="purchase-price">모집 4인 50,000원</p>
                                <p class="purchase-category">모집 | 패션잡화</p>
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