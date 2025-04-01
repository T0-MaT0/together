<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객센터 메인</title>
    <link rel="stylesheet" href="/resources/css/customer/customer-main-style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <section class="customer-container">
        <!-- 왼쪽 섹션 -->
        <section id="left-section">
            <!-- 공지사항 -->
            <div class="notice-box">
                <div class="notice-title" onclick="location.href='/customer/noticeBoardList'">공지사항</div>
                <ul class="notice-list">
                    <c:forEach var="notice" items="${map.noticeList}">
                        <li><a class="noticeTitle" href="/customer/customerBoardDetail/${notice.boardNo}">${notice.boardTitle}</a></li>
                    </c:forEach>
                </ul>
            </div>

            <!-- 하단 버튼 -->
            <div class="button-group">
                <c:if test="${loginMember != null}">
                    <a href="/customer2/6/insert">1:1 문의하기</a>
                </c:if>
                <c:if test="${loginMember == null}">
                    <a href="/member/login?redirect=/customer2/6/insert"
                    onclick="alert('로그인 먼저 해주세요');">1:1 문의하기</a>
                </c:if>
                <a href="/customer/noticeBoardList">공지사항</a>
                <a href="/customer/FAQBoard/0">자주 묻는 질문</a>
                <a href="#">실시간 채팅 문의</a>
            </div>

            
        </section>
        
        <!-- 오른쪽 섹션 -->
        <section id="right-section">
            <!-- 자주 묻는 질문 -->
            <div class="faq-box">
                <div class="faq-title" onclick="location.href='/customer/FAQBoard/0'">자주 묻는 질문 (FAQ)</div>
                <ul class="faq-list">
                    <c:forEach var="FAQList9" items="${map.FAQList9}">
                        <li><a class="noticeTitle" href="/customer/FAQBoard/9">${FAQList9.boardTitle}</a></li>
                    </c:forEach>
                </ul>
            </div>
            
            
            <!-- 고객센터 -->
            <div class="customer-service-box">
                <div class="customer-title">고객센터</div>
                <div class="customer-info">
                    <div>📞 고객센터 운영 시간: 평일 09:00~18:00</div>
                    <div>✉️ 문의 이메일: support@공동구매사이트.com</div>
                </div>
            </div>
        </section>
    </section>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/customer/customerMain.js"></script>
</body>
</html>