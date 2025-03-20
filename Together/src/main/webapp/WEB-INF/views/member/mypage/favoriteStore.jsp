<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>myFavoriteStores</title>
<link rel="stylesheet" href="/resources/css/my_info/myFavoriteStores.css">
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
                <section class="favorite-stores-section">
                    <h2 class="store-title">관심 스토어</h2>
                    <div class="store-notice">
                        <strong>2월 12일, 일부 윈도 서비스 종료 안내</strong><br>
                        앞으로는 기존 윈도 스토어의 알림을 받을 수 없어요. 같은 판매자의 스마트스토어에서 혜택과...
                    </div>
                    <div class="store-filters">
                        <button class="filter active">전체</button>
                        <button class="filter">식품</button>
                        <button class="filter">생활/건강</button>
                        <span class="store-total">전체 3</span>
                        <button class="edit-btn">편집</button>
                    </div>
                
                    <div class="store-container">
                        <div class="store-item">
                            <img src="브랜드1.png" alt="스토어 로고" class="store-img">
                            <div class="store-info">
                                <p class="store-name">제이1 농업회사법인</p>
                                <p class="store-desc">제이1은 BAR & HOME BAR 문화를 리드합니다.</p>
                                <p class="store-customers">관심고객수 90,446</p>
                            </div>
                            <button class="remove-btn">×</button>
                        </div>
                
                        <div class="store-item">
                            <img src="브랜드2.png" alt="스토어 로고" class="store-img">
                            <div class="store-info">
                                <p class="store-name">신화미트</p>
                                <p class="store-desc">대용량 가성비 고기들의 향연~!!</p>
                                <p class="store-customers">관심고객수 60,166</p>
                            </div>
                            <button class="remove-btn">×</button>
                        </div>
                
                        <div class="store-item">
                            <img src="브랜드1.png" alt="스토어 로고" class="store-img">
                            <div class="store-info">
                                <p class="store-name">홈바이</p>
                                <p class="store-desc">직 도매, 직 수입을 통한 저렴한 가격 모든 상품 묶음배송 가능</p>
                                <p class="store-customers">관심고객수 3,424</p>
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
<script src="/resources/js/member/mypages.js"></script>
</html>