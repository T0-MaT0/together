<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>공지사항 상세</title>

    <link rel="stylesheet" href="/resources/css/customer/noticeBoardDetail-style.css" />
  </head>
  <body>
    ${map}
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div id="main-content">
      <section id="notice-header">
        <div id="notice-header-title" onclick="location.href='/customer/noticeBoardList'">📢 공지사항</div>
        <div id="go-to-list">목록으로</div>
      </section>

      <section id="notice-detail-content">
        <div id="notice-title-space">
          <div class="notice-title">
            ${map.noticeBoardDetail.boardTitle}
          </div>
          <div id="notice-date">${map.noticeBoardDetail.bCreateDate}</div>
        </div>
        <div id="notice-content">${map.noticeBoardDetail.boardContent}</div>
      </section>

      <section id="up-down-view">

        <!-- 이전글 있을 때만 출력 -->
        <c:if test="${not empty map.beforeAfterBoard and fn:length(map.beforeAfterBoard) > 0}">
          <div class="updown underline">
            <div class="front-">이전글</div>
            <div class="notice-title2">
              <a href="/customer/noticeBoardDetail/${map.beforeAfterBoard[0].boardNo}">
                ${map.beforeAfterBoard[0].boardTitle}
              </a>
            </div>
            <div>${map.beforeAfterBoard[0].bCreateDate}</div>
          </div>
        </c:if>
      
        <!-- 다음글 있을 때만 출력 -->
        <c:if test="${not empty map.beforeAfterBoard and fn:length(map.beforeAfterBoard) > 1}">
          <div class="updown">
            <div>다음글</div>
            <div class="notice-title2">
              <a href="/customer/noticeBoardDetail/${map.beforeAfterBoard[1].boardNo}">
                ${map.beforeAfterBoard[1].boardTitle}
              </a>
            </div>
            <div>${map.beforeAfterBoard[1].bCreateDate}</div>
          </div>
        </c:if>
      
      </section>

      
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="/resources/js/customer/noticeBoardDetail.js"></script>
  </body>
</html>
