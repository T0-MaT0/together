<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>


<c:set var="menuName" value="customer"/> <!-- 사이드 메뉴 설정 -->


<c:set var="pagination" value="${map.pagination}"/>
<c:set var="stateList" value="${map.stateList}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>customerState</title>
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
        <section class="cus-board list-card mainList">
            <!-- 고객 상태 리스트 -->
            <div class="board-title bottom-line">
                <div class="title">고객 상태 리스트</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus" onchange="filterCustomerStatus(event)">
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
                    <div>회원 등급</div>
                    <div>상태</div>
                </div>
                <c:forEach  items="${stateList}" var="state">
                    <div class="list item bottom-line clickArea" onclick="customerState(${state.memberNo})">
                        <div>${state.memberNo}</div>
                        <c:if test="${empty state.profileImg}">
                            <img src="/resources/images/image-manager/profile.png" alt="프로필">
                        </c:if>
                        <c:if test="${!empty state.profileImg}">
                            <img src="${state.profileImg}" alt="프로필">
                        </c:if>
                        <div>${state.memberNick}</div>
                        <div>${state.memberEmail}</div>
                        <div>${state.createDate}</div>
                        <div>${state.memberGrade}</div>
                        <div>${state.memberDelFl}</div>
                    </div>
                </c:forEach>
                <!-- <div class="list item bottom-line">
                    <div>2</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>호빵맨</div>
                    <div>hopang@gmail.com</div>
                    <div>2025.02.25</div>
                    <div>2025.02.26</div>
                    <div>탈퇴</div>
                </div> -->

            </div>

            <!-- 페이지네이션션 -->
            <c:set var="urlCp" value="/manageCustomer/state?cp="></c:set>
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


        <!-- 현재 총 회원 수 -->
        <section class="cus-board count-card">
        
            <div class="board-title ">
                <div class="title">현재 회원 수</div>
            </div>
            <div class="customer-count">
                <div class="count">${map.customerTotal}명</div>
                <progress id="progressBar" value="${map.customerTotal}" max="${map.customerTotal}"></progress>
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

    <jsp:include page="/WEB-INF/views/common/sidebar/sideBar-main.jsp" /> 
</main>

<!-- 고객 상태 여부 -->
<c:forEach var="customerState" items="${map.CustomersSelect}">
    <c:if test="${customerState.MEMBER_DEL_FL == 'B'}">
        <c:set var="black" value="${customerState.MEMBER_COUNT}"></c:set>
    </c:if>
    <c:if test="${customerState.MEMBER_DEL_FL == 'N'}">
        <c:set var="member" value="${customerState.MEMBER_COUNT}"></c:set>
    </c:if>
    <c:if test="${customerState.MEMBER_DEL_FL == 'Y'}">
        <c:set var="nonMember" value="${customerState.MEMBER_COUNT}"></c:set>
    </c:if>
</c:forEach>

<script>
    const xValues = ["회원", "탈퇴", "블랙"];
    const yValues = [${member}, ${nonMember}, ${black}];
    const barColors = [
    "#DC143C",
    // "#FF6347",
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
        animation: false
    }
    });
</script>

<script src="/resources/js/manager-js/customer/manageCustomer.js"></script>
<script src="/resources/js/manager-js/customer/statePagination.js"></script>
</body>

</html>
