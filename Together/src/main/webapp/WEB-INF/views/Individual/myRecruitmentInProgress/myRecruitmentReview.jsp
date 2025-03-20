<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>myRecruitmentReview</title>
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css/myRecruitmentInProgress/myRecruitmentReview.css">

</head>

<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    
    <main>


        <!-- 네비게이션 버튼 -->
        <nav id="nav-buttons">
            <button data-key="completed" class="${key eq 'completed' ? 'selected' : ''}">모집 완료</button>
            <button data-key="myRecruitment" class="${key eq 'myRecruitment' ? 'selected' : ''}">내 모집현황</button>
            <button data-key="comments" class="${key eq 'comments' ? 'selected' : ''}">댓글</button>
            <button data-key="reviews" class="${key eq 'reviews' ? 'selected' : ''}">리뷰</button>
        </nav>

        <div id="container"> <!-- 모든 내용을 감싸는 div -->

            <!-- 상단 프로필 -->
            <div id="profile">
                <img src="${not empty loginMember.profileImg ? loginMember.profileImg : '/resources/images/mypage/관리자 프로필.webp'}" alt="프로필 이미지" class="profile-img">
                <div class="profile-info">
                    <p class="grade">등급 : ${loginMember.memberGrade}등급</p>
                    <p class="nickname">${loginMember.memberNick}</p>
                    <p class="location">
                        내 지역 : ${fn:split(loginMember.memberAddr, '^^^')[1]}
                    </p>
                    <p class="points">포인트 : <span>${loginMember.point}pt</span></p>
                </div>
            </div>

            <!-- 리뷰 목록 -->
            <div id="review-list">
                <div class="review-header">
                    <div class="title-checkbox">
                        <input type="checkbox" id="topcheckbox">
                        <span class="title">리뷰</span>
                    </div>
                    <div class="review-actions">
                        <button class="delete-selected">선택 삭제</button>
                    </div>
                </div>
            
                <!-- 리뷰 목록 -->
                <c:forEach var="review" items="${reviews}" varStatus="status">
                    <div class="review-card ${status.index >= 5 ? 'hidden-review' : ''}">
                        <input type="checkbox" class="checkbox" data-reviewno="${review.reviewNo}">
                        <div class="review-info">
                            <h3 class="review-title">${review.boardTitle}</h3> 
                            <p class="review-text">: ${review.reviewContent}</p>
                            <p class="review-star">⭐ ${review.reviewStar} / 5</p>
                        </div>
                        <span class="review-date">${fn:substring(review.reviewCreatedDate, 0, 10)}</span>  
                    </div>
                </c:forEach>
            
                <!-- 리뷰가 없을 경우 메시지 출력 -->
                <c:if test="${empty reviews}">
                    <p class="no-reviews">작성한 리뷰가 없습니다.</p>
                </c:if>
            </div>

    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/individual/myRecruitmentReview.js"></script>
</body>

</html>