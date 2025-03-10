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
    <link rel="stylesheet" href="/resources/css/manager-css/brand/collabo-list.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/modal.css" />

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
             &nbsp; <div> - 제휴</div>
        </div>
    </header>

    <!-- 본문(종앙) -->
    <div id="container-center">
        <section class="cus-board list-card">
            <!-- 제휴 신청 리스트 -->
            <div class="board-title bottom-line">
                <div class="title">제휴 신청</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>대기</option>
                        <option>승인</option>
                        <option>거절</option>
                    </select>
                </div>
            </div>

            <!-- 리스트 내역 -->
            
            <div id="list-area">
                <div class="list">
                    <div>번호</div>
                    <div>브랜드</div>
                    <div>내용</div>
                    <div>신청일자</div>
                    <div>상태</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div class="clickList">저희는 고품질 주스를 판매하는 업체입니다.</div>
                    <div>2025.02.25</div>
                    <div>대기</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div class="clickList">저희는 고품질 주스를 판매하는 업체입니다.</div>
                    <div>2025.02.25</div>
                    <div>거절</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div class="clickList">저희는 고품질 주스를 판매하는 업체입니다.</div>
                    <div>2025.02.25</div>
                    <div>승인</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div class="clickList">저희는 고품질 주스를 판매하는 업체입니다.</div>
                    <div>2025.02.25</div>
                    <div>대기</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div class="clickList">저희는 고품질 주스를 판매하는 업체입니다.</div>
                    <div>2025.02.25</div>
                    <div>거절</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div class="clickList">저희는 고품질 주스를 판매하는 업체입니다.</div>
                    <div>2025.02.25</div>
                    <div>승인</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div class="clickList">저희는 고품질 주스를 판매하는 업체입니다.</div>
                    <div>2025.02.25</div>
                    <div>대기</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div class="clickList">저희는 고품질 주스를 판매하는 업체입니다.</div>
                    <div>2025.02.25</div>
                    <div>거절</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div class="clickList">저희는 고품질 주스를 판매하는 업체입니다.</div>
                    <div>2025.02.25</div>
                    <div>승인</div>
                </div>
                <div class="list item bottom-line">
                    <div>10001</div>
                    <div>델몬트</div>
                    <div class="clickList">저희는 고품질 주스를 판매하는 업체입니다.</div>
                    <div>2025.02.25</div>
                    <div>승인</div>
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


        <!-- 총 제휴 건수 -->
        <section class="cus-board count-card">
        
            <div class="board-title ">
                <div class="title">총 제휴 건수</div>
            </div>
            <div class="customer-count">
                <div class="count">5,000,000,000 건</div>
                <progress id="progressBar" value="100" max="100"></progress>
            </div>
        
        </section>
        
        <!-- 제휴 규모 -->
        <section class="cus-board graph-card">
        
            <div class="board-title ">
                <div class="title">제휴 규모</div>
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
            <h2> 제휴</h2>

            <div class="modalInner brandInner">

                <div class="modalTop">
                    <!-- <div class="modalTitle">
                        <strong>제목:</strong> 정말 나쁜 말을 했어요! 마상입었어요!
                    </div> -->
                    <div class="modalReport">
                        <strong>제목:</strong> 저희는 고품질 주스를 판매하는 업체입니다.
                    </div>
                    <div class="modal-submit">  
                        <select name="modalSubmit" id="modalSubmit" class="modalSubmit barndSubmit">
                            <option disabled selected>선택</option>
                            <option>승인</option>
                            <option>거부</option>
                        </select>
                    </div>
                    <div class="memberName">
                        <strong>회원명:</strong> 폼폼푸리 
                    </div>
                </div>

                <div class="modalMid">
                    <div>내용</div>
                    <div  class="customerText">asdfasdf</div>
                    <!-- <textarea name="managerText" class="customerText">ㅁㄴㅇㄹㅁㄴㅇㄹ</textarea> -->
                </div>

                <div class="modalBottom">
                    <div>답변</div>
                    <!-- <div class="managerReportText">ㅁㄴㅇㄹㅁㄴㅇㄹ</div> -->
                    <textarea name="managerReportText" class="managerReportText">ㅁㄴㅇㄹㅁㄴㅇㄹ</textarea>
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

<script src="/resources/js/manager-js/modal.js"></script>
</body>

</html>
