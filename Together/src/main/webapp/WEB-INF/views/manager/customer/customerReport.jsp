<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>


<c:set var="menuName" value="customer"/> <!-- 사이드 메뉴 설정 -->

<c:set var="pagination" value="${map.pagination}"/>
<c:set var="reportList" value="${map.reportList}"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/manager-css/manager-common.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/customer/report-list.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/modal.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/common/reportProfileModal.css" />
    <script>
        // 사이드 메뉴 설정
        const menuName = "${menuName}";
        const menuNumber = 3;
    </script>
     <script src="https://kit.fontawesome.com/975074ef7f.js" crossorigin="anonymous"></script>
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
             &nbsp; <div> - 신고</div>
             <jsp:include page="/WEB-INF/views/manager/common/searchManager.jsp"/>
        </div>
    </header>

    <!-- 본문(종앙) -->
    <div id="container-center">
        <section class="cus-board list-card">
            <!-- 고객 상대 신고 -->
            <div class="board-title bottom-line">
                <div class="title">고객 대상 신고</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus" onchange="filterCustomerStatus(event)">
                        <option>전체</option>
                        <option>대기</option>
                        <option>반려</option>
                        <option>경고</option>
                        <option>블랙</option>
                    </select>
                </div>
            </div>
            <!-- 리스트 내역 -->
            
            <div id="list-area">
                <div class="list">
                    <div>번호</div>
                    <div>신고자</div>
                    <div>피신고자</div>
                    <div>신고제목</div>
                    <div>신고일자</div>
                    <div>상태</div>
                </div>
                <c:forEach items="${reportList}" var="report">
                    <div class="list item bottom-line">
                        <div>${report.reportNo}</div>
                        <div>${report.memberNick}</div>
                        <div>${report.reportedUserNick}</div>
                        <div class="clickList" onclick="customerReport(${report.reportNo})">${report.reportTitle}</div>
                        <div>${report.reportDate}</div>
                        <div>${report.reportStatus}</div>
                    </div>
                </c:forEach>
              <!--   
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>폼폼프리</div>
                    <div>세균맨</div>
                    <div class="clickList">정말 나쁜 말을 했어요! 마상입었어요!</div>
                    <div>2025.02.25</div>
                    <div>경고</div>
                </div> -->
                
            </div>
            <c:set var="urlCp" value="/manageCustomer/report?cp="></c:set>
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
                                <li><a href="/manageCustomer/report?cp=${i}">${i}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>                
                
                <li><a href="${urlCp}${pagination.nextPage}">&gt;</a></li>
                    <li><a href="${urlCp}${pagination.maxPage}">&gt;&gt;</a></li>
            </ul>


        </section>


        
    </div>
    <div id="modal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2> 신고</h2>

            <div class="modalInner">

                <div class="modalTop">
                    <!-- <div class="modalTitle">
                        <strong>제목:</strong> 정말 나쁜 말을 했어요! 마상입었어요!
                    </div> -->
                    <div class="modalReport">
                        <strong>제목:</strong> 정말 나쁜 말을 했어요! 마상입었어요!
                    </div>
                    <div class="modal-submit">  
                        <select name="modalSubmit" id="modalSubmit" class="modalSubmit">
                            <option disabled selected>선택</option>
                            <option>반려</option>
                            <option>블랙</option>
                            <option>경고</option>
                        </select>
                    </div>
                    <div class="memberName">
                        <strong>신고자:</strong> 폼폼푸리 
                    </div>
                    <div class="reportedName">
                        <strong>신고대상:</strong> 폼폼푸리 
                    </div>
                </div>

                <div class="modalMid">
                    <div>내용</div>
                    <div  class="customerText">asdfasdf</div>
                    <!-- <textarea name="managerText" class="customerText">ㅁㄴㅇㄹㅁㄴㅇㄹ</textarea> -->
                </div>

                <div class="midBtn">
                    <button id="infoBtn" onclick="openProfile()">브랜드 정보 조회</button>
                    <button id="BoardBtn" onclick="openBoard()">문제 상품 조회</button>
                </div>
                <div class="modalBottom">
                    <div>답변</div>
                    <!-- <div class="managerReportText">ㅁㄴㅇㄹㅁㄴㅇㄹ</div> -->
                    <div class="managerReportText" contenteditable="true">ㅁㄴㅇㄹㅁㄴㅇㄹ</div>
                </div>
                <div class="modal-btn">
                    <!-- <button onclick="reportSubmit('customer')">처리</button> -->
                </div>

                                <!-- 로딩 요소 -->
                <div class="loadingCover">
                    <div class="spinner">
                        <div class="double-bounce1"></div>
                        <div class="double-bounce2"></div>
                    </div>
                </div>
            </div>

        </div>
        <!-- 신고 모달 프로필 -->
        <jsp:include page="/WEB-INF/views/manager/common/reportProfileModal.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/sidebar/sideBar-main.jsp" /> 
</main>

<!-- <script src="/resources/js/manager-js/modal.js"></script> -->
<script src="/resources/js/manager-js/reportModal.js"></script>
<script src="/resources/js/manager-js/customer/customerReport.js"></script>
<script src="/resources/js/manager-js/customer/reportCondition.js"></script>

</body>

</html>
