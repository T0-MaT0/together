<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>purchase_in_progress_member</title>
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css/recruitment_detail/purchase_in_progress_member.css">

</head>

<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main>
        <div class="detail-container">
            <!-- 상세 정보 헤더 -->
            <div class="detail-header">
                <h2>상세 정보</h2>
                <span class="member-type">모집원</span>
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

            <!-- 버튼 그룹 -->
            <div class="button-group">
                <c:choose>
                    <%-- 모집 상태가 '진행'이면 취소 버튼만 --%>
                    <c:when test="${recruitment.recruitmentStatus eq '진행'}">
                        <form action="/group/participation/cancel" method="post" onsubmit="return confirm('참가를 정말 취소하시겠습니까?');">
                            <input type="hidden" name="recruitmentNo" value="${recruitment.recruitmentNo}" />
                            <button type="submit" class="cancel-btn">참가 취소하기</button>
                        </form>
                    </c:when>
            
                    <%-- 모집 상태가 '마감'이면 모든 버튼 표시 --%>
                    <c:when test="${recruitment.recruitmentStatus eq '마감'}">
                        <form action="/group/verification/memberForm" method="get" style="display:inline;">
                            <input type="hidden" name="recruitmentNo" value="${recruitment.recruitmentNo}">
                            <input type="hidden" name="boardNo" value="${recruitment.boardNo}">
                            <button type="submit" class="group-check-btn">모집 인증 폼 확인하기</button>
                        </form>
                        <button class="purchase-btn">구매 진행하기</button>
                        <button class="confirmation-btn">물건을 못 받았어요.</button>
                    </c:when>
                </c:choose>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>

</html>