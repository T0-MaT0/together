<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>purchase_confirmation_review</title>
    <link rel="stylesheet" href="/resources/css/recruitment_detail/purchase_confirmation_review.css">

</head>


<body>
    <main class="verification-container">
        <main class="review-container">
            <div class="review-header">
                <h2 class="review-title">후기 남기기</h2>
            </div>
    
            <div class="profile-card">
                <c:choose>
                    <c:when test="${not empty targetMember.profileImg}">
                        <img src="${targetMember.profileImg}" alt="프로필 이미지" class="profile-img">
                    </c:when>
                    <c:otherwise>
                        <img src="/resources/images/mypage/관리자 프로필.webp" alt="기본 프로필 이미지" class="profile-img">
                    </c:otherwise>
                </c:choose>
                <div class="profile-info">
                    <p><strong>등급 :</strong> ${targetMember.memberGrade}</p>
                    <p><strong>${targetMember.memberNick}</strong></p>
                    <p>${fn:split(targetMember.memberAddr, '^^^')[1]}</p>
                    <p class="join-date">
                        <fmt:formatDate value="${targetMember.enrollDate}" pattern="yyyy.MM.dd 가입" />
                    </p>
                </div>
            </div>
    
            <div class="star-rating">
                <span data-value="1">★</span>
                <span data-value="2">★</span>
                <span data-value="3">★</span>
                <span data-value="4">★</span>
                <span data-value="5">★</span>
            </div>
    
            <textarea class="review-textarea" id="reviewContent" placeholder="자세한 후기를 남겨주세요."></textarea>
    
            <div class="button-group">
                <button class="submit-btn" onclick="submitReview()">작성 완료</button>
            </div>
        </main>
    </main>

    <script>
        recruitmentNo = ${recruitmentNo};
        boardNo = ${boardNo};
        const targetNo = ${targetMember.memberNo};
    </script>
    <script src="/resources/js/individual/purchase_confirmation_review.js"></script>

</body>

</html>