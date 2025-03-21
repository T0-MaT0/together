<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pagination" value="${map.pagination}"/>
<c:set var="noticeList" value="${map.noticeList}"/>
<c:if test="${!empty param.query}">
    <c:set var="qs" value="&key=${param.key}&query=${param.query}"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지 리스트</title>
    <link rel="stylesheet" href="/resources/css/customer/noticeBoardList-style.css">
</head>
<body>
    ${map}
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div id="main-content">

        <section id="notice-header">
            <div id="notice-header-title">📢  공지사항</div>
            
            <form action="/board/search" method="GET">
                <fieldset class="search-area">
    
                    <input type="search" name="query" id="query"
                    placeholder="검색어를 입력해주세요.">
    
                    <button id="searchBtn" class="fa-solid fa-magnifying-glass"></button>
    
                </fieldset>
            </form>
        </section>
    
        <section id="notice-content">
         
            <div id="bg-color">

                <table class="list-table">
                    
                    <thead id="fix-notice">
                        <tr>
                            <th id="notice-num">355</th>
                            <th id="notice-title">
                                <a href="#">
                                    [업데이트] 공동구매 채팅 기능 추가 🚀   
                                </a></th>
                            <th id="notice-date">2024-02-10</th>
                        </tr>
                        <tr>
                            <th>354</th>
                            <th><a href="#">
                                [공지] 설 연휴 고객센터 운영 시간 안내 🏡</a></th>
                            <th>2024-02-05</th>
                        </tr>
                        <tr>
                            <th>347</th>
                            <th><a href="#">
                                [주의] 사기 피해 예방 안내 🚨
                            </a></th>
                            <th>2023-12-30</th>
                        </tr>
                        <tr>
                            <th>349</th>
                            <th><a href="#">
                                [이벤트] 친구 초대하면 적립금 지급 💰
                            </a></th>
                            <th>2024-01-10</th>
                        </tr>
                    </thead>
    
                    <tbody>

                        <c:forEach var="notice" items="${noticeList}">
                            <tr>
                                <td>${notice.boardNo}</td>
                                <td><a href="/customer/noticeBoardDetail/${notice.boardNo}">
                                    ${notice.boardTitle}
                                </a></td>
                                <td>${notice.bCreateDate}</td>
                            </tr>    
                        </c:forEach>
                    </tbody>
                </table>
            </div>

    
        </section>

        <div class="pagination-area">



            <c:set var="url" value="/customer/noticeBoardList?cp="/>


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