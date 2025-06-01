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
  <!-- 다음 주소 API -->
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<body>
  <div class="sideBar" id="sideBar">
    <!-- 메뉴 버튼 영역 -->
    <div class="sidebar-menu-box" id="sidebar-menu-box">
      <div class="sidebar-menu">
        <!-- 닫기 -->
        <div><a href="" id="sideBar-close" class="no-link activate"><img src="/resources/images/sidebar/images/X.svg" width="30px" height="30px" alt=""></a></div>
        <!-- 관심상품 -->
        <div><a href="" id="togglePage" class="no-link"><img id="togglePageIcon" src="/resources/images/sidebar/images/favorite-cart.svg" width="32px" height="32px" alt=""></a></div>
        <!-- 검색창 -->
        <div><a href="" id="searchPage" class="no-link"><img src="/resources/images/sidebar/images/+.svg" width="31px" height="32px" alt=""></a></div>
        <!-- 스크롤 위로 -->
        <div><a href="" class="no-link" id="scrollUp"><img src="/resources/images/sidebar/images/ArrowUp.svg" height="30px" alt=""></a></div>
        <!-- 스크롤 아래로 -->
        <div><a href="" class="no-link" id="scrollDown"><img src="/resources/images/sidebar/images/ArrowDown.svg" height="30px" alt=""></a></div>
      </div> 
    </div> <!-- 메뉴 버튼 영역 끝 -->

    <!-- 채팅 영역 -->
    <div class="sidebar-wrapper hidden">
      <!-- 채팅 제목 -->
      <div class="title">
        <span id="sideBarTitle">채팅</span>
      </div>
      <!-- 채팅 메뉴 -->
      <div class="body" id="CHAT">
        <!-- 채팅 사이드바 -->
        <div class="talkMenus sideBox">
          <div class="talkMenu unselect"> 
            <a href="" class="no-link" data-url="/sidebar/chat">
              <!-- 채팅방 버튼 -->
              <img src="/resources/images/sidebar/images/Chat.svg" alt="">
              <!-- 알림 뱃지 -->
              <div id="chatNotiBadge" class="noti noti-menu" style="display:none;"><span>0</span></div>
            </a>
          </div>          
          <!-- 상담톡 버튼 -->
          <div class="talkMenu unselect" id="consultMenu" >
              <a href="" class="no-link">
                <img src="/resources/images/sidebar/images/Home.svg" alt="">
              </a>
          </div>
        </div><!-- 채팅 사이드바 끝 -->

        <!-- 채팅방 내부 영역 -->
        <div class="content">
          <!-- 프로필 영역 -->
          <div class="profile-area">
            <div class="title-profile-box">
              <div class="profile profile-inTitle">
                <img src="/resources/images/sidebar/images/counselor.svg" alt="">
              </div>
            </div>
            <!-- 방 이름 -->
            <div class="chat-title"><span>채팅 상대</span></div>
            <!-- +버튼(채팅방 목록으로) -->
            <div class="title-menu-box">
              <div class="title-menu">
                <a href="#">
                  <div class="circle-gradation plus">
                    <div></div><div></div><div></div>
                  </div>
                </a>
              </div>
              <!-- -버튼(채팅방 삭제) -->
              <div class="title-menu">
                <a href="#">
                  <div class="circle-gradation minus"><div></div></div>
                </a>
              </div>
            </div>
          </div> <!-- 프로필 영역 종료 -->

          <!-- 채팅 메시지 영역 -->
          <div class="chat-area">
            <ul class="display-chatting" id="chatMessageList"></ul>
          </div>

          <!-- 채팅 입력창 영역 -->
          <div class="typing-area">
            <div class="textInput-area">
              <div><input type="text" id="inputChatting" placeholder="메시지를 입력하세요"></div>
            </div>
            <!-- 입력창 메뉴 -->
            <div class="typing-menu-box">
              <!-- 이모티콘 버튼 -->
              <a href="#"><img src="/resources/images/sidebar/images/Smiling.svg" alt=""></a>
              <!-- 사진 추가 버튼 -->
              <a href="#"><img src="/resources/images/sidebar/images/Image.svg" alt=""></a>
              <!-- 메시지 입력 버튼 -->
              <button id="sendMessageBtn" class="no-link">
                <img src="/resources/images/sidebar/images/send.svg" alt="보내기">
              </button>
            </div> <!-- 입력창 메뉴 끝 -->
          </div> <!-- 채팅 입력창 영역 끝 -->
        </div> <!-- 채팅방 내부 영역 끝 -->

        <!-- 채팅방 목록 영역 -->
        <div class="content hidden">
          <!-- 채팅방 제목 검색 -->
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
          </div> <!-- 채팅방 제목 검색 끝 -->
          <!-- 채팅방 목록 -->
          <div class="chat-room-box"></div>
        </div> <!-- 채팅방 목록 영역 끝 -->

        <!-- 추가 콘텐츠 영역 -->
        <div class="content hidden"></div>
      </div><!-- 채팅 메뉴 끝 -->
    </div><!-- 채팅 영역 끝 -->

    <!-- 관심 상품 영역 -->
    <div class="sidebar-wrapper hidden">
      <!-- 제목 -->
      <div class="title">
        <span id="sideBarTitle">관심상품</span>
      </div>
      <div class="body" id="PICK">

        <div class="sideBox pick"></div>
        <div class="content pick">
          <!-- 관심 상품 출력 부분 -->
          <div id="pickListBox"></div>
          <!-- 구매하기 버튼 -->
          <div id="buyBtn-box">
            <div class="selectAll">전부 선택</div>
            <div class="buyBtn">주 문 하 기</div>
            <div class="unselectAll">전부 해제</div>
          </div>
        </div>
      </div> 
    </div><!-- 관심 상품 영역 끝 -->

    <!-- 검색 영역 -->
    <div class="sidebar-wrapper">
      <div class="title">
        <!-- 타이틀 -->
        <span id="title"></span>
        <!-- 검색 입력 창 -->
        <div class="Search-box">
          <label for="sideBarSearchInput">
            <div id="sideBarSearchArea"><input type="text" name="sideBarSearchInput" id="sideBarSearchInput" placeholder="검색어를 입력해 주세요."></div>
          </label>
          <!-- 검색 버튼 -->
          <div id="sideBarSearchBtn"><img src="/resources/images/sidebar/images/Search.svg" alt=""></div>
        </div>
      </div>
      <!-- 검색 카테고리 영역 -->
      <div class="body" id="SEARCH">
        <!-- 검색 사이드바 카테고리 -->
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
          <div class="category" data-catego ryNo="10">도서 문구</div>
          <div class="category" data-categoryNo="11">반려동물</div>
        </div> <!-- 검색 사이드바 카테고리 끝 -->

        <!-- 검색 내용 설정 -->
        <div class="content search">
          <div class="member-bar" id="memberBar">
            <div class="under-line company-line" id="underLine"></div>
            <a class="member-type bold" data-type="personal">브랜드 상품</a>
            <a class="member-type" data-type="company">공구 모집</a>
            <div id="bottomLine"></div>
          </div>
          
          <!-- 가격 설정 부분 -->
          <div class="item" id="priceRange">
            <div class="itemName">가격 <span>Price</span></div>
            <div class="itemRange">
              <div class="range-slider-container">
                <div class="slider-track">
                  <div class="progressBar"></div> <!-- 변경된 클래스 이름 -->
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
          </div> <!-- 가격 설정 부분 끝 -->

          <!-- 카테고리 분류 설정 -->
          <div class="item" id = "categoryList">
            <div class="itemName" >카테고리 <span>Category</span></div>
            <div class="itemContents" id="categoryListItems">
              원하는 분류를 선택해주세요.
            </div>
          </div><!-- 카테고리 분류 설정 끝 -->

          <!-- 지역 설정(공구 모집만) -->
          <div class="item hidden" id = "locationList">
            <div class="itemName">지역 <span>Location</span></div>
            <div class="itemContents">
              <div class="itemContent BTN selected" onclick="sample4_execDaumPostcode()">지도 검색</div>
              <input type="text" id="sample4_jibunAddress" placeholder="지번주소">
            </div>
          </div><!-- 지역 설정 끝 -->

          <!-- 검색 상품 목록 -->
          <div class="item" id = "searchItemList"></div>
        </div> <!-- 검색 내용 설정 끝 -->
      </div><!-- 검색 카테고리 영역 끝 -->
    </div><!-- 검색 영역 끝 -->
 </div> <!-- 사이드바 끝 -->  
    
    <!-- SockJS를 이용한 WebSocket 라이브러리 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <!-- 사이드바 js -->
    <script src="/resources/js/sidebar/sideBarMain.js"></script>
    
    <script>
      memberNo = "${loginMember.memberNo}";
      const loginMemberNo = "${loginMember.memberNo}";
      const loginMemberNickname = "${loginMember.memberNick}";
    </script>
</body>

</html>