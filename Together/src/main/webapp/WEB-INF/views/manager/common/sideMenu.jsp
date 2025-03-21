<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

  <!-- 사이드 메뉴 -->
  <div id="container-side">
    <!-- 로고 -->
     <a href="/managerArea/main">
         <img src="/resources/images/image-manager/Group 2411.png" alt="로고 이미지" >
     </a>

    <!-- 메뉴 -->
    <div id="menu-items">
        <div id="dash-board">대시보드</div>

        <button class="accordion" id="customerMenu">고객관리 ${menuName}</button>
        <div class="panel">
            <a href="/manageCustomer/state">고객 상태</a>
            <a href="/manageCustomer/board">공구 모집글</a>
            <a href="/manageCustomer/question">문의</a>
            <a href="/manageCustomer/report">신고</a>
        </div>

        <button class="accordion" id="brandMenu">브랜드 관리</button>
        <div class="panel">
            <a href="/manageBrand/goods">상품 판매</a>
            <a href="/manageBrand/report">신고</a>
            <a href="/manageBrand/apply">제휴 신청</a>
            <a href="/manageBrand/promotion">광고 신청</a>
            <a href="/manageBrand/dataLook">성과 데이터</a>
        </div>

        <button class="accordion" id="homePageMenu">홈페이지 관리</button>
        <div class="panel">
            <a href="/manageHome/mainPage">메인 PAGE</a>
            <a href="/manageHome/privatePage">GET 개인 PAGE</a>
            <a href="/manageHome/brandPage">TO 브랜드 PAGE</a>
        </div>

    </div>

</div>


<!-- 사이드 메뉴 기능 -->
<script>
    const acc = document.getElementsByClassName("accordion");

    // for (let i = 0; i < acc.length; i++) {
    //     acc[i].addEventListener("click", function () {
    //         this.classList.toggle("active"); 

    //         let panel = this.nextElementSibling;

    //         if (this.classList.contains("active")) {
    //             panel.style.maxHeight = panel.scrollHeight + "px"; 
    //         } else {
    //             panel.style.maxHeight = null;
    //         }
    //     });
    // }

    // 메뉴 요소
    const customerMenu = document.getElementById("customerMenu");
    const brandMenu = document.getElementById("brandMenu");
    const homePageMenu = document.getElementById("homePageMenu");


    //고객 메뉴
    customerMenu.addEventListener("click", (e)=>{
        // 고객 페이지인 경우 거부
        if(location.pathname.indexOf("/manager/customer") != -1) return;
        location.href="/managerArea/customer";
    })

    // 브랜드 메뉴
    brandMenu.addEventListener("click", ()=>{
        // 브랜드 페이지인 경우 거부
        if(location.pathname.indexOf("/manager/brand") != -1) return;
        location.href="/managerArea/brand";
    })

    // 홈페이지 메뉴
    homePageMenu.addEventListener("click", ()=>{
        // 홈페이지 인 경우 거부
        if(location.pathname.indexOf("/manager/home") != -1) return;
        location.href="/managerArea/home";
    })

    
    // 고객 관리 메뉴 색
    //menuName은 customerMain.jsp, brandMain.jsp, manageHome.jsp에 EL값 존재
    if(typeof menuName !== 'undefined'){

        if(menuName == 'customer'){
            //고객 관리 메뉴 accordion 클래스 => clicked으로 바꿈
            customerMenu.classList.remove("accordion");
            customerMenu.classList.add("clicked");
    
            // 고객 관리 메뉴 아래 서브메뉴 설정 panel => open-menu 클래스
            const customerSubMenu = customerMenu.nextElementSibling;
            customerSubMenu.classList.remove("panel");
            customerSubMenu.classList.add("open-menu");
    
            console.log(customerSubMenu.children[0].classList);
            
    
            //menuNumber은 customerBoard.jsp, customerQuestion.jsp, customerReport.jsp, customerState.jsp
           // El 값으로 존재
            if(typeof menuNumber !== "undefined")
               switch(menuNumber){
                   
                   case 0: customerSubMenu.children[menuNumber].classList.add('pink'); break;
                   case 1: customerSubMenu.children[menuNumber].classList.add('pink'); break;
                   case 2: customerSubMenu.children[menuNumber].classList.add('pink'); break;
                   case 3: customerSubMenu.children[menuNumber].classList.add('pink'); break;
               }
        }
    
        // 브랜드 관리 메뉴 색
        if(menuName == 'brand'){
            //브랜드 관리 메뉴 accordion 클래스 => clicked으로 바꿈
            brandMenu.classList.remove("accordion");
            brandMenu.classList.add("clicked");
    
            const brandSubMenu = brandMenu.nextElementSibling;
            brandSubMenu.classList.remove("panel");
            brandSubMenu.classList.add("open-menu");
    
        }
    
    
        // 홈페이지 관리 메뉴 색
        if(menuName == 'home'){
            //고객 관리 메뉴 accordion 클래스 => clicked으로 바꿈
            homePageMenu.classList.remove("accordion");
            homePageMenu.classList.add("clicked");
    
            const homePageSubMenu = homePageMenu.nextElementSibling;
            homePageSubMenu.classList.remove("panel");
            homePageSubMenu.classList.add("open-menu");
    
            const lastPath = document.location.href.split('/');
            const currentPage = lastPath[lastPath.length - 1];
    
            switch (currentPage){
                case "mainPage": homePageSubMenu.children[0].style.color = 'blue';break;
                case "privatePage": homePageSubMenu.children[1].style.color = 'blue';break;
                case "brandPage": homePageSubMenu.children[2].style.color = 'blue';break;
            }
            
    
        }
    }


</script>