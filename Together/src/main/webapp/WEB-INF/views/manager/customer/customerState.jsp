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
    <link rel="stylesheet" href="/resources/css/manager-css/customer/customer-list.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>

    <script>
        // 사이드 메뉴 설정
        const menuName = "${menuName}";
        const menuNumber = 0;
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
             &nbsp; <div> - 고객 상태</div>
        </div>
    </header>

    <!-- 본문(종앙) -->
    <div id="container-center">
        <section class="cus-board list-card">
            <!-- 고객 상태 리스트 -->
            <div class="board-title bottom-line">
                <div class="title">고객 상태 리스트</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>회원</option>
                        <option>탈퇴</option>
                        <option>블랙</option>
                    </select>
                </div>
            </div>

            <!-- 리스트 내역 -->
            
            <div id="list-area">
                <div class="list">
                    <div>번호</div>
                    <div>프로필</div>
                    <div>닉네임</div>
                    <div>이메일</div>
                    <div>가입일자</div>
                    <div>탈퇴일자</div>
                    <div>상태</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div>pom@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>회원</div>
                </div>
                <div class="list item bottom-line">
                    <div>2</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>호빵맨</div>
                    <div>hopang@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>2025.02.26</div>
                    <div>탈퇴</div>
                </div>
                <div class="list item bottom-line">
                    <div>3</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>식빵맨</div>
                    <div>sick@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>2025.02.26</div>
                    <div>블랙</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div>pom@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>회원</div>
                </div>
                <div class="list item bottom-line">
                    <div>2</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>호빵맨</div>
                    <div>hopang@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>2025.02.26</div>
                    <div>탈퇴</div>
                </div>
                <div class="list item bottom-line">
                    <div>3</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>식빵맨</div>
                    <div>sick@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>2025.02.26</div>
                    <div>블랙</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div>pom@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>회원</div>
                </div>
                <div class="list item bottom-line">
                    <div>2</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>호빵맨</div>
                    <div>hopang@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>2025.02.26</div>
                    <div>탈퇴</div>
                </div>
                <div class="list item bottom-line">
                    <div>3</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>식빵맨</div>
                    <div>sick@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>2025.02.26</div>
                    <div>블랙</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div>pom@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>회원</div>
                </div>
                <div class="list item bottom-line">
                    <div>2</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>호빵맨</div>
                    <div>hopang@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>2025.02.26</div>
                    <div>탈퇴</div>
                </div>
                <div class="list item bottom-line">
                    <div>3</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>식빵맨</div>
                    <div>sick@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>2025.02.26</div>
                    <div>블랙</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div>pom@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>----.--.--</div>
                    <div>회원</div>
                </div>
                <div class="list item bottom-line">
                    <div>2</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>호빵맨</div>
                    <div>hopang@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>2025.02.26</div>
                    <div>탈퇴</div>
                </div>
                <div class="list item bottom-line">
                    <div>3</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>식빵맨</div>
                    <div>sick@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>2025.02.26</div>
                    <div>블랙</div>
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


        <!-- 현재 총 회원 수 -->
        <section class="cus-board count-card">
        
            <div class="board-title ">
                <div class="title">현재 총 회원 수</div>
            </div>
            <div class="customer-count">
                <div class="count">5,000,000,000 명</div>
                <progress id="progressBar" value="100" max="100"></progress>
            </div>
        
        </section>
        
        <!-- 고객 규모 -->
        <section class="cus-board graph-card">
        
            <div class="board-title ">
                <div class="title">고객 규모</div>
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
    const xValues = ["탈퇴", "블랙", "회원", "신규"];
    const yValues = [55, 49, 44, 24];
    const barColors = [
    "#DC143C",
    "#FF6347",
    // "#FFA500",
    "#6B8E23",
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
