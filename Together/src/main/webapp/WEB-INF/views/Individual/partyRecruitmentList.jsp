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
                    <c:if test="${loginMember != null && loginMember.authority == 1}">
                        <button class="delete-board-btn" onclick="deleteBoard(${recruitmentDetail.boardNo})">
                            삭제
                        </button>
                    </c:if>
                </div>
                <div>
                    <span class="buyer-info">🧑
                    <span class="clickable-nickname"
                            data-member-no="${recruitmentDetail.hostNo}"
                            data-member-nick="${recruitmentDetail.hostName}"
                            data-product-name="${recruitmentDetail.productName}"
                            data-recruitment-no="${recruitmentDetail.recruitmentNo}">
                        ${recruitmentDetail.hostName}
                        </span>
                        (${recruitmentDetail.hostGrade})
                    </span>
                </div>
            </div>

            <!-- 상품 이미지 캐러셀 -->
            <div class="image-carousel">
                <button class="carousel-btn left" onclick="moveSlide(-1)">&lt;</button>
                <div class="carousel-track-wrapper">
                    <div class="carousel-track">
                        <c:forEach var="image" items="${recruitmentDetail.imageList}" varStatus="status">
                            <div class="carousel-item">
                                <img src="${image.imagePath}${image.imageReName}" alt="썸네일${status.index}">
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <button class="carousel-btn right" onclick="moveSlide(1)">&gt;</button>
            </div>

            <!-- 모집 정보 -->
            <div class="recruit-info-container">
                <div class="product-details">
                    <h3>${recruitmentDetail.productName}</h3>
                    <a href="${recruitmentDetail.productUrl}" class="product-link" target="_blank" rel="noopener noreferrer">🔗 링크 바로가기</a>
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
                    <p class="people">모집인원 : <strong>${recruitmentDetail.currentParticipants} / ${recruitmentDetail.maxParticipants}</strong></p>
                    <p class="sale">인당 가격 : <fmt:formatNumber value="${recruitmentDetail.productPrice / recruitmentDetail.maxParticipants}" pattern="#,###"/> Pt</p>
                </div>
            </div>

            <!-- 가격 정보 -->
            <div class="price-container">
                <div class="price-info">
                    <p class="buyAll">전체 구매 시 필요한 금액</p>
                    <p class="buyTogether">내가 내야할 금액</p>
                </div>
                <div class="price-box">
                    <p class="original"><fmt:formatNumber value="${recruitmentDetail.productPrice}" pattern="#,###"/> Pt</p>
                    <p class="sale"><fmt:formatNumber value="${(recruitmentDetail.productPrice / recruitmentDetail.maxParticipants) * recruitmentDetail.myParticipationCount}" pattern="#,###"/> Pt</p>
                </div>
            </div>

            <c:choose>
                <c:when test="${recruitmentDetail.myParticipationCount > 0}">
                    <c:choose>
                        <%-- 모집장인 경우 --%>
                        <c:when test="${loginMember.memberNick == recruitmentDetail.hostName}">
                            <button class="join-btn"
                                    onclick="location.href='/purchase_in_progress_host?recruitmentNo=${recruitmentDetail.recruitmentNo}&boardNo=${recruitmentDetail.boardNo}'">
                                상세보기
                            </button>
                        </c:when>

                        <%-- 일반 파티원인 경우 --%>
                        <c:otherwise>
                            <button class="join-btn"
                                    onclick="location.href='/purchase_in_progress_member?recruitmentNo=${recruitmentDetail.recruitmentNo}&boardNo=${recruitmentDetail.boardNo}'">
                                상세보기
                            </button>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <button class="join-btn"
                        onclick="location.href='/group/participate?recruitmentNo=${recruitmentDetail.recruitmentNo}&boardNo=${recruitmentDetail.boardNo}'">
                        참여하기
                    </button>
                </c:otherwise>
            </c:choose>

            <!-- 설명란 -->
            <div class="recruit-description">
                <textarea placeholder="상세 내용을 입력하세요." readonly>${recruitmentDetail.boardContent}</textarea>
            </div>

            <!-- 목록 버튼 -->
            <div class="button-container">
                <!-- 수정 버튼 (로그인한 사용자의 닉네임과 hostName이 같을 때만 보임) -->
                <c:if test="${not empty loginMember && loginMember.memberNick eq recruitmentDetail.hostName}">
                    <button class="edit-btn2" onclick="openEditPopup(${recruitmentDetail.recruitmentNo}, ${recruitmentDetail.boardNo})">수정</button>
                </c:if>
                <!-- 목록 버튼 (모든 사용자에게 보임) -->
                <button class="list-btn" onclick="location.href='/Individual/detail'">목록</button>
            </div>

            <!-- 댓글 입력 -->
            <div class="comment-section">
                <input type="hidden" id="boardNo" value="${recruitmentDetail.boardNo}">
                <input type="text" class="comment-input" placeholder="💬 댓글을 입력해 주세요.">
                <button class="comment-btn">등록</button>
            </div>

            <!-- 댓글 목록 -->
            <div class="comment-list">
                <c:forEach var="comment" items="${recruitmentDetail.commentList}">
                <div class="comment">
                    <div class="comment-content">
                    <img src="${empty recruitmentDetail.profileImg ? '/resources/images/mypage/관리자 프로필.webp' : recruitmentDetail.profileImg}" 
                        class="comment-profile" alt="프로필">
                    <p>
                        <span class="comment-user clickable-nickname"
                            data-member-no="${comment.memberNo}"
                            data-member-nick="${comment.memberNick}"
                            data-product-name="${recruitmentDetail.productName}"
                            data-reply-no="${comment.replyNo}">
                        ${comment.memberNick}
                        </span>
                        : ${comment.replyContent}
                    </p>
                    </div>
                    <div class="comment-actions">
                    <c:if test="${comment.memberNo == loginMember.memberNo || loginMember.authority == 1}">
                        <button class="delete-btn" onclick="deleteReply(${comment.replyNo}, this)">삭제</button>
                    </c:if>
                    </div>
                </div>
                </c:forEach>
            </div>
        </div>
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
    <script src="/resources/js/individual/partyRecruitmentList.js"></script>
    <c:if test="${not empty alertMessage}">
        <script>
            alert("${alertMessage}");
        </script>
    </c:if>
</body>

</html>