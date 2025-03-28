<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<c:set var="menuName" value="brand"/> <!-- 사이드 메뉴 설정 -->

<c:set var="pagination" value="${map.pagination}"/>
<c:set var="goodsList" value="${map.goodsList}"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/manager-css/manager-common.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/brand/product-list.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    <script>
        // 사이드 메뉴 설정
        const menuName = "${menuName}";
    </script>
    <style>
        #container-center > section.cus-board.graph-card{
            height: 500px;
        }
    </style>
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
             &nbsp; <div> - 판매 상품</div>
        </div>
    </header>

    <!-- 본문(종앙) -->
    <div id="container-center">
        <section class="cus-board list-card mainBoard">
            <!-- 판매 상품 -->
            <div class="board-title bottom-line">
                <div class="title">판매 상품</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>판매</option>
                        <option>종료</option>
                    </select>
                </div>
            </div>
            <!-- 리스트 내역 -->
            <div id="list-area">
                <div class="list">
                    <div>번호</div>
                    <div>브랜드</div>
                    <div>상품명</div>
                    <div>신청일자</div>
                    <div>재고</div>
                    <div>상태</div>
                </div>
                
                <c:forEach  items="${goodsList}" var="goods">
                    <div class="list item bottom-line clickArea" onclick="boardProduct(${goods.memberNo})">
                        <div>${goods.boardNo}</div>
                        <div>${goods.brandName}</div>
                        <div>${goods.productTitle}</div>
                        <div>${goods.createDate}</div>
                        <div>${goods.productCount}</div>
                        <div>${goods.boardDelFl}</div>
                    </div>
    
                </c:forEach>
                <!-- <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>중지</div>
                </div> -->

            </div>

            <c:set var="urlCp" value="/manageBrand/goods?cp="></c:set>
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


        <!-- 총 상품 수 -->
        <section class="cus-board count-card">
        
            <div class="board-title ">
                <div class="title">총 상품 수</div>
            </div>
            <div class="customer-count">
                <div class="count">${map.goodsBoardCount} 개</div>
                <progress id="progressBar" value="100" max="100"></progress>
            </div>
        
        </section>
        
        <!-- 제휴 규모 -->
        <section class="cus-board graph-card">
        
            <div class="board-title ">
                <div class="title">상품 규모</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>주</option>
                        <option>월</option>
                        <option>년</option>
                    </select>
                </div>
            </div>
            
            <canvas id="myChart" style="width:80%;max-width:400px; height: 400px;"  width="400" height="400"></canvas>
        </section>

        
    </div>

    <jsp:include page="/WEB-INF/views/common/sidebar/sideBar-main.jsp" /> 
</main>
<c:set var="sell" value="${map.goodsStateCount[0].COUNT}"/>
<c:set var="done" value="${map.goodsStateCount[1].COUNT}"/>

<script>
    const xValues = ["판매","종료"];
    const yValues = [${sell},${done}];
    const barColors = [
    "#DC143C",
    // "#FF6347",
    "#FFA500",
    // "#6B8E23"
    "#6495ED"
    ];

    new Chart("myChart", {
    type: "pie",
    data: {
        labels: xValues,
        datasets: [{
        backgroundColor: barColors,
        data: yValues
        }]
    },
    options: {
        // maintainAspectRatio: false
    }
    });

</script>

<script src="/resources/js/manager-js/brand/brand.js"></script>

</body>

</html>
