<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
            <img src="/resources/images/individual/main/main2-banner2.png"
                alt="Buy Together, Sell Together">
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

                <c:forEach var="i" begin="0" end="7" step="8">
                    <!-- 배너 + 상품 2개 그룹 -->
                    <div class="banner-product-group small-group">
                        <div class="new-banner">
                            <img src="/resources/images/individual/main/main2 광고.gif" alt="NEW 공동구매">
                        </div>
                        <c:forEach var="recruitment" items="${recruitmentList}" begin="${i}" end="${i+1}"
                            varStatus="status">
                            <c:if test="${status.index < fn:length(recruitmentList)}">
                                <div class="product">
                                    <img src="/resources/images/product/1.jpg" alt="제품 이미지">
                                    <p class="seller-info">${recruitment.hostName} (등급:
                                        ${recruitment.hostGrade})</p>
                                    <p class="product-name">${recruitment.productName}</p>
                                    <p class="discount-price">${recruitment.productPrice}원</p>
                                    <p class="original-price">${recruitment.productCount}원 (원가)</p>
                                    <p class="participants">📅 생성일:
                                        <c:out value="${fn:substring(recruitment.recCreatedDate, 5, 10)}" />
                                        <c:out
                                            value="${fn:substring(recruitment.recCreatedDate, 11, 16)}" />~
                                    </p>
                                    <p class="participants">⏳ 마감일:
                                        <c:out value="${fn:substring(recruitment.recEndDate, 5, 10)}" />
                                        <c:out value="${fn:substring(recruitment.recEndDate, 11, 16)}" />
                                    </p>
                                    <p class="participants">참가 모집 : ${recruitment.currentParticipants} /
                                        ${recruitment.maxParticipants}명</p>
                                    <div class="progress-button-container">
                                        <div class="progress-container">
                                            <span class="progress-label">
                                                <c:set var="progress"
                                                    value="${(recruitment.currentParticipants / recruitment.maxParticipants) * 100}" />
                                                <c:out value="${String.format('%.1f', progress)}" />%
                                            </span>
                                            <div class="progress-bar">
                                                <div class="progress-fill"
                                                    style="width: ${(recruitment.currentParticipants / recruitment.maxParticipants) * 100}%;">
                                                </div>
                                            </div>
                                        </div>
                                        <button
                                            class="join-btn ${recruitment.currentParticipants >= recruitment.maxParticipants ? 'closed' : ''}">
                                            ${recruitment.currentParticipants >= recruitment.maxParticipants
                                            ? '마감' : '참가'}
                                        </button>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>

                    <!-- 상품 4개 그룹 -->
                    <div class="banner-product-group large-group">
                        <c:forEach var="recruitment" items="${recruitmentList}" begin="${i+2}" end="${i+5}"
                            varStatus="status">
                            <c:if test="${status.index < fn:length(recruitmentList)}">
                                <div class="product">
                                    <img src="/resources/images/individual/main/water2.png" alt="제품 이미지">
                                    <p class="seller-info">${recruitment.hostName} (등급:
                                        ${recruitment.hostGrade})</p>
                                    <p class="product-name">${recruitment.productName}</p>
                                    <p class="discount-price">${recruitment.productPrice}원</p>
                                    <p class="original-price">${recruitment.productCount}원 (원가)</p>
                                    <p class="participants">📅 생성일:
                                        <c:out value="${fn:substring(recruitment.recCreatedDate, 5, 10)}" />
                                        <c:out
                                            value="${fn:substring(recruitment.recCreatedDate, 11, 16)}" />~
                                    </p>
                                    <p class="participants">⏳ 마감일:
                                        <c:out value="${fn:substring(recruitment.recEndDate, 5, 10)}" />
                                        <c:out value="${fn:substring(recruitment.recEndDate, 11, 16)}" />
                                    </p>
                                    <p class="participants">참가 모집 : ${recruitment.currentParticipants} /
                                        ${recruitment.maxParticipants}명</p>
                                    <div class="progress-button-container">
                                        <div class="progress-container">
                                            <span class="progress-label">
                                                <c:set var="progress"
                                                    value="${(recruitment.currentParticipants / recruitment.maxParticipants) * 100}" />
                                                <c:out value="${String.format('%.1f', progress)}" />%
                                            </span>
                                            <div class="progress-bar">
                                                <div class="progress-fill"
                                                    style="width: ${(recruitment.currentParticipants / recruitment.maxParticipants) * 100}%;">
                                                </div>
                                            </div>
                                        </div>
                                        <button
                                            class="join-btn ${recruitment.currentParticipants >= recruitment.maxParticipants ? 'closed' : ''}">
                                            ${recruitment.currentParticipants >= recruitment.maxParticipants
                                            ? '마감' : '참가'}
                                        </button>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>

                    <!-- 배너 + 상품 2개 그룹 -->
                    <div class="banner-product-group small-group">
                        <div class="new-banner">
                            <img src="/resources/images/individual/main/main2 광고.gif" alt="NEW 공동구매">
                        </div>
                        <c:forEach var="recruitment" items="${recruitmentList}" begin="${i+6}" end="${i+7}"
                            varStatus="status">
                            <c:if test="${status.index < fn:length(recruitmentList)}">
                                <div class="product">
                                    <img src="/resources/images/individual/main/water2.png" alt="제품 이미지">
                                    <p class="seller-info">${recruitment.hostName} (등급:
                                        ${recruitment.hostGrade})</p>
                                    <p class="product-name">${recruitment.productName}</p>
                                    <p class="discount-price">${recruitment.productPrice}원</p>
                                    <p class="original-price">${recruitment.productCount}원 (원가)</p>
                                    <p class="participants">📅 생성일:
                                        <c:out value="${fn:substring(recruitment.recCreatedDate, 5, 10)}" />
                                        <c:out
                                            value="${fn:substring(recruitment.recCreatedDate, 11, 16)}" />~
                                    </p>
                                    <p class="participants">⏳ 마감일:
                                        <c:out value="${fn:substring(recruitment.recEndDate, 5, 10)}" />
                                        <c:out value="${fn:substring(recruitment.recEndDate, 11, 16)}" />
                                    </p>
                                    <p class="participants">참가 모집 : ${recruitment.currentParticipants} /
                                        ${recruitment.maxParticipants}명</p>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>

                </c:forEach>
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