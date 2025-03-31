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
  <div class="sideBar" id="sideBar">
    <div class="sidebar-menu-box" id="sidebar-menu-box">
      <div class="sidebar-menu">
        <div><a href="" id="sideBar-close" class="no-link activate"><img src="/resources/images/sidebar/images/X.svg" width="30px" height="30px" alt=""></a></div>
        <div><a href="" id="togglePage" class="no-link"><img id="togglePageIcon" src="/resources/images/sidebar/images/favorite-cart.svg" width="32px" height="32px" alt=""></a></div>
        <div><a href="" id="searchPage" class="no-link"><img src="/resources/images/sidebar/images/+.svg" width="31px" height="32px" alt=""></a></div>
        <div><a href="" class="no-link" id="scrollUp"><img src="/resources/images/sidebar/images/ArrowUp.svg" height="30px" alt=""></a></div>
        <div><a href="" class="no-link" id="scrollDown"><img src="/resources/images/sidebar/images/ArrowDown.svg" height="30px" alt=""></a></div>
      </div>
    </div>
    <div class="sidebar-wrapper">
      <div class="title">
        <span id="sideBarTitle">채팅</span>
      </div>
      <div class="body" id="CHAT">

        <div class="talkMenus sideBox">
          <div class="talkMenu unselect"> 
            <a href="" class="no-link" data-url="/sidebar/chat">
              <img src="/resources/images/sidebar/images/Chat.svg" alt="">
              <div id="chatNotiBadge" class="noti noti-menu" style="display:none;"><span>0</span></div>
            </a>
          </div>          
          <div class="talkMenu unselect" id="consultMenu">
              <a href="" class="no-link">
                <img src="/resources/images/sidebar/images/Home.svg" alt="">
              </a>
          </div>
        </div>


        <div class="content">
          <!-- 프로필 영역 -->
          <div class="profile-area">
            <div class="title-profile-box">
              <div class="profile profile-inTitle">
                <img src="/resources/images/sidebar/images/counselor.svg" alt="">
              </div>
            </div>
            <div class="chat-title"><span>채팅 상대</span></div>
            <div class="title-menu-box">
              <div class="title-menu">
                <a href="#">
                  <div class="circle-gradation plus">
                    <div></div><div></div><div></div>
                  </div>
                </a>
              </div>
              <div class="title-menu">
                <a href="#">
                  <div class="circle-gradation minus"><div></div></div>
                </a>
              </div>
            </div>
          </div>

          <!-- 채팅 메시지 영역 -->
          <div class="chat-area">
            <ul class="display-chatting" id="chatMessageList"></ul>
          </div>

          <!-- 채팅 입력창 영역 -->
          <div class="typing-area">
            <div class="textInput-area">
              <div><input type="text" id="inputChatting" placeholder="메시지를 입력하세요"></div>
            </div>
            <div class="typing-menu-box">
              <a href="#"><img src="/resources/images/sidebar/images/Smiling.svg" alt=""></a>
              <a href="#"><img src="/resources/images/sidebar/images/Image.svg" alt=""></a>
              <button id="sendMessageBtn" class="no-link">
                <img src="/resources/images/sidebar/images/send.svg" alt="보내기">
              </button>
            </div>
          </div>
        </div>

        <!-- 채팅방 목록 영역 -->
        <div class="content hidden">
          <div class="search-area">
            <label for="sideBar-input">
              <form action="">
                <input type="text" placeholder="검색" name="sideBar-input" id="sideBar-input">
                <button type="submit" id="sideBar-search"></button>
                <label for="sideBar-search">
                  <div class="button" id="sideBar-button">
                    <img src="/resources/images/sidebar/images/Search.svg" alt="">
                  </div>
                </label>
              </form>
            </label>
          </div>
          <div class="chat-room-box"></div>
        </div>

        <!-- 추가 콘텐츠 영역 -->
        <div class="content hidden"></div>
      </div>
    </div>



    <div class="sidebar-wrapper hidden">
      <div class="title">
        <span id="sideBarTitle">관심상품</span>
      </div>
      <div class="body" id="PICK">
        <div class="sideBox pick"></div>
        <div class="content pick">
          <div id="pickListBox">

          </div>


          <div id="buyBtn-box">
            <div class="selectAll">전부 선택</div>
            <div class="buyBtn">주 문 하 기</div>
            <div class="unselectAll">전부 해제</div>
          </div>
        </div>
      </div>
    </div>




    <div class="sidebar-wrapper hidden">
      <div class="title">
        <span id="title"></span>
        <div class="Search-box">
          <label for="sideBarSearchInput">
            <div id="sideBarSearchArea"><input type="text" name="sideBarSearchInput" id="sideBarSearchInput" ></div>
          </label>
          <div id="sideBarSearchBtn"><img src="images/Search.svg" alt=""></div>
        </div>
      </div>
      <div class="body" id="SEARCH">
        <div class="sideBox search">
          <div class="category selected" data-categoryNo="0">ALL</div>
          <div class="category" data-categoryNo="1">패션</div>
          <div class="category" data-categoryNo="2">뷰티</div>
          <div class="category" data-categoryNo="3">생활</div>
          <div class="category" data-categoryNo="4">식품</div>
          <div class="category" data-categoryNo="5">전자제품</div>
          <div class="category" data-categoryNo="6">공구</div>
          <div class="category" data-categoryNo="7">자동차</div>
          <div class="category" data-categoryNo="8">스포츠 레저</div>
          <div class="category" data-categoryNo="9">유아 아동</div>
          <div class="category" data-categoryNo="10">도서 문구</div>
          <div class="category" data-categoryNo="11">반려동물</div>
        </div>




        <div class="content search">
          <div class="member-bar" id="memberBar">
            <div class="under-line company-line" id="underLine"></div>
            <a class="member-type bold" data-type="personal">브랜드 상품</a>
            <a class="member-type" data-type="company">공구 모집</a>
            <div id="bottomLine"></div>
          </div>
          <div class="item" id = "locationList">
            <div class="itemName">지역 <span>Location</span></div>

            <div class="itemContents">
              <div class="itemContent BTN selected">GPS 검색</div>
              <div class="itemContent BTN">직접 선택</div>
            </div>
              

          </div>
          <div class="item" id = "priceRange">
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
          <div class="item" id = "categoryList">
            <div class="itemName" >카테고리 <span>Category</span></div>

            <div class="itemContents" id="categoryListItems">
              <div class="itemContent BTN selected" data-subCategoryNo="12">여성 의류</div>
              <div class="itemContent BTN ">남성 의류</div>
              <div class="itemContent BTN selected">아동 의류</div>
              <div class="itemContent BTN ">신발</div>
              <div class="itemContent BTN selected"> 가방 & 액서서리</div>
              <div class="itemContent BTN ">스포츠웨어</div>
              <div class="itemContent BTN ">스포츠웨어</div>
            </div>
              

          </div>
            




          </div>
        </div>
      
    </div>




    
    
    <!-- SockJS를 이용한 WebSocket 라이브러리 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="/resources/js/sidebar/sideBarMain.js"></script>
    

    <script>
      const memberNo = "${loginMember.memberNo}";
      const loginMemberNo = "${loginMember.memberNo}";
      const loginMemberNickname = "${loginMember.memberNick}";
    </script>
</body>

</html>