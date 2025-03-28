<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QnA</title>
<link rel="stylesheet" href="/resources/css/my_info/QnA.css">
<link rel="stylesheet" href="/resources/css/my_info/mypage.css">
<link rel="stylesheet" href="/resources/css/my_info/ask.css">

</head>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<body>

	<main class="myinfo-container">

		<!-- 사이드바 -->
    <jsp:include page="/WEB-INF/views/member/mypage/mypage-sidebar.jsp" />


		<div class="myinfo-content-wrapper">

            <!-- 메인 콘텐츠 -->
            <section class="myinfo-main-content">
                <section class="qa-section styled-ask-card" id="ask-section">
                    <h2 class="qa-title">1:1 문의</h2>
                    <p class="qa-count">현재까지 회원님의 문의 내역입니다.</p>

                    <div class="qa-container" id="ask-container">
                        <c:forEach var="ask" items="${map.askList}">
                            <div class="qa-item clean-qa-card">
                                <div class="qa-left">
                                  <p class="qa-title">
                                    <a href="/customer/customerBoardDetail/${ask.boardNo}?cp=${pagination.currentPage}">
                                      ${ask.boardTitle}
                                    </a>
                                  </p>
                                </div>
                                <div class="qa-right">
                                  <p class="qa-date">작성일: ${ask.bCreateDate}</p>
                                  <button class="qa-btn"
                                    onclick="location.href='/customer/customerBoardDetail/${ask.boardNo}?cp=${pagination.currentPage}'">
                                    상세조회
                                  </button>
                                </div>
                              </div>
                        </c:forEach>

                        <c:set var="pagination" value="${map.pagination}" />
                        <c:if test="${!empty param.query}">
                            <c:set var="qs" value="&query=${param.query}" />
                        </c:if>

                        <!-- 페이지네이션 영역 -->
                        <div class="pagination-area">
                        <c:set var="url" value="/mypage/ask?cp=" />

                        <ul class="pagination">
                            <!-- 첫 페이지 -->
                            <li><a href="${url}1${qs}">&lt;&lt;</a></li>

                            <!-- 이전 목록 -->
                            <li><a href="${url}${pagination.prevPage}${qs}">&lt;</a></li>

                            <!-- 페이지 숫자 -->
                            <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
                            <c:choose>
                                <c:when test="${pagination.currentPage == i}">
                                <li><a class="current">${i}</a></li>
                                </c:when>
                                <c:otherwise>
                                <li><a href="${url}${i}${qs}">${i}</a></li>
                                </c:otherwise>
                            </c:choose>
                            </c:forEach>

                            <!-- 다음 목록 -->
                            <li><a href="${url}${pagination.nextPage}${qs}">&gt;</a></li>

                            <!-- 마지막 페이지 -->
                            <li><a href="${url}${pagination.maxPage}${qs}">&gt;&gt;</a></li>
                        </ul>
                        </div>

                    </div>
                </section>
            </section>
        </div>
    </main>


</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="/resources/js/member/mypages.js"></script>
</html>