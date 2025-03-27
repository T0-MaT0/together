<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="/resources/css/header,footer.css">

<header class="container">
    <div class="top-bar">
        <div class="logo-nav">
            <div class="logo"><a href="/"><img src="/resources/images/mainJHI/logo.png" alt="ToGether Logo"></a></div>
            <span class="main-nav">
                <!-- boardCD가 2이면 브랜드 버튼 클래스 변경 -->
                <c:set var="code" value="to-brand"/>
                <c:if test='${boardCode == 2}'>
                    <c:set var="code" value="btn-get-personal"/>
                </c:if>
                <a href="/board/2" class="${code}">To 브랜드</a>
                
                <!-- boardCD가 1이면 개인 버튼 클래스 변경 -->
                <c:set var="code" value="to-gain"/>
                <c:if test='${boardCode == 1}'>
                    <c:set var="code" value="btn-get-gain"/>
                </c:if>
                <a href="/Individual/1" class="${code}">Get 개인</a>
            </span>
        </div>
        <div class="user-info">
            <c:if test="${!empty loginMember}">
                <span>${loginMember.memberNick} | ${loginMember.point}pt</span>
                <button class="btn-recruit  ">모집하기</button>
            </c:if>
        </div>
    </div>
</header>

<nav class="sub-nav">
    <div class="container2">
        <div class="left-links">
            <c:choose>
                <c:when test="${boardCode == 1}">
                    <a href="/Individual/detail">모집 상품</a>
                    <span> | </span>
                    <a href="/myRecruitment?key=myRecruitment">내 모집 중</a>
                    <span> | </span>
                    <a href="/customer/customerMain">고객 센터</a>
                </c:when>
                <c:otherwise>
                    <a href="#">공구 상품</a>
                    <span> | </span>
                    <a href="#">내 모집 중</a>
                    <span> | </span>
                    <a href="#">리뷰 후기</a>
                    <span> | </span>
                    <a href="/customer/customerMain">고객 센터</a>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="right-links">
            <c:if test="${!empty loginMember}">
                <!-- 관리자(admin)인 경우 -->
                <c:if test="${loginMember.authority == 1}">
                    <a href="/manager/main">관리자 페이지</a>
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
