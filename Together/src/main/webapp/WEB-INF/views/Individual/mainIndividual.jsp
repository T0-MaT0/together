<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

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
        <!-- 메인 배너 -->
        <div class="banner">
            <img src="/resources/images/individual/main/main2-banner2.png" alt="Buy Together, Sell Together">
        </div>

        <!-- 최신 상품 (NEW) -->
        <section class="best-section">
            <h2 class="section-title"><span class="highlight">NEW</span> 새로 올라온 공구 제품</h2>
            <div class="product-grid"></div>
        </section>

        <!-- 인기 상품 (BEST) -->
        <section class="new-section">
            <h2 class="section-title"><span class="highlight">BEST</span> 가장 핫한 공구 제품</h2>
            <div id="popular-products" class="popular-product-grid">
                <!-- 첫 번째 행: 배너(광고1개) + 상품2개 -->
                <div class="banner-product-group small-group">
                    <div class="new-banner">
                        <img src="/resources/images/individual/main/main2 광고.gif" alt="NEW 공동구매">
                    </div>
                    <div class="product">상품1</div>
                    <div class="product">상품2</div>
                </div>
        
                <!-- 두 번째 행: 상품4개 -->
                <div class="banner-product-group large-group">
                    <div class="product">상품3</div>
                    <div class="product">상품4</div>
                    <div class="product">상품5</div>
                    <div class="product">상품6</div>
                </div>
        
            </div>
        </section>

        <!-- 광고 배너 -->
        <div class="ad-banner">
            <img src="/resources/images/individual/main/main2-banner.png" alt="광고">
        </div>

        <!-- 추가 공동 구매 리스트 (필요 시 추가 가능) -->
        <section class="extra-products">
            <div class="product-grid"></div>
        </section>

        <div class="more-container">
            <button class="more-btn">more</button>
        </div>

    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/individual/individualMain.js"></script>

</body>

</html>