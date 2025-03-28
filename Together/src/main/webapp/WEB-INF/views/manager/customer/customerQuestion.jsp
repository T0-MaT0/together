<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<c:set var="menuName" value="customer"/> <!-- 사이드 메뉴 설정 -->

<c:set var="pagination" value="${map.pagination}"/>
<c:set var="questList" value="${map.questList}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>customerQuestion</title>
    <link rel="stylesheet" href="/resources/css/manager-css/manager-common.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/customer/question-list.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/modal.css" />
    
    <script>
        // 사이드 메뉴 설정
        const menuName = "${menuName}";
        const menuNumber = 2;
    </script>
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
             &nbsp; <div> - 문의</div>
        </div>
    </header>

    <!-- 본문(종앙) -->
    <div id="container-center">
        <section class="cus-board list-card">
            <!-- 고객 상대 신고 -->
            <div class="board-title bottom-line">
                <div class="title">고객 문의</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus" onchange="filterCustomerStatus(event)">
                        <option>전체</option>
                        <option>대기</option>
                        <option>처리완료</option>
                    </select>
                </div>
            </div>

            <!-- 리스트 내역 -->
            
            <div id="list-area">
                <div class="list">
                    <div>번호</div>
                    <div>프로필</div>
                    <div>문의자</div>
                    <div>문의제목</div>
                    <div>문의일자</div>
                    <div>상태</div>
                </div>
                <c:forEach items="${questList}" var="quest">
                    <div class="list item bottom-line ">
                        <div>${quest.boardNo}</div>
                        <!-- 기본프로필-->
                        <c:if test="${empty quest.profileImg}">
                            <img src="/resources/images/image-manager/profile.png" alt="프로필">
                        </c:if>
                        <!-- 기본프로필이 아닌경우 -->
                        <c:if test="${!empty quest.profileImg}">
                            <img src="${quest.profileImg}" alt="프로필">
                        </c:if>
                        <div>${quest.memberNick}</div>
                        <div class="clickList" onclick="customerQuest(${quest.boardNo})">${quest.boardTitle}</div>
                        <div>${quest.createDate}</div>
                        <div>${quest.state}</div>
                    </div>
                </c:forEach>
                <!-- <div class="list item bottom-line ">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div class="clickList">문의할게 있어요!! 상품 판매하고 싶은데...</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div> -->
     
                
            </div>

            <c:set var="urlCp" value="/manageCustomer/question?cp="></c:set>
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
                                <li><a href="/manageCustomer/question?cp=${i}">${i}</a></li>
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
            <h2>문의</h2>

            <div class="modalInner">

                <div class="modalTop">
                    <div class="modalTitle">
                        <strong>제목:</strong> 모집글이 올라가지 않아요!!! 그래서 환불하려고요!
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
                    <!-- <div class="managerText">ㅁㄴㅇㄹㅁㄴㅇㄹ</div> -->
                    <div name="managerText" contenteditable="true"  class="managerText" >ㅁㄴㅇㄹㅁㄴㅇㄹ</div>
                </div>
                <div class="modal-btn">
                    <!-- <button>제출</button> -->
                </div>
            </div>

        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/sidebar/sideBar-main.jsp" /> 
</main>

<script src="/resources/js/manager-js/modal.js"></script>
<script src="/resources/js/manager-js/customer/questionCondition.js"></script>

</body>

</html>
