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
        <button class="accordion" id="customerMenu">고객관리 ${customer}</button>
        <div class="panel">
            <a href="/manageCustomer/state">고객 상태</a>
            <a href="/manageCustomer/board">공구 모집글</a>
            <a href="/manageCustomer/question">문의</a>
            <a href="/manageCustomer/report">신고</a>
        </div>

        <button class="accordion" id="brandMenu">브랜드 관리</button>
        <div class="panel">
            <a>내용</a>
        </div>

        <button class="accordion" id="homePageMenu">홈페이지 관리</button>
        <div class="panel">
            <a>내용</a>
        </div>

    </div>

</div>


<!-- 사이드 메뉴 기능 -->
<script>
    const acc = document.getElementsByClassName("accordion");

    for (let i = 0; i < acc.length; i++) {
        acc[i].addEventListener("click", function () {
            this.classList.toggle("active");
            let panel = this.nextElementSibling;
            console.log(panel.style.maxHeight);
            if (panel.style.maxHeight) {
                panel.style.maxHeight = null;
            } else {
                panel.style.maxHeight = panel.scrollHeight + "px";
            }
        });

    }


    const customerMenu = document.getElementById("customerMenu");
    const brandMenu = document.getElementById("brandMenu");
    const homePageMenu = document.getElementById("homePageMenu");


    //고객 메뉴
    customerMenu.addEventListener("click", (e)=>{
        if(location.pathname.indexOf("customer") != -1) return;
        location.href="/manager/customer";
    })

    // 브랜드 메뉴
    brandMenu.addEventListener("click", ()=>{
        if(location.pathname.indexOf("brand") != -1) return;
        location.href="/manager/brand";
    })

    // 홈페이지 메뉴
    homePageMenu.addEventListener("click", ()=>{
        if(location.pathname.indexOf("home") != -1) return;
        location.href="/manager/home";
    })

    
    if(menuName == 'customer'){
        
        customerMenu.classList.remove("accordion");
        customerMenu.classList.add("clicked");

        customerMenu.click();
        
    }

</script>