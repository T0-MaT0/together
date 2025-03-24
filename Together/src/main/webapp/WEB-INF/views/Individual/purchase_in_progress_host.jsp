<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>purchase_in_progress_host</title>
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css/recruitment_detail/purchase_in_progress_host.css">

</head>

<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main>
        <div class="detail-container">
            <!-- 상세 정보 헤더 -->
            <div class="detail-header">
                <h2>상세 정보</h2>
                <span class="member-type">모집장</span>
            </div>
    
            <!-- 프로필 정보 -->
            <div class="profile-section">
                <div class="profile-card">
                    <img src="${empty loginMember.profileImg ? '/resources/images/mypage/관리자 프로필.webp' : loginMember.profileImg}" alt="프로필 이미지" class="profile-img">
                    <div class="profile-info">
                        <p><strong>등급 :</strong> ${loginMember.memberGrade}</p>
                        <p><strong>${loginMember.memberNick}</strong></p>
                        <p>${fn:split(loginMember.memberAddr, "^^^")[1]}</p>
                        <p class="join-date">
                            <c:out value="${fn:substring(loginMember.enrollDate, 0, 10)}"/> 가입
                        </p>
                    </div>
                </div>
            </div>
    
            <!-- 모집 상세 정보 -->
            <div class="recruit-info">
                <div class="info-row">
                    <span class="label">글 제목</span>
                    <span class="value">
                        <a href="/partyRecruitmentList/${recruitment.recruitmentNo}/${recruitment.boardNo}">
                            ${recruitment.productName}
                        </a>
                    </span>
                </div>
                <div class="info-row">
                    <span class="label">내가 수령할 수량</span>
                    <span class="value">${recruitment.myParticipationCount}</span>
                </div>
                <div class="info-row">
                    <span class="label">상품 모집 지역</span>
                    <span class="value">
                        <c:out value="${recruitment.region}"/>
                    </span>
                </div>
                <div class="info-row">
                    <span class="label">진행 기간</span>
                    <span class="value">
                        <c:out value="${fn:substring(recruitment.recEndDate, 0, 10)}"/>
                    </span>
                </div>
                <div class="info-row">
                    <span class="label">결제 금액</span>
                    <span class="value">
                        <fmt:formatNumber value="${(recruitment.productPrice / recruitment.maxParticipants) * recruitment.myParticipationCount}" pattern="#,###"/>pt
                    </span>
                </div>
            </div>
    
            <!-- 버튼 -->
            <div class="button-group">
                <button class="group-register-btn">공구 인원 등록하기</button>
            </div>
        </div>
    </main>
    

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>

</html>