<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="/resources/css/header,footer.css">



<header class="container">
    <div class="top-bar">
        <div class="logo-nav">
            <div class="logo"><a href=""><img src="logo1.png" alt="ToGether Logo"></a></div>
            <span class="main-nav">
                <a href="#" class="to-brand">To 브랜드</a>
                <a href="#" class="btn-get-personal">Get 개인</a>
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
    <div class="container">
        <div class="left-links">
            <a href="#">공구 상품</a>
            <span> | </span>
            <a href="#">내 모집 중</a>
            <span> | </span>
            <a href="#">리뷰 후기</a>
            <span> | </span>
            <a href="#">고객 센터</a>
        </div>
        <div class="right-links">
            <c:if test="${!empty loginMember}">
                <a href="#">마이페이지</a>
                <span> | </span>
                <a href="#">포인트 충전</a>
                <span> | </span>
                <a href="/member/logout">로그아웃</a>
            </c:if>
            <c:if test="${empty loginMember}">
                <a href="/member/login">로그인</a>
                <span> | </span>
                <a  href="/member/signUp1">회원 가입</a>
            </c:if>
        </div>
    </div>
</nav>