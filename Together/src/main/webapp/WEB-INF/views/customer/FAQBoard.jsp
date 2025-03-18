<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pagination" value="${map.pagination}"/>
<c:set var="FAQList" value="${map.FAQList}"/>
<c:set var="boardCode" value="${map.boardCode}"/>
<c:if test="${!empty param.query}">
    <c:set var="qs" value="&key=${param.key}&query=${param.query}"/>
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ</title>
    <link rel="stylesheet" href="/resources/css/customer/FAQBoard-style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div id="main-content">

        <section id="FAQ-header">
            <div id="FAQ-header-title">❓ 자주 묻는 질문 (FAQ)</div>
            
            <form action="/board/search" method="GET">
                <fieldset class="search-area">
    
                    <input type="search" name="query" id="query"
                    placeholder="검색어를 입력해주세요.">
    
                    <button id="searchBtn" class="fa-solid fa-magnifying-glass"></button>
    
                </fieldset>
            </form>
        </section>
    
        <section id="FAQ-content">

            <!-- <div id="button-content">
                <div class="current-focus" id="allFAQ">전체</div>
                <div id="memberFAQ">회원/계정</div>
                <div id="togetherFAQ">공동구매</div>
                <div id="buyFAQ">결제/환불</div>
                <div id="shipFAQ">수령/배송</div>
                <div id="guitarFAQ">기타</div>
            </div> -->
            <div id="button-content">
                <div class="faq-btn current-focus" data-code="0">전체</div>
                <div class="faq-btn" data-code="9">회원/계정</div>
                <div class="faq-btn" data-code="10">공동구매</div>
                <div class="faq-btn" data-code="11">결제/환불</div>
                <div class="faq-btn" data-code="12">수령/배송</div>
                <div class="faq-btn" data-code="13">기타</div>
              </div>


         


            <table class="list-table">
                
                <thead id="fix-FAQ">
                </thead>

                <tbody>
                    <c:forEach var="FAQ" items="${FAQList}">
                        <tr>
                            <td onclick="openAnswer(event)">Q. ${FAQ.boardTitle}</td>
                            <td>▼</td>
                        </tr>
                        <tr class="answer-style hidden-answer">
                            <td colspan='2'>A. ${FAQ.boardContent}</td>
                        </tr>  
                    </c:forEach>
                </tbody>
            </table>

       
    
    
        </section>
    
        <div class="pagination-area">



            <c:set var="url" value="/customer/FAQBoard/${boardCode}?cp="/>


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
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/customer/FAQ.js"></script>

    

    
</body>
</html>