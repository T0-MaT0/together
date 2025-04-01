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
        <img id="ownerProfileImg" src="/resources/images/user.png" alt="">
        <div id="memberListBox" class="hidden">
          <ul id="memberList"></ul>
        </div>
      </div>
    </div>
    <div class="chat-title">
      <span id="roomTitle"></span>
      <a href="#" id="memberListBtn" class="member-count-btn">
        👥 <span id="memberCount">0</span>
      </a>
    </div>
    
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

 <!-- 자주 묻는 질문 영역 -->
<div id="faqToggleBox" class="faq-toggle-box hidden">
  <button id="faqToggleBtn">자주 묻는 질문 메뉴 ▼</button>
  <ul id="faqList" class="faq-list">
    <li data-answer="공동구매는 주문 후 일정 인원이 모이면 결제됩니다.">공동구매는 어떻게 진행되나요?</li>
    <li data-answer="배송은 인원 모집 완료 후 2~3일 이내 시작됩니다.">배송은 언제 되나요?</li>
    <li data-answer="일정 인원이 모이지 않으면 자동으로 취소됩니다.">최소 인원이 안 모이면 어떻게 되나요?</li>
    <li data-answer="결제 후 마이페이지에서 취소 가능합니다.">결제나 취소가 가능한가요?</li>
    <li data-answer="결제일은 인원 모집이 완료된 다음날입니다.">결제는 언제 이루어지나요?</li>
  </ul>
</div>

  <div class="typing-area">
    <div class="textInput-area">
      <div><textarea id="inputChatting"></textarea></div>
    </div>
    <div class="typing-menu-box">
      <a href="#" id="emojiToggleBtn" class="no-link">
        <img src="/resources/images/sidebar/images/Smiling.svg" alt="이모지">
      </a>
      <div id="emojiPicker" class="emoji-picker hidden">
        <!-- 미니 이모지 (메시지 입력창에 삽입) -->
        <div class="emoji-section">
          <h4>😊 미니 이모지</h4>
          <div class="emoji-list">
            <span onclick="insertEmojiToInput('😂')">😂</span>
            <span onclick="insertEmojiToInput('❤️')">❤️</span>
            <span onclick="insertEmojiToInput('😍')">😍</span>
            <span onclick="insertEmojiToInput('🎉')">🎉</span>
            <span onclick="insertEmojiToInput('🔥')">🔥</span>
            <span onclick="insertEmojiToInput('👏')">👏</span>
          </div>
        </div>
        <hr>

        <!-- 큰 이모티콘 (바로 전송) -->
        <div class="emoji-section">
          <h4>🎉 큰 이모티콘</h4>
          <div id="bigEmojiContainer" class="big-emoji-container">
            <!-- Ajax로 채워짐 -->
          </div>
        </div>

      </div>
      <a href="#" class="no-link" id="imageUploadBtn">
        <img src="/resources/images/sidebar/images/Image.svg" alt="이미지 첨부">
      </a>
      <input type="file" id="chatImageInput" accept="image/*" style="display: none;">
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