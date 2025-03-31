<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<c:set var="menuName" value="brand"/> <!-- 사이드 메뉴 설정 -->

<c:set var="pagination" value="${map.pagination}"/>
<c:set var="dataLookList" value="${map.dataLookList}"/>

<c:set var="menuNumber" value="4"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/manager-css/manager-common.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/brand/result-list.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/graph.css" />
    <script>
        // 사이드 메뉴 설정
        const menuName = "${menuName}";
        const menuNumber = "${menuNumber}";
    </script>
</head>

<body>

</body>

<main>
    
     <!-- 사이드 메뉴 -->
     <jsp:include page="/WEB-INF/views/manager/common/sideMenu.jsp"/>




    <!-- 위쪽 영역 -->
    <header>
        <div class="head-title">
            <div>브랜드 관리</div>
             &nbsp; <div> - 성과</div>
             <jsp:include page="/WEB-INF/views/manager/common/searchManager.jsp"/>
        </div>
    </header>

    <!-- 본문(종앙) -->
    <div id="container-center">
        <section class="cus-board list-card mainBoard">
            <!-- 성과 데이터 리스트 -->
            <div class="board-title bottom-line">
                <div class="title">성과 데이터</div>
                <div class="select-area">
                    <!-- <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>클릭수</option>
                        <option>상품수</option>
                    </select> -->
                </div>
            </div>

            <!-- 리스트 내역 -->
            
            <div id="list-area">
                <div class="list">
                    <div>순위</div>
                    <div>브랜드</div>
                    <div>상품명</div>
                    <div>판매일자</div>
                    <div>클릭수</div>
                    <div>판매수</div>
                </div>
                
                <c:forEach  items="${dataLookList}" var="data">
                    <div class="list item bottom-line" onclick="brandProfile(${data.boardNo})">
                        <div>${data.boardNo}</div>
                        <div>${data.brandName}</div>
                        <div>${data.boardTitle}</div>
                        <div>${data.createDate}</div>
                        <div>${data.readCount}</div>
                        <div>${data.quantity}</div>
                    </div>
                </c:forEach>
                
                <!-- <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div> -->
                
 

            </div>

            <c:set var="urlCp" value="/manageBrand/dataLook?cp="></c:set>
            <ul id="pagination">
                <li><a href="${urlCp}1">&lt;&lt;</a></li>
                <li><a href="${urlCp}${pagination.prevPage}">&lt;</a></li>
                
                    <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
                        <c:choose>
                            <c:when test="${pagination.currentPage == i}">
                                <!-- 현재 페이지인 경우 -->
                                <li class="curr">${i}</li>
                            </c:when>
            
                            <c:otherwise>
                                <!-- 현재 페이지가 아닌 경우 -->
                                <li><a href="${urlCp}${i}">${i}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>                
                
                <li><a href="${urlCp}${pagination.nextPage}">&gt;</a></li>
                <li><a href="${urlCp}${pagination.maxPage}">&gt;&gt;</a></li>
            </ul>

        </section>


        
        <!-- 광고 신청 규모 -->
        <section class="cus-board graph-card">
        
            <div class="board-title ">
                <div class="title">판매 순위</div>
                <div class="select-area" style="display: flex;">
                    <div style="color: blue; font-size: normal;">판매수</div>
                    <div style="color: red; margin-left: 10px ; font-size: normal;">클릭수</div>
                    <!-- <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>주</option>
                        <option>월</option>
                        <option>년</option>
                    </select> -->
                </div>
                
            </div>
        <c:set var="maxQuantity" value="0" />
        <c:forEach var="data" items="${map.dataRank}">
            <c:if test="${data.QUANTITY > maxQuantity}">
                <c:set var="maxQuantity" value="${data.QUANTITY}" />
            </c:if>
        </c:forEach>
        <!-- <div>가장 큰 QUANTITY: ${maxQuantity}</div>   -->

        <c:set var="maxReadCount" value="0" />
        <c:forEach var="data" items="${map.dataRank}">
            <c:if test="${data.READ_COUNT > maxReadCount}">
                <c:set var="maxReadCount" value="${data.READ_COUNT}" />
            </c:if>
        </c:forEach>
        <!-- <div>가장 큰 READ_COUNT: ${maxReadCount}</div> -->
        
            <!-- <c:forEach var="i" begin="0" end="${map.dataRank.size() - 1}">
                <div class="graphBarArea">
                    <div class="label">${i+1}. ${map.dataRank[i].BRAND_NAME}</div>
                    <div class="graphArea">
                        <div class="graphBar blue" style="width: ${map.dataRank[i].QUANTITY / maxQuantity * 180 + 10}px;" data-quantity="${map.dataRank[i].QUANTITY}"></div>
                        <div class="graphBar red" style="width: ${map.dataRank[i].READ_COUNT / maxReadCount * 180 + 10}px;" data-quantity="${map.dataRank[i].READ_COUNT}"></div>
                    </div>
                </div>
            </c:forEach> -->

            <c:forEach var="i" begin="0" end="${map.dataRank.size() - 1}">
                <div class="graphBarArea">
                    <div class="label">${i+1}. ${map.dataRank[i].BRAND_NAME}</div>
                    <div class="graphArea">
                        <div class="graphBar blue" style="height: 20px; width:${Math.min(map.dataRank[i].QUANTITY*10, 200)}px;" data-quantity="${map.dataRank[i].QUANTITY}"></div>
                        <div class="graphBar red" style="height: 20px; width: ${Math.min(map.dataRank[i].READ_COUNT*10, 200)}px;" data-quantity="${map.dataRank[i].READ_COUNT}"></div>
                    </div>
                </div>
            </c:forEach>
            <!-- <div class="graph-container">
                <div class="label">1. 델몬트</div>
                <div class="graphArea">
                    <div class="graphBar blue"></div>
                    <div class="graphBar red"></div>
                </div>
            </div> -->
        </section>

        
    </div>

    <jsp:include page="/WEB-INF/views/common/sidebar/sideBar-main.jsp" /> 
</main>

<script src="/resources/js/manager-js/brand/brand.js"></script>
</body>

</html>
