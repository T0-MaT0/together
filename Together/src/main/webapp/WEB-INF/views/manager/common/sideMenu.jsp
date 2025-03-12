<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

  <!-- 사이드 메뉴 -->
  <div id="container-side">
    <!-- 로고 -->
     <a href="/manager/main">
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


    const customerMenu = document.getElementById("customerMenu");
    const brandMenu = document.getElementById("brandMenu");
    const homePageMenu = document.getElementById("homePageMenu");


    //고객 메뉴
    customerMenu.addEventListener("click", (e)=>{
        if(location.pathname.indexOf("/manager/customer") != -1) return;
        location.href="/manager/customer";
    })

    // 브랜드 메뉴
    brandMenu.addEventListener("click", ()=>{
        if(location.pathname.indexOf("/manager/brand") != -1) return;
        location.href="/manager/brand";
    })

    // 홈페이지 메뉴
    homePageMenu.addEventListener("click", ()=>{
        if(location.pathname.indexOf("/manager/home") != -1) return;
        location.href="/manager/home";
    })

    
    // 고객 관리 메뉴 색
    if(menuName == 'customer'){
        
        customerMenu.classList.remove("accordion");
        customerMenu.classList.add("clicked");

        const customerSubMenu = customerMenu.nextElementSibling;
        customerSubMenu.classList.remove("panel");
        customerSubMenu.classList.add("open-menu");

        console.log(customerSubMenu.children[0].classList);
        
        switch(menuNumber){
            case 0: customerSubMenu.children[menuNumber].classList.add('pink'); break;
            case 1: customerSubMenu.children[menuNumber].classList.add('pink'); break;
            case 2: customerSubMenu.children[menuNumber].classList.add('pink'); break;
            case 3: customerSubMenu.children[menuNumber].classList.add('pink'); break;
        }
    }


    if(menuName == 'brand'){
        console.log('asdf');
        brandMenu.classList.remove("accordion");
        brandMenu.classList.add("clicked");

        const brandSubMenu = brandMenu.nextElementSibling;
        brandSubMenu.classList.remove("panel");
        brandSubMenu.classList.add("open-menu");

        console.log(brandSubMenu.children[0].classList);
        
        switch(menuNumber){
            case 0: brandSubMenu.children[menuNumber].classList.add('pink'); break;
            case 1: brandSubMenu.children[menuNumber].classList.add('pink'); break;
            case 2: brandSubMenu.children[menuNumber].classList.add('pink'); break;
            case 3: brandSubMenu.children[menuNumber].classList.add('pink'); break;
        }
    }

    if(nameMenu == 'home'){
        brandMenu.classList.remove("accordion");
        brandMenu.classList.add("clicked");

        const brandSubMenu = brandMenu.nextElementSibling;
        brandSubMenu.classList.remove("panel");
        brandSubMenu.classList.add("open-menu");

        console.log(brandSubMenu.children[0].classList);
        
        switch(menuNumber){
            case 0: brandSubMenu.children[menuNumber].classList.add('pink'); break;
            case 1: brandSubMenu.children[menuNumber].classList.add('pink'); break;
            case 2: brandSubMenu.children[menuNumber].classList.add('pink'); break;
            case 3: brandSubMenu.children[menuNumber].classList.add('pink'); break;
        }
    }

</script>