<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<c:set var="menuName" value="customer"/> <!-- 사이드 메뉴 설정 -->

<c:set var="pagination" value="${map.pagination}"/>
<c:set var="boardList" value="${map.boardList}"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/manager-css/manager-common.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/customer/board-list.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    <script>
        // 사이드 메뉴 설정
        const menuName = "${menuName}";
        const menuNumber = 1;
    </script>
    <style>
        #container-center > section.cus-board.graph-card{
            height: 550px;
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
            <div>고객 관리</div>
             &nbsp; <div> - 공구 모집글</div>
        </div>
    </header>

    <!-- 본문(종앙) -->
    <div id="container-center">
        <section class="cus-board list-card mainList">
            <!-- 공구 모집글 리스트 -->
            <div class="board-title bottom-line">
                <div class="title">공구 모집글 리스트</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>성립</option>
                        <option>정지</option>
                        <option>취소</option>
                        <option>진행</option>
                    </select>
                </div>
            </div>

            <!-- 리스트 내역 -->
            
            <div id="list-area">
                <div class="list">
                    <div>번호</div>
                    <div>작성자</div>
                    <div>제목</div>
                    <div>게시일자</div>
                    <div>성립일자</div>
                    <div>상태</div>
                </div>
                <c:forEach  items="${boardList}" var="board">
                    <div class="list item bottom-line">
                        <div>${board.boardNo}</div>
                        <div>${board.memberNick}</div>
                        <div>${board.boardTitle}</div>
                        <div>${board.createDate}</div>
                        <div>${board.endDate}</div>
                        <div>${board.recruitmentStatus}</div>
                    </div>             
                </c:forEach>
                <!-- <div class="list item bottom-line">
                    <div>9999</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>진행</div>
                </div> -->

            </div>

            <c:set var="urlCp" value="/manageCustomer/board?cp="></c:set>
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


        <!-- 현재 총 공구 모집 수 -->
        <section class="cus-board count-card">
        
            <div class="board-title ">
                <div class="title">현재 총 공구 모집 수</div>
            </div>
            <div class="customer-count">
                <div class="count">${map.totalCustomerBoard}명</div>
                <progress id="progressBar" value="${map.totalCustomerBoard}" max="${map.totalCustomerBoard}"></progress>
            </div>
        
        </section>
        
        <!-- 공구 모집 규모 -->
        <section class="cus-board graph-card">
        
            <div class="board-title ">
                <div class="title">공구 모집 규모</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>주</option>
                        <option>월</option>
                        <option>년</option>
                    </select>
                </div>

                

            </div>
            <canvas id="myChart" style="width:80%;max-width:400px; height: 400px;"></canvas>
        </section>

    </div>


</main>
<c:set var="ing" value="${map.cusBoardStateCount[1].COUNT}"/>
<c:set var="limited" value="${map.cusBoardStateCount[2].COUNT}"/>
<c:set var="done" value="${map.cusBoardStateCount[0].COUNT}"/>
<script>
    const xValues = ["진행중", "마감", "완료"];
    const yValues = [${ing}, ${limited}, ${done}];
    const barColors = [
    "#DC143C",
    // "#FF6347",
    "#FFA500",
    "#6B8E23"
    // ,"#6495ED"
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
</body>

</html>
