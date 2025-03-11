<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="/resources/css/header,footer.css">

<footer class="footer-container">
    <div class="footer-top">
        <img src="/resources/images/mainJHI/logo1.png" alt="ToGether Logo">
        <img src="/resources/images/mainJHI/footer image1.png" alt="Buy ToGether, Sell Together!">
    </div>
    <nav class="footer-links">
        <a href="#">이용약관</a><span> | </span>
        <a href="#">FAQ</a><span> | </span>
        <a href="#">고객센터</a><span> | </span>
        <a href="#">ToGether 소개</a><span> | </span>
        <a href="#">To 브랜드</a><span> | </span>
        <a href="#">Get 개인</a>
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
<c:if test="${!empty message}">

    <script>
        alert('${message}');
    </script>


</c:if>