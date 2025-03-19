<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>partyRecruitmentList</title>
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css/recruitment/partyRecruitmentList.css">

</head>

<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main>
        <div id="recruit-detail">
            <!-- 모집글 헤더 -->
            <div class="recruit-header">
                <div id="title">
                    <span class="badge" data-status="${recruitmentDetail.recruitmentStatus}">
                        ${recruitmentDetail.recruitmentStatus}
                    </span>
                    <span class="recruit-title">${recruitmentDetail.productName}</span>
                </div>
                <div>
                    <span class="buyer-info">${recruitmentDetail.hostName} (${recruitmentDetail.hostGrade})</span>
                </div>
            </div>

            <!-- 상품 이미지 캐러셀 -->
            <div class="image-carousel">
                <button class="carousel-btn left" onclick="moveSlide(-1)">&lt;</button>
                <div class="carousel-track-wrapper">
                    <div class="carousel-track">
                        <c:forEach var="image" items="${recruitmentDetail.imageList}" varStatus="status">
                            <img src="${image.imagePath}${image.imageReName}" 
                                 alt="썸네일${status.index}" 
                                 class="carousel-image">
                        </c:forEach>
                    </div>
                </div>
                <button class="carousel-btn right" onclick="moveSlide(1)">&gt;</button>
            </div>

            <!-- 모집 정보 -->
            <div class="recruit-info-container">
                <div class="product-details">
                    <h3>${recruitmentDetail.productName}</h3>
                    <a href="${recruitmentDetail.productUrl}" class="product-link">🔗 링크 바로가기</a>
                </div>

                <div class="info-box">
                    <p>기간 : <strong>
                        ${fn:substring(recruitmentDetail.recCreatedDate, 0, 13)}시 ~ 
                        ${fn:substring(recruitmentDetail.recEndDate, 0, 13)}시
                    </strong></p>

                    <!-- 진행도 바 -->
                    <div class="progress-container">
                        <div class="progress-bar">
                            <div class="progress" style="width: ${recruitmentDetail.currentParticipants * 100 / recruitmentDetail.maxParticipants}%;">
                            </div>
                        </div>
                    </div>
                    <p class="people">모집인원: <strong>${recruitmentDetail.currentParticipants} / ${recruitmentDetail.maxParticipants}</strong></p>
                    <p class="items">1인당: <strong>${recruitmentDetail.productCount / recruitmentDetail.maxParticipants}개</strong></p>
                </div>
            </div>

            <!-- 가격 정보 -->
            <div class="price-container">
                <div class="price-info">
                    <p class="buyAll">전체 구매 시 필요한 금액</p>
                    <p class="buyTogether">유저들과 함께 사기</p>
                </div>
                <div class="price-box">
                    <p class="original"><fmt:formatNumber value="${recruitmentDetail.productPrice}" pattern="#,###"/>원</p>
                    <p class="sale"><fmt:formatNumber value="${recruitmentDetail.productPrice / recruitmentDetail.maxParticipants}" pattern="#,###"/>원</p>
                </div>
            </div>

            <button class="join-btn">참여하기</button>

            <!-- 설명란 -->
            <div class="recruit-description">
                <textarea placeholder="상세 내용을 입력하세요." readonly>${recruitmentDetail.productContent}</textarea>
            </div>

            <!-- 목록 버튼 -->
            <button class="list-btn" onclick="location.href='/partyRecruitmentList'">목록</button>

            <!-- 댓글 입력 -->
            <div class="comment-section">
                <input type="text" class="comment-input" placeholder="💬 댓글을 입력해 주세요.">
                <button class="comment-btn">등록</button>
            </div>

            <!-- 댓글 목록 -->
            <div class="comment-list">
                <c:forEach var="comment" items="${recruitmentDetail.commentList}">
                    <div class="comment">
                        <div class="comment-content">
                            <img src="/resources/images/profile/default.png" class="comment-profile" alt="프로필">
                            <p><span class="comment-user">${recruitmentDetail.memberNick} :</span> ${comment.replyContent}</p>
                        </div>
                        <div class="comment-actions">
                            <c:if test="${comment.memberNo == loginMember.memberNo}">
                                <button class="edit-btn">수정</button>
                                <button class="delete-btn">삭제</button>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/individual/partyRecruitmentList.js"></script>
</body>

</html>