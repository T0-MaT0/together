<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToGether - detail</title>
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css/main2-detail.css">
   
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="main-container">
        <!-- 배너 (이미지 적용) -->
        <div class="banner">
            <c:if test="${not empty recruitmentList}">
                <c:forEach var="banner" items="${recruitmentList[0].mainBannerList}">
                    <img src="${banner.imagePath}${banner.imageReName}" alt="메인 배너">
                </c:forEach>
            </c:if>
        </div>

        <!-- 상세 목록 -->
        <section class="detail-products">
            <h2 class="section-title"><span class="highlight">상품목록</span></h2>
                <div class="product-grid">
                    <c:forEach var="recruitment" items="${recruitmentList}" varStatus="status">
                            <c:set var="progress" value="${(recruitment.currentParticipants * 100.0) / recruitment.maxParticipants}" />
                            <c:set var="discount" value="${Math.ceil(recruitment.productPrice / recruitment.maxParticipants).intValue()}" />                                

                            <div class="product">
                                <img src="${recruitment.thumbnail != null ? recruitment.thumbnail : '/resources/images/mypage/관리자 프로필.webp'}" 
                                    alt="제품 이미지">
                                    <p class="seller-info">
                                        <span class="clickable-nickname"
                                              data-member-no="${recruitment.hostNo}"
                                              data-member-nick="${recruitment.hostName}">
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
                    </c:forEach>
                </div>
        </section>

    </div>
    <div id="nicknameMenu" class="hidden">
        <ul>
          <li id="startPrivateChat">1대1 채팅</li>
          <li id="reportUser">신고하기</li>
        </ul>
      </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/individual/individualDetail.js"></script>
</body>
</html>
