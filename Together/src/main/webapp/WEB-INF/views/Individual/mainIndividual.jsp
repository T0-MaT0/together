<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToGether</title>
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css/mainIndividual.css">
   
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="main-container">
        <!-- 배너 (이미지 적용) -->
        <div class="banner">
            <img src="/resources/images/individual/main/main2-banner2.png" alt="Buy Together, Sell Together">
        </div>

        <!-- BEST 공동 구매 -->
        <section class="best-section">
            <h2 class="section-title"><span class="highlight">NEW</span> 새로 올라온 공구 제품</h2>
            <div class="product-grid">
            </div>
        </section>

        <!-- NEW 공동 구매 -->
        <section class="new-section">
            <h2 class="section-title"><span class="highlight">BEST</span> 가장 핫한 공구 제품</h2>
            <div class="new2-grid">
                <div class="new-banner">
                    <img src="/resources/images/individual/main/main2 광고.gif" alt="NEW 공동구매">
                </div>
                <div class="product">
                    <img src="/resources/images/individual/main/water2.png" alt="제품 이미지">
                    <p class="seller-info">김민수(⭐4.1)</p>
                    <p class="product-name">오렌지 주스</p>
                    <p class="discount-price">1,400원</p>
                    <p class="original-price">7,000원(원가)</p>
                    <p class="participants">참가 모집 : 2 / 5명</p>
                    <div class="progress-button-container">
                        <div class="progress-container">
                            <span class="progress-label">40%</span>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 40%;"></div>
                            </div>
                        </div>
                        <button class="join-btn">참가</button>
                    </div>
                </div>
                <div class="product">
                    <img src="water2.png" alt="제품 이미지">
                    <p class="seller-info">이소라(⭐4.3)</p>
                    <p class="product-name">딸기 우유</p>
                    <p class="discount-price">1,200원</p>
                    <p class="original-price">6,000원(원가)</p>
                    <p class="participants">참가 모집 : 3 / 5명</p>
                    <div class="progress-button-container">
                        <div class="progress-container">
                            <span class="progress-label">60%</span>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 60%;"></div>
                            </div>
                        </div>
                        <button class="join-btn">참가</button>
                    </div>
                </div>
            </div>
        </section>

        <!-- 조회수 높은 순 (BEST) -->
        <section class="new-section">
            <h2 class="section-title"><span class="highlight">BEST</span> 가장 핫한 공구 제품</h2>
            <div class="new2-grid"> 
            </div>
        </section>

        <!-- 광고 배너 -->
        <div class="ad-banner">
            <img src="/resources/images/individual/main/main2-banner.png" alt="광고">
        </div>

        <!-- 추가 공동 구매 리스트 -->
        <section class="extra-products">
            <div class="product-grid">
                <div class="product">
                    <img src="water2.png" alt="제품 이미지">
                    <p class="seller-info">박지훈(⭐3.9)</p>
                    <p class="product-name">탄산수</p>
                    <p class="discount-price">900원</p>
                    <p class="original-price">4,500원(원가)</p>
                    <p class="participants">참가 모집 : 3 / 5명</p>
                    <div class="progress-button-container">
                        <div class="progress-container">
                            <span class="progress-label">60%</span>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 60%;"></div>
                            </div>
                        </div>
                        <button class="join-btn">참가</button>
                    </div>
                </div>
                <div class="product">
                    <img src="water2.png" alt="제품 이미지">
                    <p class="seller-info">정수연(⭐4.7)</p>
                    <p class="product-name">포도 주스</p>
                    <p class="discount-price">1,500원</p>
                    <p class="original-price">7,500원(원가)</p>
                    <p class="participants">참가 모집 : 4 / 5명</p>
                    <div class="progress-button-container">
                        <div class="progress-container">
                            <span class="progress-label">80%</span>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 80%;"></div>
                            </div>
                        </div>
                        <button class="join-btn">참가</button>
                    </div>
                </div>
                <div class="product">
                    <img src="water2.png" alt="제품 이미지">
                    <p class="seller-info">손민호(⭐4.5)</p>
                    <p class="product-name">레몬에이드</p>
                    <p class="discount-price">1,800원</p>
                    <p class="original-price">9,000원(원가)</p>
                    <p class="participants">참가 모집 : 5 / 5명</p>
                    <div class="progress-button-container">
                        <div class="progress-container">
                            <span class="progress-label">100%</span>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 100%;"></div>
                            </div>
                        </div>
                        <button class="join-btn closed">마감</button>
                    </div>
                </div>
            </div>
        </section>
        <div class="more-container">
            <button class="more-btn">more</button>
        </div>

    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/individual/individualMain.js"></script>

</body>
</html>
