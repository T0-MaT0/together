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
        <button class="accordion">고객관리</button>
        <div class="panel">
            <p>내용</p>
            <p>내용</p>
            <p>내용</p>
        </div>

        <button class="accordion">브랜드 관리</button>
        <div class="panel">
            <p>내용</p>
        </div>

        <button class="accordion">홈페이지 관리</button>
        <div class="panel">
            <p>내용</p>
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
</script>