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
                    <div>${cusReportListCount}</div>  
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
                    <div>${brandAdCount}</div>
                </div>

                <!-- 신고 문의 -->
                <div class="chart-board ch-number">
                    <div>신고 수</div>
                    <div>${brandReportCount}</div>
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
                    <span class="titleName">개인/브랜드 회원 가입 수 추이</span> 
                    <select name="customerStatus" id="customerStatus">
                        <option selected>주</option>
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
                    <div>미처리 문의 건수</div> 
                    <!-- <a href="#">상세 보기 ></a> -->
                </div>

                <div class="i3-chart1 ">고객 대상</div>
                <div class="i3-chart2 ">브랜드 대상</div>
                <div class="i3-chart3 bottom-line-purple ch-number">
                    <div>1:1문의</div>
                    <div>${custQuestCount}</div>

                </div> 
                <!-- <div class="i3-chart4 bottom-line-purple ch-number">
                    <div>신고</div>
                    <div>0</div>
                
                </div> -->
                <div class="i3-chart5 bottom-line-pink ch-number">
                    <div>제휴</div>
                    <div>${notPassApplyCount}</div>
                </div>
                <div class="i3-chart6 bottom-line-pink ch-number">
                    <div>광고</div>
                    <div>${brandAddCount}</div>
                </div>


            </div>

            <!-- 신고 문의 -->
            <div class="item">
                <div class="report-title">
                    <span class="title-name">미처리 신고 건수</span>
                     <!-- <a href="#">상세 보기 ></a> -->
                </div>

                <div class="ch-number">
                    <div>총 신고</div>
                    <div>${cusWaitCount+waitCount}</div>
                </div>

                <div class="ch-number">
                    <div>고객 대상</div>
                    <div>${cusWaitCount}</div>
                </div>

                <div class="ch-number">
                    <div>브랜드 대상</div>
                    <div>${waitCount}</div>
                </div>

            </div>
        </section>

        
    </div>

    <jsp:include page="/WEB-INF/views/common/sidebar/sideBar-main.jsp" /> 
</main>

<script>
    const goodsCount = ${productCount};
    const getherCount = ${customerboardCount};

    const xValues = ["고객 모집", "브랜드 상품"];
    const yValues = [goodsCount, getherCount];
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
      text: "상품/ 모집글 누적 수 ",
      fontSize: 24, 
      fontColor: "#000000"
    }
    }
    });

</script>

<script>
        const custCount = "${dayCustomerCount}";
        const brandCount = "${dayBrandCount}";
        console.log(custCount);
        console.log(brandCount);
        // const xValues2 = [100,200,300,400,500,600,700,800,900,1000];
        const xValues2 = [${graph.SEVEN}, ${graph.SIX}, ${graph.FIVE}, ${graph.FOUR}, ${graph.THREE}
        , ${graph.TWO}, ${graph.ONE}, ${graph.TODAY}];

        new Chart("myChart2", {
        type: "line",
        data: {
            labels: xValues2,
            datasets: [{ 
            data: ${dayCustomerCount},
            label: "개인회원",
            borderColor: "rgba(0,0,255,0.1)",
            backgroundColor: "rgba(0,0,255,1.0)",
            fill: false
            }, 
            { data: ${dayBrandCount},
            label: "브랜드 회원",
            borderColor: "rgba(255,0,0,0.1)",
            backgroundColor: "rgba(255,0,0,1.0)",
            fill: false
            }]
        },
        options: {
            legend: {display: true}
        }
        });
    </script>

    <script src="/resources/js/manager-js/managerMain.js"></script>
</body>

</html>