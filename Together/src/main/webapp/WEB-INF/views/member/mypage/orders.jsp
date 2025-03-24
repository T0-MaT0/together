<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Orders</title>
<link rel="stylesheet" href="/resources/css/my_info/Orders.css">
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
                <section class="orders-section" id="orders-section">
                    <h2>주문 내역</h2>
                    <div class="order-list">
                        <div class="order-item">
                            <div class="order-left">
                                <img src="로쉐.png" alt="초콜릿 세트" class="order-img">
                            </div>
                            <div class="order-info">
                                <p class="order-title">구매확정만료</p>
                                <p class="order-desc">페르몬 로쉐 초콜릿 바 3봉 4개 (요리치 2개, 다크 1개, 화이트 1개)</p>
                                <p class="order-price">15,300원 <span class="badge">공구</span></p>
                                <p class="order-detail"><a href="#">상세보기</a></p>
                            </div>
                            <div class="order-actions">
                                <button class="review-btn">리뷰쓰기</button>
                                <button class="reorder-btn">재구매</button>
                            </div>
                        </div>
                        
                        <div class="order-item">
                            <div class="order-left">
                                <img src="보드게임.png" alt="보드게임 세트" class="order-img">
                            </div>
                            <div class="order-info">
                                <p class="order-title">구매확정만료</p>
                                <p class="order-desc">보드게임 3개 대여</p>
                                <p class="order-price">10,000원 <span class="badge">상품</span></p>
                                <p class="order-detail"><a href="#">상세보기</a></p>
                            </div>
                            <div class="order-actions">
                                <button class="reorder-btn">재구매</button>
                            </div>
                        </div>
                    </div>
                </section>
                
            </section>
        </div>
    </main>

</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</html>