<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>Side bar</title>
  <link rel="stylesheet" type="text/css" href="/resources/css/sideBar.css">

</head>

<body>
  <div class="sideBar active" id="sideBar">
    <div class="sidebar-menu-box" id="sidebar-menu-box">
      <div class="sidebar-menu">
        <div><a href="" id="sideBar-close"><img src="/resources/images/sidebar/images/X.svg" width="30px" height="30px" alt=""></a></div>
        <div><a href="" id="togglePage"><img src="/resources/images/sidebar/images/talk.svg" width="32px" height="32px" alt=""></a></div>
        <div><a href=""><img src="/resources/images/sidebar/images/+.svg" width="31px" height="32px" alt=""></a></div>
        <div><a href=""><img src="/resources/images/sidebar/images/ArrowUp.svg" height="30px" alt=""></a></div>
        <div><a href=""><img src="/resources/images/sidebar/images/ArrowDown.svg" height="30px" alt=""></a></div>
      </div>
    </div>

    <div class="sidebar-wrapper">
      <div class="title">
        <span id="title"></span>
        <div class="Search-box">
          <label for="sideBarSearchInput">
            <div id="sideBarSearchArea">
              <input type="text" name="sideBarSearchInput" id="sideBarSearchInput">
            </div>
          </label>
          <div id="sideBarSearchBtn">
            <img src="/resources/images/sidebar/images/Search.svg" alt="">
          </div>
        </div>
      </div>

      <div class="body" id="SEARCH">
        <div class="sideBox search">
          <div class="category">ALL</div>
          <div class="category selected">패션</div>
          <div class="category">뷰티</div>
          <div class="category">생활</div>
          <div class="category">식품</div>
          <div class="category">전자제품</div>
          <div class="category">공구</div>
          <div class="category">자동차</div>
          <div class="category">스포츠 레저</div>
          <div class="category">유아  아동</div>
          <div class="category">도서  문구</div>
          <div class="category">반려동물</div>
        </div>

        <div class="content search">
          <div class="item">
            <div class="itemName">지역 <span>Location</span></div>
            <div class="itemContents">
              <div class="itemContent BTN selected">지도 검색</div>
            </div>
          </div>

          <div class="item">
            <div class="itemName">가격 <span>Price</span></div>
            <div class="itemRange">
              <div class="range-slider-container">
                <div class="slider-track">
                  <div class="progress"></div>
                </div>
                <label>
                  <span class="handle min"><span id="minValue">0</span></span>
                  <input type="range" class="min-range range-input">
                </label>
                <label>
                  <span class="handle max"><span id="maxValue">990000~</span></span>
                  <input type="range" class="max-range range-input">
                </label>
              </div>
            </div>
          </div>

          <div class="item">
            <div class="itemName">카테고리 <span>Category</span></div>
            <div class="itemContents">
              <div class="itemContent BTN selected">여성 의류</div>
              <div class="itemContent BTN">남성 의류</div>
              <div class="itemContent BTN selected">아동 의류</div>
              <div class="itemContent BTN">신발</div>
              <div class="itemContent BTN selected">가방 & 액서서리</div>
              <div class="itemContent BTN">스포츠웨어</div>
              <div class="itemContent BTN">스포츠웨어</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="/resources/js/sidebar/sideBarMain.js"></script>
</body>

</html>