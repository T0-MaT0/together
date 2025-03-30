<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pagination" value="${map.pagination}"/>
<c:set var="FAQList" value="${map.FAQList}"/>
<c:set var="boardCode" value="${map.boardCode}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>FAQ</title>
  <link rel="stylesheet" href="/resources/css/customer/FAQBoard-style.css">
  <script src="https://kit.fontawesome.com/385a4842a7.js" crossorigin="anonymous"></script>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div id="main-content">
  <section id="FAQ-header">
    <div id="FAQ-header-title" onclick="location.href='/customer/FAQBoard/0'">❓ 자주 묻는 질문 (FAQ)</div>
    <form action="/customer/FAQBoard/search" method="GET">
      <fieldset class="search-area">
        <input type="search" name="query" id="query" placeholder="검색어를 입력해주세요." value="${param.query}">
        <button id="searchBtn" class="fa-solid fa-magnifying-glass"></button>
      </fieldset>
    </form>
  </section>

  <section id="FAQ-content">
    <div id="button-content">
      <div class="faq-btn current-focus" data-code="0">전체</div>
      <div class="faq-btn" data-code="9">회원/계정</div>
      <div class="faq-btn" data-code="10">공동구매</div>
      <div class="faq-btn" data-code="11">결제/환불</div>
      <div class="faq-btn" data-code="12">수령/배송</div>
      <div class="faq-btn" data-code="13">기타</div>
    </div>

    <c:choose>
        <c:when test="${!empty FAQList}">
            <table class="list-table">
              <thead id="fix-FAQ"></thead>
              <tbody id="faq-list-body">
                <c:forEach var="FAQ" items="${FAQList}">
                  <tr>
                    <td>Q. ${FAQ.boardTitle}</td>
                    <td>▼</td>
                  </tr>
                  <tr class="answer-style hidden-answer">
                    <td colspan="2">
                      <div class="answer-wrapper">
                        <div class="answer-text">
                          <span class="answer-inner">A. ${FAQ.boardContent}</span>
                        </div>
                        <c:if test="${loginMember.authority == 1}">
                          <div class="faq-admin-btns">
                            <button onclick="editFAQ(${FAQ.boardNo})">수정</button>
                            <button onclick="deleteFAQ(${FAQ.boardNo})">삭제</button>
                          </div>
                        </c:if>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>

        </c:when>
        <c:otherwise>
            <!-- 게시글 목록 조회 결과가 없는 경우-->
            <tr>
                <th>게시글이 존재하지 않습니다.</th>
            </tr>
        </c:otherwise>
    </c:choose>
  </section>

  <div class="pagination-area" id="faq-pagination">
    <c:choose>
    <c:when test="${not empty param.query}">
        <c:set var="url" value="/customer/FAQBoard/search?cp=" />
        <c:set var="qs" value="&query=${param.query}" />
    </c:when>
    <c:otherwise>
        <c:set var="url" value="/customer/FAQBoard/${boardCode}?cp=" />
        <c:set var="qs" value="" />
    </c:otherwise>
    </c:choose>

    
    <ul class="pagination">
    <li><a href="${url}1${qs}">&lt;&lt;</a></li>
    <li><a href="${url}${pagination.prevPage}${qs}">&lt;</a></li>
    
    <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
        <li>
        <a class="${pagination.currentPage == i ? 'current' : ''}" href="${url}${i}${qs}">${i}</a>
        </li>
    </c:forEach>
    
    <li><a href="${url}${pagination.nextPage}${qs}">&gt;</a></li>
    <li><a href="${url}${pagination.maxPage}${qs}">&gt;&gt;</a></li>
    </ul>
  </div>
  

  <div class="write-board-button-area">
    <c:if test="${loginMember.authority == 1}">
      <a href="/customer2/4/insert" id="write-board-button">글작성하기</a>
    </c:if>
  </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<script src="/resources/js/customer/FAQ.js"></script>

</body>
</html>
