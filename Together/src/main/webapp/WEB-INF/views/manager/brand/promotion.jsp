<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<c:set var="menuName" value="brand"/> <!-- 사이드 메뉴 설정 -->
<c:set var="menuNumber" value="3"/>

<c:set var="pagination" value="${map.pagination}"/>
<c:set var="promotionList" value="${map.promotionList}"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/manager-css/manager-common.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/brand/ad-list.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/modal.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    <script>
        // 사이드 메뉴 설정
        const menuName = "${menuName}";
        const menuNumber = "${menuNumber}";
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
             &nbsp; <div> - 광고</div>
        </div>
    </header>

    <!-- 본문(종앙) -->
    <div id="container-center">
        <section class="cus-board list-card mainBoard">
            <!-- 광고 신청 리스트 -->
            <div class="board-title bottom-line">
                <div class="title">광고 신청</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>승인</option>
                        <option>대기</option>
                        <option>거절</option>
                    </select>
                </div>
            </div>

            <!-- 리스트 내역 -->
            
            <div id="list-area">
                <div class="list">
                    <div>번호</div>
                    <div>브랜드</div>
                    <div>신청내용</div>
                    <div>신청일자</div>
                    <div>상태</div>
                </div>
                <c:forEach  items="${promotionList}" var="prom">
                    <div class="list item bottom-line">
                        <div>${prom.boardNo}</div>
                        <div>${prom.brandName}</div>
                        <div class="clickList">${prom.boardTitle}</div>
                        <div>${prom.createDate}</div>
                        <div>${prom.boardDelFl}</div>
                    </div>
                </c:forEach>
                <!-- <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div class="clickList">저희는 고품질 주스를 판매하는 업체입니다.</div>
                    <div>2025.02.25</div>
                    <div>승인</div>
                </div> -->
    

            </div>

            <c:set var="urlCp" value="/manageBrand/promotion?cp="></c:set>
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


        <!-- 총 광고 신청 수 -->
        <section class="cus-board count-card">
        
            <div class="board-title ">
                <div class="title">총 광고 신청 수</div>
            </div>
            <div class="customer-count">
                <div class="count">${map.listCount} 건</div>
                <progress id="progressBar" value="100" max="100"></progress>
            </div>
        
        </section>
        
        <!-- 광고 신청 규모 -->
        <section class="cus-board graph-card">
        
            <div class="board-title ">
                <div class="title">광고 신청 규모</div>
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
    <div id="modal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2> 광고 신청</h2>

            <div class="modalInner brandInner">

                <div class="modalTop">
                    <!-- <div class="modalTitle">
                        <strong>제목:</strong> 정말 나쁜 말을 했어요! 마상입었어요!
                    </div> -->
                    <div class="modalReport">
                        <strong>제목:</strong> 저희는 고품질 주스를 판매하는 업체입니다
                    </div>
                    <div class="modal-submit">  
                        <select name="modalSubmit" id="modalSubmit" class="modalSubmit barndSubmit">
                            <option disabled selected>선택</option>
                            <option>승인</option>
                            <option>거부</option>
                        </select>
                    </div>
                    <div class="memberName">
                        <strong>브랜드명:</strong> 델몬트 
                    </div>
                </div>

                <div class="modalMid">
                    <div>내용</div>
                    <div  class="customerText">asdfasdf</div>
                    <!-- <textarea name="managerText" class="customerText">ㅁㄴㅇㄹㅁㄴㅇㄹ</textarea> -->
                </div>

                <div class="midBtn barndBtn">
                    <button>첨부 사진</button>
                    <input type="file">
                </div>
                <div class="modal-btn barndBtn">
                    <button>처리</button>
                </div>
            </div>

        </div>
    </div>

</main>



<script>
    const xValues = ["대기","승인", "거절"];
    const yValues = [${map.promStateCount[0].COUNT}, ${map.promStateCount[1].COUNT},${map.promStateCount[2].COUNT}];
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

<script src="/resources/js/manager-js/modal.js"></script>
</body>

</html>
