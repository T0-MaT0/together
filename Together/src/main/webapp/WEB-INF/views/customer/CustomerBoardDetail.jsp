<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>게시판 상세 조회</title>

    <link rel="stylesheet" href="/resources/css/customer/noticeBoardDetail-style.css" />
  
  </head>
  <body>
    ${map}
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div id="main-content">
      <section id="notice-header">

        <c:if test="${map.boardDetail.boardCd != 6}">
          <div id="notice-header-title" onclick="location.href='/customer/noticeBoardList'">📢 공지사항</div>
        </c:if>
        <c:if test="${map.boardDetail.boardCd == 6}">
          <div id="notice-header-title" onclick="location.href='/customer/noticeBoardList'">📢 1:1 문의글</div>
        </c:if>
        <div class="btn-wrap">
          <c:if test="${map.boardDetail.boardCd != 6 and not empty loginMember and loginMember.authority == 1}">
            <div class="btn-group">
              <div class="btn-update" onclick="location.href='/customer2/${map.boardDetail.boardCd}/${map.boardDetail.boardNo}/update?cp=${param.cp}'">수정</div>
              <div class="btn-delete" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='/customer2/${map.boardDetail.boardCd}/${map.boardDetail.boardNo}/delete'">삭제</div>
            </div>
          </c:if>
          <div id="go-to-list" onclick="location.href='/customer/noticeBoard'">목록으로</div>
        </div>
      </section>

      <section id="notice-detail-content">
        <div id="notice-title-space">
          <div class="notice-title">
            ${map.boardDetail.boardTitle}
          </div>
          <div id="notice-date">${map.boardDetail.bCreateDate}</div>
        </div>
        <div id="notice-content">${map.boardDetail.boardContent}</div>
      </section>

      
      <input type="hidden" id="boardCd" value="${map.boardDetail.boardCd}" />

      <c:if test="${map.boardDetail.boardCd != 6}">

        <section id="up-down-view">
  
          <!-- 이전글 있을 때만 출력 -->
          <c:if test="${not empty map.beforeAfterBoard and fn:length(map.beforeAfterBoard) > 0}">
            <div class="updown underline">
              <div class="front-">이전글</div>
              <div class="notice-title2">
                <a href="/customer/customerBoardDetail/${map.beforeAfterBoard[0].boardNo}">
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
                <a href="/customer/customerBoardDetail/${map.beforeAfterBoard[1].boardNo}">
                  ${map.beforeAfterBoard[1].boardTitle}
                </a>
              </div>
              <div>${map.beforeAfterBoard[1].bCreateDate}</div>
            </div>
          </c:if>
        
        </section>
      </c:if>

      <c:if test="${not empty map.customerReply}">
        <section id="reply-section">
          <h3>💬 관리자 답변</h3>
          <div class="reply-box">
            <div class="reply-date">작성일: ${map.customerReply.replyCreatedDate}</div>
            <div class="reply-content">${map.customerReply.replyContent}</div>
          </div>
        </section>
      </c:if>


      
      
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="/resources/js/customer/customerBoardDetail.js"></script>

</body>
</html>
