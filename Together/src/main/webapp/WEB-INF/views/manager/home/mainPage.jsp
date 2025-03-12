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
            <div class="topBannerArea">
                <img class="bannerItem"/>
                <input type="file" accept="image/*">

                <img class="bannerItem"/>
                <input type="file" accept="image/*">
                
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

<script>
const bannerItems = document.getElementsByClassName("bannerItem");
const bannerInput = document.getElementsByTagName("input");

for (let i = 0; i < bannerItems.length; i++) {
    bannerItems[i].addEventListener("click", () => {
        bannerInput[i].click();
    });

    bannerInput[i].addEventListener("change", function () {
        const file = this.files[0]; 
        
        if (file) {
            console.log("파일 선택됨");
            const reader = new FileReader();

            reader.readAsDataURL(file);

            reader.onload = function (e) {
                bannerItems[i].setAttribute("src", e.target.result);
            };
        } else {
            console.log("파일 없음");
            bannerItems[i].removeAttribute("src");
            bannerInput[i].value = '';
        }
    });
}




</script>
</body>

</html>
