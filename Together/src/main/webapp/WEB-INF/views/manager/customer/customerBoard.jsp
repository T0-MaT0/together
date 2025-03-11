<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<c:set var="menuName" value="customer"/> <!-- 사이드 메뉴 설정 -->

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
        <section class="cus-board list-card">
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
                
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>취소</div>
                </div>
                <div class="list item bottom-line">
                    <div>9999</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>진행</div>
                </div>
                <div class="list item bottom-line">
                    <div>9998</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>정지</div>
                </div>
                <div class="list item bottom-line">
                    <div>10007</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>성립</div>
                </div>

                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>취소</div>
                </div>
                <div class="list item bottom-line">
                    <div>9999</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>진행</div>
                </div>
                <div class="list item bottom-line">
                    <div>9998</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>정지</div>
                </div>
                <div class="list item bottom-line">
                    <div>10007</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>성립</div>
                </div>

                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>취소</div>
                </div>
                <div class="list item bottom-line">
                    <div>9999</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>진행</div>
                </div>
                <div class="list item bottom-line">
                    <div>9998</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>정지</div>
                </div>
                <div class="list item bottom-line">
                    <div>10007</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>성립</div>
                </div>

                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>취소</div>
                </div>
                <div class="list item bottom-line">
                    <div>9999</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>진행</div>
                </div>
                <div class="list item bottom-line">
                    <div>9998</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>정지</div>
                </div>
                <div class="list item bottom-line">
                    <div>10007</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>성립</div>
                </div>

                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>취소</div>
                </div>
                <div class="list item bottom-line">
                    <div>9999</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>진행</div>
                </div>
                <div class="list item bottom-line">
                    <div>9998</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>정지</div>
                </div>
                <div class="list item bottom-line">
                    <div>10007</div>
                    <div>망나뇽</div>
                    <div>삼다수 50개 나눠가지실 분!</div>
                    <div>2025.02.25</div>
                    <div>2025.02.25</div>
                    <div>성립</div>
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


        <!-- 현재 총 공구 모집 수 -->
        <section class="cus-board count-card">
        
            <div class="board-title ">
                <div class="title">현재 총 공구 모집 수</div>
            </div>
            <div class="customer-count">
                <div class="count">5,000,000,000 명</div>
                <progress id="progressBar" value="100" max="100"></progress>
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

<script>
    const xValues = ["진행중", "성립", "정지", "취소"];
    const yValues = [55, 49, 44, 24];
    const barColors = [
    "#DC143C",
    "#FF6347",
    // "#FFA500",
    "#6B8E23"
    ,"#6495ED"
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
