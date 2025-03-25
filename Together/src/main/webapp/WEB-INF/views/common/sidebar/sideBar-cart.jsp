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
        <div><a href=""><img src="/resources/images/sidebar/images/X.svg" width="30px" height="30px" alt=""></a></div>
        <div>
          <a href=""><img src="/resources/images/sidebar/images/talk.svg" width="32px" height="32px" alt=""></a>
          <div class="noti noti-bar"><span>3</span></div>
        </div>
        <div><a href=""><img src="/resources/images/sidebar/images/+.svg" width="31px" height="32px" alt=""></a></div>
        <div><a href=""><img src="/resources/images/sidebar/images/ArrowUp.svg" height="30px" alt=""></a></div>
        <div><a href=""><img src="/resources/images/sidebar/images/ArrowDown.svg" height="30px" alt=""></a></div>
      </div>
    </div>

    <div class="sidebar-wrapper">
      <div class="title">
        <span>내가 찜한 목록</span>
      </div>
      <div class="body">
        <div class="talkMenu-box">
          <!-- 메뉴 추가 가능 -->
        </div>
        <div class="content">
          <!-- 찜한 목록 내용 영역 -->
        </div>
      </div>
    </div>
  </div>

  <script src="/resources/js/sidebar/sideBarMain.js"></script>
</body>
</html>