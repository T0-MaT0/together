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
    <link rel="stylesheet" href="/resources/css/manager-css/dev/dev-select.css" />
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
             &nbsp; <div> - 메인 Page</div>
             <!-- &nbsp; <div> - TO 브랜드</div> -->
             <!-- &nbsp; <div> - MAIN 홈</div> -->
        </div>
    </header>

    <!-- 본문(중앙) -->
    <div id="container-center">
        
        <section class="dev-board">
            <h3>TOP 배너</h3>
            <form action="mainPage/submit" method="POST" name="BannerSubmit" enctype="multipart/form-data">

                <div class="topBannerArea">
                    
                    <!-- 기존 있음: 1 기존 없음: 0 없앰: -1, 수정: 2 -->
    
                    <c:if test="${!empty imgList[0]}">
                        <img class="bannerItem" src="${imgList[0].imagePath}${imgList[0].imageReName}" no="${imgList[0].imageNo}" state="1"/>
                    </c:if>
                    <c:if test="${empty imgList[0]}">
                        <img class="bannerItem" state="0"/>
                    </c:if>
                    <input type="file" accept="image/*" name="images">
    
    
                    <c:if test="${!empty imgList[1]}">
                        <img class="bannerItem" src="${imgList[1].imagePath}${imgList[1].imageReName}" no="${imgList[1].imageNo}" state="1"/>
                    </c:if>
                    <c:if test="${empty imgList[1]}">
                        <img class="bannerItem" state="0"/>
                    </c:if>
                    <input type="file" accept="image/*" name="images">
    
    
                    <c:if test="${!empty imgList[2]}">
                        <img class="bannerItem" src="${imgList[2].imagePath}${imgList[2].imageReName}" no="${imgList[2].imageNo}" state="1"/>
                    </c:if>
                    <c:if test="${empty imgList[2]}">
                        <img class="bannerItem" state="0"/>
                    </c:if>
                    <input type="file" accept="image/*" name="images">
    
    
                    <c:if test="${!empty imgList[3]}">
                        <img class="bannerItem" src="${imgList[3].imagePath}${imgList[3].imageReName}" no="${imgList[3].imageNo}" state="1"/>
                    </c:if>
                    <c:if test="${empty imgList[3]}">
                        <img class="bannerItem" state="0"/>
                    </c:if>
                    <input type="file" accept="image/*" name="images">
    
    
                    <c:if test="${!empty imgList[4]}">
                        <img class="bannerItem" src="${imgList[4].imagePath}${imgList[4].imageReName}" no="${imgList[3].imageNo}" state="1"/>
                    </c:if>
                    <c:if test="${empty imgList[4]}">
                        <img class="bannerItem" state="0"/>
                    </c:if>
                    <input type="file" accept="image/*" name="images">
    
    
                </div>
                <div class="btnArea">
                    <button>적용</button>
                </div>
                
            </form>
            
        </section>

        <section class="dev-board">
            <h3>Mid 배너</h3>
            <div class="MidBannerArea">
                <img class="bannerItem"/>
                <input type="file" accept="image/*">
            </div>
            <div class="btnArea">
                <button>적용</button>
            </div>
        </section>
        
        
        <section class="dev-board">
            <h3>Mini 배너</h3>
            <div class="bottomBannerArea">
                
                <img class="bannerItem"/>
                <input type="file" accept="image/*">
                
                <img class="bannerItem"/>
                <input type="file" accept="image/*">

                <img class="bannerItem"/>
                <input type="file" accept="image/*">

            </div>
            <div class="btnArea">
                <button>적용</button>
            </div>
        </section>



    </div>


</main>

<script src="/resources/js/manager-js/home/homeMain.js"></script>
</body>

</html>
