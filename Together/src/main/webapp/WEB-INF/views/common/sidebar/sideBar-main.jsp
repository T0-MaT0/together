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
        <div><a href="" id="sideBar-close" class="no-link"><img src="/resources/images/sidebar/images/X.svg" width="30px" height="30px" alt=""></a></div>
        <div><a href="" id="togglePage" class="no-link"><img src="/resources/images/sidebar/images/talk.svg" width="32px" height="32px" alt=""></a></div>
        <div><a href="" class="no-link"><img src="/resources/images/sidebar/images/+.svg" width="31px" height="32px" alt=""></a></div>
        <div><a href="" class="no-link" id="scrollUp"><img src="/resources/images/sidebar/images/ArrowUp.svg" height="30px" alt=""></a></div>
        <div><a href="" class="no-link" id="scrollDown"><img src="/resources/images/sidebar/images/ArrowDown.svg" height="30px" alt=""></a></div>
      </div>
    </div>
    <div class="sidebar-wrapper">
      <div class="title">
        <span id="title">장바구니</span>
      </div>
      <div class="body hidden" id="CHAT">

        <div class="talkMenus sideBox">
          <div class="talkMenu select"><a href="" class="no-link" data-url="/sidebar/chat"><img src="/resources/images/sidebar/images/Home.svg" alt=""></a></div>          
          <div class="talkMenu unselect">
            <a href="" class="no-link" data-url="/sidebar/chatOpen?chattingNo=2">
              <img src="/resources/images/sidebar/images/Chat.svg" alt="">
            </a>
            <div class="noti noti-menu"><span>6</span></div>
          </div>
          <div class="talkMenu unselect"><a href="" class="no-link"><img src="/resources/images/sidebar/images/Setting.svg" alt=""></a></div>
        </div>


        <div class="content">
          <div class="profile-area">
            <div class="title-profile-box">
              <div class="profile profile-inTitle">
                <img src="/resources/images/sidebar/images/counselor.svg" alt="">
              </div>
            </div>
            <div class="chat-title"><span>투게더 상담원</span></div>
            <div class="title-menu-box">
              <div class="title-menu">
                <a href="">
                  <div class="circle-gradation plus">
                    <div></div>
                    <div></div>
                    <div></div>
                  </div>
                </a>
              </div>
              <div class="title-menu">
                <a href="">
                  <div class="circle-gradation minus">
                    <div></div>
                  </div>
                </a>
              </div>
            </div>
          </div>





          <div class="chat-area">
            <div class="other">
              <div class="nickname">투게더</div>
              <div class="profile-box">
                <div class="profile profile-inChat">
                  <img src="/resources/images/sidebar/images/counselor.svg" alt="">
                </div>
              </div>
              <div class="chat-boxes">
                <div class="chat-box">
                  <span>
                    안녕하세요! 😊<br>
                    함께 사고 함께 절약하는 투게더 입니다~<br>
                    이용 문의나 고객 문의에 대해서 물어보세요~~~~!
                  </span>
                </div>
              </div>
            </div>

            <div class="own">
              <div class="nickname">일이삼사오육칠팔구</div>
              <div class="profile-box">
                <div class="profile profile-inChat">
                  <img src="/resources/images/sidebar/images/sample.png" alt="">
                </div>
              </div>
              <div class="chat-boxes">
                <div class="chat-box">
                  <span>
                    ㅎ??????ㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹ
                  </span>
                </div>
                <div class="chat-box">
                  <span>
                    ??
                  </span>
                </div>
              </div>
            </div>

            <div class="other">
              <div class="nickname">투게더</div>
              <div class="profile-box">
                <div class="profile profile-inChat">
                  <img src="/resources/images/sidebar/images/counselor.svg" alt="">
                </div>
              </div>
              <div class="chat-boxes">
                <div class="chat-box">
                  <span>
                    안녕하세요! 😊
                  </span>
                </div>
                <div class="chat-box">
                  <span>
                    안녕
                  </span>
                </div>
                <div class="chat-box">
                  <span>
                    안녕
                  </span>
                </div>
              </div>
            </div>

            <div class="own">
              <div class="nickname">커비</div>
              <div class="profile-box">
                <div class="profile profile-inChat">
                  <img src="/resources/images/sidebar/images/sample.png" alt="">
                </div>
              </div>
              <div class="chat-boxes">
                
                <div class="chat-box">
                  <span>
                    ??
                  </span>
                </div>
                <div class="chat-box">
                  <span>
                    ??
                  </span>
                </div>
                <div class="chat-box">
                  <span>
                    ??
                  </span>
                </div>
                
                
              </div>
            </div>


            <div class="other">
              <div class="nickname">돌돌이</div>
              <div class="profile-box">
                <div class="profile profile-inChat">
                  <img src="/resources/images/sidebar/images/imageSample.png" alt="">
                </div>
              </div>
              <div class="chat-boxes">
                <div class="chat-box">
                  <span>
                    안녕하세요! 😊
                  </span>
                </div>
              </div>
            </div>

            <div class="other">
              <div class="nickname">투게더</div>
              <div class="profile-box">
                <div class="profile profile-inChat">
                  <img src="/resources/images/sidebar/images/counselor.svg" alt="">
                </div>
              </div>
              <div class="chat-boxes">
                <div class="chat-box">
                  <span>
                    안녕하세요! 😊
                  </span>
                </div>
                <div class="chat-box">
                  <span>
                    안녕
                  </span>
                </div>
                <div class="chat-box">
                  <span>
                    안녕
                  </span>
                </div>
              </div>
            </div>

          </div>

          <div class="typing-area">
            <div class="textInput-area">
              <div><input type="text"></div>
            </div>
            <div class="typing-menu-box">
              <a href=""><img src="/resources/images/sidebar/images/Smiling.svg" alt=""></a>
              <a href=""><img src="/resources/images/sidebar/images/Image.svg" alt=""></a>
              <a href=""><img src="/resources/images/sidebar/images/send.svg" alt=""></a>
            </div>
          </div>

        </div>


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
          <div class="chat-room-box">


            <div class="chat-room">
              <div class="profile-box">
                <div class="profile profile-inBox">
                  <img src="/resources/images/sidebar/images/counselor.svg" alt="">
                </div>
              </div>
              <div class="chat">
                <div class="chat-name">투게더 상담사</div>
                <div class="chat-content">안녕하세요. 상담하실 내용이 있으신..</div>
              </div>
              <div class="chat-info">
                <div class="noti noti-chat"><span>2</span></div>
                <div class="chat-time">오후 3:05</div>
              </div>
            </div>

            <div class="chat-room">
              <div class="profile-box">
                <div class="profile profile-inBox">
                  <img src="/resources/images/sidebar/images/sample.png" alt="">
                </div>
              </div>
              <div class="chat">
                <div class="chat-name">모든지 공구</div>
                <div class="chat-content">삼다수 정품 공구 선제시@@</div>
              </div>
              <div class="chat-info">
                <div class="noti noti-chat"><span>3</span></div>
                <div class="chat-time">오후 2:56</div>
              </div>
            </div>



            <div class="chat-room"></div>
            <div class="chat-room"></div>
            <div class="chat-room"></div>
          </div>
        </div>


        <div class="content hidden">
        </div>
        
      </div>
      
      <div class="body" id="PICK">
        <div class="sideBox pick"></div>
        <div class="content pick">
          <div id="pickListBox">

            <div class="itemBox">
              <div class="thumb">
                <img src="/resources/images/sidebar/images/imageSample.png" alt="">
              </div>
              <div class="digit">
                <div><span>75% 달성</span></div>
                <div><span>삼다수 16묶음중 1개 팝니다. 거의 나눔입니다.</span></div>
                <div>
                  <span>10000원(원가)<br>참가 모집 : 3 / 4명</span>
                </div>
                <div>
                  <div>공구슈킹</div>
                  <div>500원</div>
                </div>
                <div>
                  <div>참가</div>
                </div>
              </div>
              <div class="deleteBtn-area">
                <a href=""><img src="/resources/images/sidebar/images/X.svg" alt=""></a>
              </div>
            </div>
            



            <div class="itemBox">
              <div class="thumb soldOut">
                <img src="/resources/images/sidebar/images/imageSample.png" alt="">
              </div>
              <div class="digit">
                <div><span>75% 달성</span></div>
                <div><span>삼다수 16묶음중 1개 팝니다. 거의 나눔입니다.</span></div>
                <div>
                  <span>10000원(원가)<br>참가 모집 : 3 / 4명</span>
                </div>
                <div>
                  <div>공구슈킹</div>
                  <div>500원</div>
                </div>
                <div>

                  <div>수량 : </div>
                  <!-- js 객체로 묶어서 넘기기 -->
                  <input type="number" value="0" disabled>
                </div>
                <div>
                  
                  <img src="/resources/images/sidebar/images/checknon.svg" alt="">
                  <input type="hidden" value="0">
                  
                </div>
              </div>
              <div class="deleteBtn-area">
                <a href=""><img src="/resources/images/sidebar/images/X.svg" alt=""></a>
              </div>
            </div>
            


            
            
            <div class="itemBox">
              <div class="thumb">
                <img src="/resources/images/sidebar/images/imageSample.png" alt="">
              </div>
              <div class="digit">
                <div><span>75% 달성</span></div>
                <div><span>삼다수 16묶음중 1개 팝니다. 거의 나눔입니다.</span></div>
                <div>
                  <span>10000원(원가)<br>참가 모집 : 3 / 4명</span>
                </div>
                <div>
                  <div>공구슈킹</div>
                  <div>500원</div>
                </div>
                <div>
                  <div>참가</div>
                </div>
              </div>
              <div class="deleteBtn-area">
                <a href=""><img src="/resources/images/sidebar/images/X.svg" alt=""></a>
              </div>
            </div>
            <div class="itemBox">
              <div class="thumb">
                <img src="/resources/images/sidebar/images/imageSample.png" alt="">
              </div>
              <div class="digit">
                <div><span>75% 달성</span></div>
                <div><span>삼다수 16묶음중 1개 팝니다. 거의 나눔입니다.</span></div>
                <div>
                  <span>10000원(원가)<br>참가 모집 : 3 / 4명</span>
                </div>
                <div>

                  <div>수량 : </div>
                  <!-- js 객체로 묶어서 넘기기 -->
                  <input type="number" value="3" min="1">

                </div>
                <div>
                  <div>참가</div>
                </div>
              </div>
              <div class="deleteBtn-area">
                <a href=""><img src="/resources/images/sidebar/images/X.svg" alt=""></a>
              </div>
            </div>


      




          </div>

          <div id="buyBtn-box">
            <div class="selectAll">전부 선택</div>
            <div class="buyBtn">주 문 하 기</div>
            <div class="unselectAll">전부 해제</div>
          </div>
        </div>
      </div>
    </div>

    <!-- SockJS를 이용한 WebSocket 라이브러리 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="/resources/js/sidebar/sideBarMain.js"></script>

    <script>
      const loginMemberNo = "${loginMember.memberNo}";
      const loginMemberNickname = "${loginMember.memberNick}";
    </script>
</body>

</html>