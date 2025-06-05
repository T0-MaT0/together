<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="/resources/css/header,footer.css">

<footer class="footer-container">
    <div class="footer-top">
        <img src="/resources/images/mainJHI/logo1.png" alt="ToGether Logo">
        <img src="/resources/images/mainJHI/footer image1.png" alt="Buy ToGether, Sell Together!">
    </div>

    <c:set var="uri" value="${pageContext.request.requestURI}" />

    <nav class="footer-links">
        <a href="#">이용약관</a><span> | </span>
        <a href="/customer/FAQBoard/0">FAQ</a><span> | </span>
        <a href="/customer/customerMain">고객센터</a><span> | </span>
         <%-- 브랜드 버튼 --%>
        <c:set var="brandClass" value="to-brand" />
        <c:if test="${fn:contains(uri, '/business')}">
            <c:set var="brandClass" value="btn-get-personal" />
        </c:if>
        <a href="/product" class="${brandClass}">To 브랜드</a><span> | </span>

        <%-- 개인 공구 버튼 --%>
        <c:set var="individualClass" value="to-gain" />
        <c:if test="${fn:contains(uri, '/Individual')}">
            <c:set var="individualClass" value="btn-get-gain" />
        </c:if>
        <a href="/individual" class="${individualClass}">Get 개인</a>
    </nav>
    <div class="footer-divider"></div>
    <div class="footer-bottom">
        <p>공동구매 플랫폼 ToGether<br>KH아카데미 G-Class 파이널 프로젝트</p>
        <p>팀 ToMoto<br>조장 강현우 박규성 박천상 정이레 정현이</p>
    </div>
    <div class="footer-info">
        <p>설명설명설명 대충팀소개<br>
           설명설명설명 대충팀소개설명설명설명 대충팀소개<br>
           설명설명설명 대충팀소개설명설명설명 대충팀소개설명설명설명</p>
    </div>
</footer>

<c:if test="${not empty loginMember}">
    <script>
        loginMember = {
        memberNo: ${loginMember.memberNo},
        nickname: "${loginMember.memberNick}"
        };
    </script>
    </c:if>
<c:if test="${!empty message}">

    <script>
        alert('${message}');
    </script>


</c:if>

<jsp:include page="/WEB-INF/views/common/sidebar/sideBar-main.jsp" /> 
