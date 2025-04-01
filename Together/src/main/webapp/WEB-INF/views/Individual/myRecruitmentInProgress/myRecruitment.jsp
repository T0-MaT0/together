<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>myRecruitment</title>
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css//myRecruitmentInProgress/myRecruitment.css">

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
            
            <!-- 모집 목록 -->
            <div id="recruit-list">
                <div class="recruit-header">
                    <span class="title"> 전체 모집방 </span>
                </div>
                
                <c:forEach var="recruitment" items="${recruitments}">
                    <div class="recruit-card ${recruitment.recruitmentStatus eq '모집 완료' ? 'completed' : 'in-progress'}">
                        <input type="checkbox" class="checkbox" data-boardno="${recruitment.boardNo}">
                        
                        <div class="recruit-info">
                            <div class="header">
                                <span class="badge 
                                    ${recruitment.recruitmentStatus eq '완료' ? 'red' :
                                    (recruitment.recruitmentStatus eq '마감' ? 'purple' : 'blue')}">
                                    ${recruitment.recruitmentStatus}
                                </span>
                                <h3>
                                    <a href="/partyRecruitmentList/${recruitment.recruitmentNo}/${recruitment.boardNo}">
                                      ${recruitment.productName != null ? recruitment.productName : '상품명 없음'}
                                    </a>
                                </h3>
                            </div>
                            
                            <div class="info-footer">
                                <div class="details">
                                    <span class="period">📅 생성일: 
                                        <c:out value="${fn:substring(recruitment.recCreatedDate, 5, 10)}" /> 
                                        <c:out value="${fn:substring(recruitment.recCreatedDate, 11, 16)}" /> ~
                                    </span>
                                    <span>⏳ 마감일: 
                                        <c:out value="${fn:substring(recruitment.recEndDate, 5, 10)}" /> 
                                        <c:out value="${fn:substring(recruitment.recEndDate, 11, 16)}" />
                                    </span>
                                    <span>👥 모집인원: ${recruitment.currentParticipants}/${recruitment.maxParticipants}</span>
                                </div>
                                <div class="price">
                                    <span class="original">${recruitment.productPrice}pt</span>
                                    <span class="sale">
                                        <c:set var="discount" value="${recruitment.productPrice / recruitment.maxParticipants}" />
                                        <fmt:formatNumber value="${discount}" type="number" maxFractionDigits="0" />pt
                                    </span>
                                    <c:set var="progress" value="${(recruitment.currentParticipants / recruitment.maxParticipants) * 100}" />
                                    <span class="progress-label">
                                        <c:out value="${fn:substringBefore(progress, '.')}" />%
                                    </span>
                                </div>
                            </div>
            
                            <!-- 모집 진행도 바 -->
                            <div class="progress-bar">
                                <c:set var="progress" value="${(recruitment.currentParticipants * 100) / recruitment.maxParticipants}" />
                                <div class="progress ${recruitment.recruitmentStatus eq '모집 완료' ? 'red-bar' : 'blue-bar'}" 
                                     style="width: ${progress}%;">
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <input type="hidden" id="loginMemberNo" value="${loginMember.memberNo}">
                <div class="delete-btn-container" style="visibility: hidden;">
                    <button class="close-btn">모집 마감</button>
                    <button class="delete-btn">모집 삭제</button>
                </div>
            </div>


        </div> <!-- container 종료 -->


    </main>
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
    <script src="/resources/js/individual/myRecruitment.js"></script>
</body>

</html>