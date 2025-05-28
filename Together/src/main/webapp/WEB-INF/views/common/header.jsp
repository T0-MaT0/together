<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="/resources/css/header,footer.css">

<header class="container">
    <div class="top-bar">
        <div class="logo-nav">
            <div class="logo">
                <a href="/"><img src="/resources/images/mainJHI/logo.png" alt="ToGether Logo"></a>
            </div>
            <span class="main-nav">
                <c:set var="uri" value="${pageContext.request.requestURI}" />

                <!-- 브랜드 버튼 -->
                <c:set var="brandClass" value="to-brand" />
                <c:if test="${fn:contains(uri, '/product')}">
                    <c:set var="brandClass" value="btn-get-personal" />
                </c:if>
                <a href="/product" class="${brandClass}">To 브랜드</a>

                <!-- 개인 공구 버튼 -->
                <c:set var="individualClass" value="to-gain" />
                <c:if test="${fn:contains(uri, '/individual')}">
                    <c:set var="individualClass" value="btn-get-gain" />
                </c:if>
                <a href="/individual" class="${individualClass}">Get 개인</a>
            </span>
        </div>

        <div class="user-info">
            <c:if test="${!empty loginMember}">
                <span>${loginMember.memberNick} | ${loginMember.point}pt</span>

                <c:if test="${loginMember.authority == 2}">
                    <button class="btn-recruit">모집하기</button>
                </c:if>

                <c:if test="${loginMember.authority == 3}">
                    <a href="/product/insert" class="product-registration">상품등록</a>
                </c:if>
            </c:if>
        </div>
    </div>
</header>

<nav class="sub-nav">
    <div class="container2">
        <div class="left-links">
            <c:set var="uri" value="${pageContext.request.requestURI}" />

            <c:choose>
                <!-- 개인공구 관련 메뉴 -->
                <c:when test="${fn:contains(uri, '/individual')}">
                    <a href="/individual/detail">모집 상품</a>
                    <span> | </span>
                    <a href="/myRecruitment?key=myRecruitment">내 모집 중</a>
                    <span> | </span>
                    <a href="/customer/customerMain">고객 센터</a>
                </c:when>

                <!-- 브랜드 관련 메뉴 -->
                <c:otherwise>
                    <a href="/product/reviewList">리뷰 목록</a>
                    <span> | </span>
                    <a href="/product/replyList">Q&A 목록</a>
                    <span> | </span>
                    <a href="/customer/customerMain">고객 센터</a>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="right-links">
            <c:if test="${!empty loginMember}">
                <!-- 관리자(admin)인 경우 -->
                <c:if test="${loginMember.authority == 1}">
                    <a href="/managerArea/main">관리자 페이지</a>
                    <span> | </span>
                </c:if>
                
                <!-- 로그인한 모든 사용자 -->
                <a href="/mypage/home">마이페이지</a>
                <span> | </span>
        
                <!-- 일반 회원만 포인트 충전 가능 -->
                <c:if test="${loginMember.authority != 1}">
                    <a href="/member/chargePoint">포인트 충전</a>
                    <span> | </span>
                </c:if>
        
                <a href="/member/logout">로그아웃</a>
            </c:if>
        
            <!-- 비로그인 상태 -->
            <c:if test="${empty loginMember}">
                <a href="/member/login">로그인</a>
                <span> | </span>
                <a href="/member/signUp1">회원 가입</a>
            </c:if>
        </div>
    </div>
</nav>
<script src="/resources/js/header.js"></script>