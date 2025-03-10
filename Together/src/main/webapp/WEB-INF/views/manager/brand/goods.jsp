<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/manager-css/manager-common.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/brand/product-list.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    
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
        <section class="cus-board list-card">
            <!-- 판매 상품 -->
            <div class="board-title bottom-line">
                <div class="title">판매 상품</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>판매</option>
                        <option>중지</option>
                        <option>완료</option>
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
                    <div>종료일자</div>
                    <div>상태</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>판매</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>중지</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>완료</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>판매</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>중지</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>완료</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>판매</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>중지</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>완료</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>판매</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>중지</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>완료</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>판매</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>중지</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>완료</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>판매</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>중지</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>완료</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>판매</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div>오렌지, 포도, 사과 세트</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>중지</div>
                </div>

            </div>

            <ul id="pagination">
                <li>&lt;&lt;</li>
                <li>&lt;</li>
                <li class="curr">1</li>
                <li>2</li>
                <li>3</li>
                <li>4</li>
                <li>5</li>
                <li>6</li>
                <li>7</li>
                <li>8</li>
                <li>9</li>
                <li>10</li>
                <li>&gt;</li>
                <li>&gt;&gt;</li>
            </ul>

        </section>


        <!-- 총 상품 수 -->
        <section class="cus-board count-card">
        
            <div class="board-title ">
                <div class="title">총 상품 수</div>
            </div>
            <div class="customer-count">
                <div class="count">5,000,000,000 개</div>
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


</main>


<script>
    const xValues = ["판매","중지", "완료"];
    const yValues = [55, 49,40];
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

</body>

</html>
