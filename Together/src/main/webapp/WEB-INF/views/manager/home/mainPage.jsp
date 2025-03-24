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
    <script src="https://kit.fontawesome.com/975074ef7f.js" crossorigin="anonymous"></script>
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
            <form action="mainPage/submit" method="POST" name="BannerSubmit" enctype="multipart/form-data" onsubmit="imageSubmit(event)">

                <div class="topBannerArea">
                    

                    <c:forEach begin="0" end="4" var="i" varStatus="status">
                        <div class="bannerItemWrapper">
                            
                            <c:if test="${!empty imgList[i]}">
                                <img class="bannerItem" src="${imgList[i].imagePath}${imgList[i].imageReName}" state="1"/>
                            </c:if>
                            <c:if test="${empty imgList[i]}">
                                <img class="bannerItem" state="0" src="/resources/images/image-manager/banner/noneImg.png"/>
                            </c:if>
                            <button type="button" class="refreshButton" onclick="refreshImage(`${imgList[i].imagePath}${imgList[i].imageReName}`, `${status.index}`)" style="display: none;">
                                <i class="fa-solid fa-rotate-right"></i>
                            </button>
                            <button type="button" class="closeButton" onclick="removeImage(${i})">X</button>
                            <input type="file" accept="image/*" name="images" no="${status.index}">

                        </div>
                    </c:forEach>

    
                </div>
                <div class="btnArea">
                    <button>적용</button>
                </div>
                <input type="hidden" name="InsertNo">
                <input type="hidden" name="updateNo">
                <input type="hidden" name="deleteNo">
                
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
