<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>recruitmentParticipation</title>
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css/recruitment/recruitmentParticipation.css">

</head>

<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main>
        <div class="participation-container">
            <!-- 참여하기 헤더 -->
            <div class="participation-header">
                <img src="/resources/images/recruitment/recruitment.png" alt="참여 아이콘" class="participation-icon">
                <h2>참여하기</h2>
            </div>

            <!-- 제품 정보 -->
            <div class="product-info">
                <p><strong>제품:</strong> ${recruitment.productName}</p>
                <p class="buyer-info">모집장: ${recruitment.hostName}</p>
            </div>

            <!-- 인원 선택 (왼쪽 정렬, 제주 삼다수 아래 배치) -->
            <div class="participant-selection">
                <label for="participant-count">선택 인원 수:</label>
                <select id="participant-count" name="myQuantity">
                    <c:forEach begin="1" end="${recruitment.maxParticipants - recruitment.currentParticipants}" var="i">
                        <option value="${i}" <c:if test="${i == recruitment.myParticipationCount}">selected</c:if>>${i}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- 가격 정보 & 상품 이미지 -->
            <div class="price-product-container">
                <div class="price-info">
                    <div class="sale-container">
                        <p>전제 구매 시 필요한 금액</p>
                        <span class="original"><fmt:formatNumber value="${recruitment.productPrice}" pattern="#,###"/> pt</span>
                    </div>
                    <div class="sale-container">
                        <p>모집인들과 함께 사기</p>
                        <span>
                            <fmt:formatNumber value="${recruitment.productPrice / recruitment.maxParticipants}" pattern="#,###"/> pt x 
                            <span id="selectedCount">${recruitment.myParticipationCount > 0 ? recruitment.myParticipationCount : 1}</span>
                        </span>
                    </div>
                    <p class="total-price">
                        <strong>
                            총 <span id="totalPoint">
                                <fmt:formatNumber 
                                    value="${(recruitment.productPrice / recruitment.maxParticipants) * (recruitment.myParticipationCount > 0 ? recruitment.myParticipationCount : 1)}" 
                                    pattern="#,###"/>
                            </span> pt
                        </strong>
                    </p>
                    <input type="hidden" id="unitPrice" value="${recruitment.productPrice / recruitment.maxParticipants}" />
                </div>

                <div class="product-image">
                    <c:choose>
                        <c:when test="${not empty recruitment.imageList}">
                            <img src="${recruitment.imageList[0].imagePath}${recruitment.imageList[0].imageReName}" alt="제품 이미지">
                        </c:when>
                        <c:otherwise>
                            <img src="/resources/images/mypage/관리자 프로필.webp" alt="기본 이미지">
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- 참여하기 버튼 -->
            <form action="/group/participate/submit" method="post">
                <input type="hidden" name="recruitmentNo" value="${recruitment.recruitmentNo}" />
                <input type="hidden" name="boardNo" value="${recruitment.boardNo}" />
                <input type="hidden" id="hiddenMyQuantity" name="myQuantity" value="${recruitment.myParticipationCount > 0 ? recruitment.myParticipationCount : 1}" />
                <button class="participation-btn" type="submit">참여하기</button>
            </form>
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
    <script src="/resources/js/individual/recruitmentParticipation.js"></script>
</body>

</html>