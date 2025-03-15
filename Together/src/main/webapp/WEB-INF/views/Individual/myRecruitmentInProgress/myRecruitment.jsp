<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
            <button >모집 완료</button>
            <button >내 모집현황</button>
            <button >댓글</button>
            <button >리뷰</button>
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
                    <input type="checkbox" id="topcheckbox">
                    <span class="title"> 내 09 파티</span>
                </div>
                
                <c:forEach var="recruitment" items="${recruitmentList}">
                    <div class="recruit-card ${recruitment.recruitmentStatus eq '모집 완료' ? 'completed' : 'in-progress'}">
                        <input type="checkbox" class="checkbox">
                        <div class="recruit-info">
                            <div class="header">
                                <span class="badge ${recruitment.recruitmentStatus eq '모집 완료' ? 'red' : 'blue'}">
                                    ${recruitment.recruitmentStatus}
                                </span>
                                <h3>${recruitment.productName}</h3>
                            </div>
                            
                            <div class="info-footer">
                                <div class="details">
                                    <span class="period">기간: ${recruitment.recCreatedDate} ~ ${recruitment.recEndDate}</span>
                                    <span>모집인원: ${recruitment.currentParticipants}/${recruitment.maxParticipants}</span>
                                </div>
                                <div class="price">
                                    <span class="original">${recruitment.productPrice}pt</span>
                                    <span class="sale">
                                        <c:set var="discount" value="${recruitment.productPrice / recruitment.maxParticipants}" />
                                        <fmt:formatNumber value="${discount}" type="number" maxFractionDigits="0" />pt
                                    </span>
                                </div>
                            </div>
            
                            <!-- 모집 진행도 바 -->
                            <div class="progress-bar">
                                <c:set var="progress" value="${(recruitment.currentParticipants * 100) / recruitment.maxParticipants}" />
                                <div class="progress ${recruitment.recruitmentStatus eq '모집 완료' ? 'red-bar' : 'blue-bar'}" 
                                     style="width: ${progress}%;"></div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            
                <div class="delete-btn-container">
                    <button class="close-btn">09마감</button>
                    <button class="delete-btn">09삭제</button>
                </div>
            </div>


        </div> <!-- container 종료 -->


    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/individual/individualMain.js"></script>
</body>

</html>