<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pagination" value="${map.pagination}"/>
<c:set var="noticeList" value="${map.noticeList}"/>
<c:if test="${!empty param.query}">
    <c:set var="qs" value="&query=${param.query}"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지 리스트</title>
    <link rel="stylesheet" href="/resources/css/customer/noticeBoardList-style.css">
    <script src="https://kit.fontawesome.com/f0f55b003e.js" crossorigin="anonymous"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div id="main-content">

        <section id="notice-header">
            <div id="notice-header-title" onclick="location.href='/customer/noticeBoardList'">📢  공지사항</div>
            
            <form action="/customer/notice/search" method="GET">
                <fieldset class="search-area">
    
                    <input type="search" name="query" id="query"
                    placeholder="검색어를 입력해주세요." value="${param.query}">
    
                    <button id="searchBtn" class="fa-solid fa-magnifying-glass"></button>
    
                </fieldset>
            </form>
        </section>
    
        <section id="notice-content">
         
            <div id="bg-color">

                <table class="list-table">
                    
                <thead id="fix-notice">
                    <c:forEach var="fixed" items="${fixedList}">
                        <tr>
                        <th class="notice-num">${fixed.boardNo}</th>
                        <th class="notice-title">
                            <a href="/customer/customerBoardDetail/${fixed.boardNo}?cp=${pagination.currentPage}${qs}">
                            ${fixed.boardTitle}
                            </a>
                        </th>
                        <th class="notice-date">${fixed.bCreateDate}</th>
                        </tr>
                    </c:forEach>
                    </thead>
    
                    <tbody>

                        <c:forEach var="notice" items="${noticeList}">
                            <tr>
                                <td class="notice-num">${notice.boardNo}</td>
                                <td class="notice-title"><a href="/customer/customerBoardDetail/${notice.boardNo}?cp=${pagination.currentPage}${qs}">
                                    ${notice.boardTitle}
                                </a></td>
                                <td class="notice-date">${notice.bCreateDate}</td>
                            </tr>    
                        </c:forEach>
                    </tbody>
                </table>
            </div>

    
        </section>

        <div class="pagination-area">


            <c:choose>
            <c:when test="${not empty param.query}">
                <c:set var="url" value="/customer/notice/search?cp=" />
                <c:set var="qs" value="&query=${param.query}" />
            </c:when>
            <c:otherwise>
                <c:set var="url" value="/customer/noticeBoardList?cp=" />
                <c:set var="qs" value="" />
            </c:otherwise>
            </c:choose>


            <ul class="pagination">
            
                <!-- 첫 페이지로 이동 -->
                <li><a href="${url}1${qs}">&lt;&lt;</a></li>

                <!-- 이전 목록 마지막 번호로 이동 -->
                <li><a href="${url}${pagination.prevPage}${qs}">&lt;</a></li>

                
                <!-- 특정 페이지로 이동 -->
                
                <!-- 범위가 정해진 일반 for문 사용-->
                <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
                    <c:choose>
                        <c:when test="${pagination.currentPage == i}">
                            <!-- 현재 페이지인 경우 -->
                            <li><a class="current">${i}</a></li>
                        </c:when>

                        <c:otherwise>
                            <!-- 현재 페이지가 아닌 경우 -->
                            <li><a href="${url}${i}${qs}">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach> 
                
                <!-- 다음 목록 시작 번호로 이동 -->
                <li><a href="${url}${pagination.nextPage}${qs}">&gt;</a></li>

                <!-- 끝 페이지로 이동 -->
                <li><a href="${url}${pagination.maxPage}${qs}">&gt;&gt;</a></li>

            </ul>
        </div>


        
        <div class="write-board-button-area">
            <c:if test="${loginMember.authority == 1}">
                <a href="/customer2/3/insert" id="write-board-button">글작성하기</a>
            </c:if>
        </div>

    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>