<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
        <div class="banner" id="mainBannerArea">
            <c:forEach var="banner" items="${recruitmentList[0].mainBannerList}">
                <img src="${banner.imagePath}${banner.imageReName}" alt="메인 배너" class="main-banner hidden">
            </c:forEach>
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
                            <c:forEach var="image" items="${recruitmentList[0].imageList}" varStatus="status">
                                <c:if test="${image.imageType == 8}">
                                    <img src="${image.imagePath}${image.imageReName}" 
                                         class="banner-image ${status.first ? 'active' : ''}" 
                                         alt="NEW 공동구매 배너">
                                </c:if>
                            </c:forEach>
                        </div>
                        <c:forEach var="recruitment" items="${recruitmentList}" varStatus="status" begin="${i}" end="${i+1}">
                            <c:if test="${status.index < fn:length(recruitmentList)}">
                                <!-- 참가율(%) 계산 -->
                                <c:set var="progress" value="${(recruitment.currentParticipants * 100.0) / recruitment.maxParticipants}" />
                                <c:set var="discount" value="${Math.ceil(recruitment.productPrice / recruitment.maxParticipants).intValue()}" />                                

                                <div class="product">
                                    <img src="${recruitment.thumbnail != null ? recruitment.thumbnail : '/resources/images/mypage/관리자 프로필.webp'}" 
                                        alt="제품 이미지">
                                        <p class="seller-info">
                                            <span class="clickable-nickname"
                                                data-member-no="${recruitment.hostNo}"
                                                data-member-nick="${recruitment.hostName}"
                                                data-product-name="${recruitment.productName}"
                                                data-recruitment-no="${recruitment.recruitmentNo}">
                                            ${recruitment.hostName}
                                            </span>
                                            (등급: ${recruitment.hostGrade})
                                        </p>
                                    <p class="product-name">${recruitment.productName}</p>
                                    <p class="discount-price">${discount}원</p>
                                    <p class="original-price">${recruitment.productPrice}원 (원가)</p>
                                    
                                    <p class="participants">📅 생성일:
                                        <c:out value="${fn:substring(recruitment.recCreatedDate, 5, 10)}" />
                                        <c:out value="${fn:substring(recruitment.recCreatedDate, 11, 16)}" />~
                                    </p>
                                    <p class="participants">⏳ 마감일:
                                        <c:out value="${fn:substring(recruitment.recEndDate, 5, 10)}" />
                                        <c:out value="${fn:substring(recruitment.recEndDate, 11, 16)}" />
                                    </p>
                                    <p class="participants">참가 모집 : ${recruitment.currentParticipants} / ${recruitment.maxParticipants}명</p>
                                    
                                    <div class="progress-button-container">
                                        <div class="progress-container">
                                            <!-- 퍼센트 값 출력 (소수점 한 자리까지 표시) -->
                                            <span class="progress-label">
                                                <fmt:formatNumber value="${progress}" type="number" maxFractionDigits="1" />%
                                            </span>
                                            <div class="progress-bar">
                                                <div class="progress-fill" style="width: <fmt:formatNumber value='${progress}' type='number' maxFractionDigits='1' />%;"></div>
                                            </div>
                                        </div>
                                        <button class="join-btn ${recruitment.recruitmentStatus == '마감' ? 'closed-btn' : 'active-btn'}"
                                                data-recruitment-no="${recruitment.recruitmentNo}"
                                                data-board-no="${recruitment.boardNo}">
                                            ${recruitment.recruitmentStatus == '진행' ? '참가' : recruitment.recruitmentStatus}
                                        </button>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>

                    <!-- 상품 4개 그룹 -->
                    <div class="banner-product-group large-group">
                        <c:forEach var="recruitment" items="${recruitmentList}" begin="${i+2}" end="${i+5}" varStatus="status">
                            <c:if test="${status.index < fn:length(recruitmentList)}">
                                <c:set var="progress" value="${(recruitment.currentParticipants * 100.0) / recruitment.maxParticipants}" />
                                <c:set var="discount" value="${Math.ceil(recruitment.productPrice / recruitment.maxParticipants).intValue()}" />                                

                                <div class="product">
                                    <img src="${recruitment.thumbnail != null ? recruitment.thumbnail : '/resources/images/mypage/관리자 프로필.webp'}" 
                                        alt="제품 이미지">
                                        <p class="seller-info">
                                            <span class="clickable-nickname"
                                                data-member-no="${recruitment.hostNo}"
                                                data-member-nick="${recruitment.hostName}"
                                                data-product-name="${recruitment.productName}"
                                                data-recruitment-no="${recruitment.recruitmentNo}">
                                            ${recruitment.hostName}
                                            </span>
                                            (등급: ${recruitment.hostGrade})
                                        </p>
                                    <p class="product-name">${recruitment.productName}</p>
                                    <p class="discount-price">${discount}원</p>
                                    <p class="original-price">${recruitment.productPrice}원 (원가)</p>
                                    <p class="participants">📅 생성일:
                                        <c:out value="${fn:substring(recruitment.recCreatedDate, 5, 10)}" />
                                        <c:out value="${fn:substring(recruitment.recCreatedDate, 11, 16)}" />~
                                    </p>
                                    <p class="participants">⏳ 마감일:
                                        <c:out value="${fn:substring(recruitment.recEndDate, 5, 10)}" />
                                        <c:out value="${fn:substring(recruitment.recEndDate, 11, 16)}" />
                                    </p>
                                    <p class="participants">참가 모집 : ${recruitment.currentParticipants} / ${recruitment.maxParticipants}명</p>

                                    <div class="progress-button-container">
                                        <div class="progress-container">
                                            <span class="progress-label">
                                                <fmt:formatNumber value="${progress}" type="number" maxFractionDigits="1" />%
                                            </span>
                                            <div class="progress-bar">
                                                <div class="progress-fill" style="width: <fmt:formatNumber value='${progress}' type='number' maxFractionDigits='1' />%;"></div>
                                            </div>
                                        </div>
                                        <button class="join-btn ${recruitment.recruitmentStatus == '마감' ? 'closed-btn' : 'active-btn'}"
                                                data-recruitment-no="${recruitment.recruitmentNo}"
                                                data-board-no="${recruitment.boardNo}">
                                            ${recruitment.recruitmentStatus == '진행' ? '참가' : recruitment.recruitmentStatus}
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
                        <c:forEach var="recruitment" items="${recruitmentList}" begin="${i+6}" end="${i+7}" varStatus="status">
                            <c:if test="${status.index < fn:length(recruitmentList)}">
                                <c:set var="progress" value="${(recruitment.currentParticipants * 100.0) / recruitment.maxParticipants}" />
                                <c:set var="discount" value="${Math.ceil(recruitment.productPrice / recruitment.maxParticipants).intValue()}" />

                                <div class="product">
                                    <img src="${recruitment.thumbnail != null ? recruitment.thumbnail : '/resources/images/mypage/관리자 프로필.webp'}" 
                                        alt="제품 이미지">
                                        <p class="seller-info">
                                            <span class="clickable-nickname"
                                                data-member-no="${recruitment.hostNo}"
                                                data-member-nick="${recruitment.hostName}"
                                                data-product-name="${recruitment.productName}"
                                                data-recruitment-no="${recruitment.recruitmentNo}">
                                            ${recruitment.hostName}
                                            </span>
                                            (등급: ${recruitment.hostGrade})
                                        </p>
                                    <p class="product-name">${recruitment.productName}</p>
                                    <p class="discount-price">${discount}원</p>
                                    <p class="original-price">${recruitment.productPrice}원 (원가)</p>
                                    <p class="participants">📅 생성일:
                                        <c:out value="${fn:substring(recruitment.recCreatedDate, 5, 10)}" />
                                        <c:out value="${fn:substring(recruitment.recCreatedDate, 11, 16)}" />~
                                    </p>
                                    <p class="participants">⏳ 마감일:
                                        <c:out value="${fn:substring(recruitment.recEndDate, 5, 10)}" />
                                        <c:out value="${fn:substring(recruitment.recEndDate, 11, 16)}" />
                                    </p>
                                    <p class="participants">참가 모집 : ${recruitment.currentParticipants} / ${recruitment.maxParticipants}명</p>

                                    <div class="progress-button-container">
                                        <div class="progress-container">
                                            <!-- 퍼센트 값 출력 (소수점 한 자리까지 표시) -->
                                            <span class="progress-label">
                                                <fmt:formatNumber value="${progress}" type="number" maxFractionDigits="1" />%
                                            </span>
                                            <div class="progress-bar">
                                                <div class="progress-fill" style="width: <fmt:formatNumber value='${progress}' type='number' maxFractionDigits='1' />%;"></div>
                                            </div>
                                        </div>
                                        <button class="join-btn ${recruitment.recruitmentStatus == '마감' ? 'closed-btn' : 'active-btn'}"
                                                data-recruitment-no="${recruitment.recruitmentNo}"
                                                data-board-no="${recruitment.boardNo}">
                                            ${recruitment.recruitmentStatus == '진행' ? '참가' : recruitment.recruitmentStatus}
                                        </button>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>

                </c:forEach>
            </div>
        </section>

        <!-- 광고 배너 -->
        <div class="ad-banner">
            <c:forEach var="image" items="${recruitmentList[0].imageList}" varStatus="status">
                <c:if test="${image.imageType == 7}">
                    <img src="${image.imagePath}${image.imageReName}" 
                        class="ad-image ${status.first ? 'active' : ''}" 
                        alt="광고 배너">
                </c:if>
            </c:forEach>
        </div>

        <!-- 추가 공동 구매 리스트 (필요 시 추가 가능) -->
        <section class="extra-products">
            <div class="product-grid"></div>
        </section>

        <div class="more-container">
            <button class="more-btn">more</button>
        </div>

    </div>

    <div id="nicknameMenu" class="nickname-menu hidden">
        <ul>
          <li id="startPrivateChat">1대1 채팅</li>
          <li id="reportUser">신고하기</li>
        </ul>
    </div>
    <!-- 신고 모달 프로필 -->
    <jsp:include page="/WEB-INF/views/Individual/modal.jsp"/>

    <c:if test="${not empty loginMember}">
        <script>
            loginMember = {
            memberNo: ${loginMember.memberNo},
            nickname: "${loginMember.memberNick}"
            };
        </script>
    </c:if>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/individual/individualMain.js"></script>


    <c:if test="${not empty message}">
        <script>
            alert("${message}");
        </script>
    </c:if>
    
    <c:if test="${not empty alertMessage}">
        <script>
            alert("${alertMessage}");
        </script>
    </c:if>
</body>

</html>