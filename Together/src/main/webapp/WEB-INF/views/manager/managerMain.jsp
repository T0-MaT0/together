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
    <link rel="stylesheet" href="/resources/css/manager-css/manager-home.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    
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
            <div>관리자 페이지 </div>
             <!-- &nbsp; <div> - 대시보드</div> -->
        </div>
    </header>

    <!-- 본문(종앙) -->
    <div id="container-center">
        
        <!-- 세 가지 카테고리 -->
        <section class="first-wrap">
            <!-- 고객관리 -->
            <div class="item">
                <div class="chart-board cat-name" id="customerBtn">
                    고객 관리
                </div>

                <!-- 문의 개수 -->
                <div class="chart-board ch-number">
                    <div>문의 개수</div>
                    <div>${customerQuestCount}</div>
                </div>

                <!-- 신고 개수 -->
                <div class="chart-board ch-number">
                    <div>신고 수</div>  
                    <div>0</div>  
                </div>                
            </div>

            <!-- 브랜드관리 -->
            <div class="item">
                <div class="chart-board cat-name" id="brandBtn">
                    브랜드 관리
                </div>
                <!-- 제휴 문의 -->
                <div class="chart-board ch-number">
                    <div>제휴 신청</div>
                    <div>${brandQuestCount}</div>
                </div>

                <!-- 광고 신청 제의 건수 -->
                <div class="chart-board ch-number">
                    <div>광고 신청</div>
                    <div>10</div>
                </div>

                <!-- 신고 문의 -->
                <div class="chart-board ch-number">
                    <div>신고 수</div>
                    <div>10</div>
                </div>

            </div>

            <div class="item">
                <div class="cat-name chart-board" id="homeBtn">홈페이지 관리</div>

            </div>
        </section>

        <!-- 그래프 분석 -->
        <section class="second-wrap">
            <div class="item">
                <canvas id="myChart" style="width:80%;max-width:400px; height: 400px;"  width="400" height="400"></canvas>
            </div>
            <div class="item lineGraph">
                <div class="titleArea bottom-line-pink">
                    <span class="titleName">회원, 브랜드 수 추이</span> 
                    <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>주</option>
                        <option>월</option>
                        <option>년</option>
                    </select>
                </div>

                <canvas id="myChart2" style="width:100%;max-width:600px"></canvas>
            </div>
        </section>

        <!-- 문의 -->
        <section class="third-wrap">
            <!-- 이용 문의 -->
            <div class="item">
                
                <div class="que-title">
                    <div>문의</div> 
                    <a href="#">상세 보기 ></a>
                </div>

                <div class="i3-chart1 ">미처리</div>
                <div class="i3-chart2 ">처리</div>
                <div class="i3-chart3 bottom-line-purple ch-number">
                    <div>이용 문의</div>
                    <div>0</div>

                </div> 
                <div class="i3-chart4 bottom-line-purple ch-number">
                    <div>상담 톡</div>
                    <div>0</div>
                
                </div>
                <div class="i3-chart5 bottom-line-pink ch-number">
                    <div>이용 문의</div>
                    <div>0</div>
                </div>
                <div class="i3-chart6 bottom-line-pink ch-number">
                    <div>상담 톡</div>
                    <div>0</div>
                </div>


            </div>

            <!-- 신고 문의 -->
            <div class="item">

                <div class="report-title">
                    <span class="title-name">신고</span> <a href="#">상세 보기 ></a>
                </div>

                <div class="ch-number">
                    <div>총건수</div>
                    <div>0</div>
                </div>

                <div class="ch-number">
                    <div>미처리 건</div>
                    <div>0</div>
                </div>

                <div class="ch-number">
                    <div>처리 건</div>
                    <div>0</div>
                </div>

            </div>
        </section>

        
    </div>


</main>

<script>
    const xValues = ["고객 모집", "브랜드 상품"];
    const yValues = [10000, 50000];
    const barColors = [
    "#DC143C",
    // "#FF6347",
    // "#FFA500",
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
        title: {
      display: true,
      text: "총 브랜드 상품/고객 모집글 수 ",
      fontSize: 24, 
      fontColor: "#000000"
    }
    }
    });

</script>

<script>
    const xValues1 = [1, 2, 3, 4, 5];
    const yValues1 = [66, 70, 50, 33, 22];  // 첫 번째 선 데이터
    const yValues2 = [60, 65, 80, 77, 90];  // 두 번째 선 데이터 (새로운 선)
    
    new Chart("myChart2", {
      type: "line",
      data: {
        labels: xValues,
        datasets: [{
          label: "고객 모집",  // 첫 번째 선의 레이블 이름
          fill: false,
          lineTension: 0,
          backgroundColor: "rgba(0,0,255,1.0)",  // 첫 번째 선의 배경색
          borderColor: "rgba(0,0,255,0.1)",      // 첫 번째 선의 선 색상
          data: yValues1
        },
        {
          label: "브랜드 상품",  // 두 번째 선의 레이블 이름
          fill: false,
          lineTension: 0,
          backgroundColor: "rgba(255,0,0,1.0)",  // 두 번째 선의 배경색 (예: 빨간색)
          borderColor: "rgba(255,0,0,0.1)",      // 두 번째 선의 선 색상
          data: yValues2
        }]
      },
      options: {
        legend: {display: true},  // 레전드 표시
        scales: {
          yAxes: [{
            ticks: {min: 0, max: 100}
          }]
        }
      }
    });
    </script>

    <script src="/resources/js/manager-js/managerMain.js"></script>
</body>

</html>