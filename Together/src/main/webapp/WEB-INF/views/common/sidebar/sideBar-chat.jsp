<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/resources/css/sideBar.css">

<!-- 채팅 검색창 -->
<div class="search-area">
  <label for="sideBar-input">
    <form onsubmit="return false;">
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

<!-- 채팅방 목록 -->
<div class="chat-room-box"></div>

<script src="/resources/js/sidebar/sideBarChat.js"></script>
<script>
  document.addEventListener("DOMContentLoaded", loadChatRoomList);
  const loginMemberNo = "${loginMember.memberNo}";
  const loginMemberNickname = "${loginMember.memberNick}";
</script>
