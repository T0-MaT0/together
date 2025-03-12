<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<c:set var="menuName" value="home"/> <!-- 사이드 메뉴 설정 -->

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/manager-css/manager-common.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/manager-devhome.css" />
    <script>
        // 사이드 메뉴 설정
        const menuName = "${menuName}";
    </script>
</head>

<body>

</body>

<main>
    
    <!-- 사이드 메뉴 -->
    <jsp:include page="/WEB-INF/views/manager/common/sideMenu.jsp"/>


    <!-- 위쪽 영역 -->
    <header>
        <div class="head-title">
            <div>홈페이지 관리</div>
             <!-- &nbsp; <div> - 대시보드</div> -->
        </div>
    </header>

    <!-- 본문(중앙) -->
    <div id="container-center">
        <section class="dev-board main img-card" id="mainPageBtn">
            <div class="dev-title">메인 PAGE</div>

            <div class="img">
                <img src="/resources/images/image-manager/dev-main.png" alt="이미지">
            </div>
        </section>
        <section class="dev-board private img-card" id="privatePageBtn">
            <div class="dev-title">GET 개인 PAGE</div>

            <div class="img">
                <img src="/resources/images/image-manager/dev-main.png" alt="이미지">
            </div>
        </section>

        <section class="dev-board brand img-card" id="brandPageBtn">
            <div class="dev-title">TO 브랜드 PAGE</div>

            <div class="img">
                <img src="/resources/images/image-manager/dev-main.png" alt="이미지">
            </div>
        </section>


        <section class="dev-board alert one-card">
            <div class="dev-card-title">공지사항 관리</div>
            <img src="/resources/images/image-manager/alert.png" alt="">
        </section>
        <section class="dev-board faq one-card">
            <div class="dev-card-title">FAQ 관리</div>
            <img src="/resources/images/image-manager/alert.png" alt="">
        </section>
    </div>


</main>
<script src="/resources/js/manager-js/home/homeMain.js"></script>
</body>

</html>
