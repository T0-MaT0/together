<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/resources/css/sideBar.css">

<!-- 현재 채팅방 번호를 data 속성으로 담아둠 (필수) -->
<div id="chatRoom" data-room-no="${param.chattingNo}"
                      data-room-name="${room.roomName}"
                      data-owner-profile="${room.ownerProfile}">
  <div class="profile-area">
    <div class="title-profile-box">
      <div class="profile profile-inTitle">
        <img id="ownerProfileImg" src="/resources/images/sidebar/images/counselor.svg" alt="">
      </div>
    </div>
    <div class="chat-title"><span id="roomTitle"></span></div>
    <div class="title-menu-box">
      <div class="title-menu ">
        <a href="#">
          <div class="circle-gradation plus"><div></div><div></div><div></div></div>
        </a>
      </div>
      <div class="title-menu">
        <a href="#" >
          <div class="circle-gradation minus"><div></div></div>
        </a>
      </div>
    </div>
  </div>

  <div class="chat-area">
    <ul class="display-chatting" id="chatMessageList"></ul>
  </div>

  <div class="typing-area">
    <div class="textInput-area">
      <div><textarea id="inputChatting"></textarea></div>
    </div>
    <div class="typing-menu-box">
      <a href="#" class="no-link"><img src="/resources/images/sidebar/images/Smiling.svg" alt=""></a>
      <a href="#" class="no-link"><img src="/resources/images/sidebar/images/Image.svg" alt=""></a>
      <a href="" class="no-link" id="sendMessageBtn">
        <img src="/resources/images/sidebar/images/send.svg" alt="보내기">
      </a>
    </div>
  </div>
</div>

<script>
  const loginMemberNo = "${loginMember.memberNo}";
  const loginMemberNickname = "${loginMember.memberNick}";

</script>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="/resources/js/sidebar/sideBarMain.js"></script>