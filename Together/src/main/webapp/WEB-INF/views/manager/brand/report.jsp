<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<c:set var="menuName" value="brand"/> <!-- 사이드 메뉴 설정 -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/manager-css/manager-common.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/brand/brand-report-list.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/modal.css" />
    <script>
        // 사이드 메뉴 설정
        const menuName = "${menuName}";
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
            <div>브랜드 관리</div>
             &nbsp; <div> - 신고</div>
        </div>
    </header>

    <!-- 본문(종앙) -->
    <div id="container-center">
        <section class="cus-board list-card">
            <!-- 고객 상대 신고 -->
            <div class="board-title bottom-line">
                <div class="title">브랜드 대상 신고</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>미처리</option>
                        <option>반려</option>
                        <option>블랙</option>
                        <option>경고</option>
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
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>폼폼프리</div>
                    <div>말랑카우</div>
                    <div class="clickList">정말 품질 나쁜 물품을 팔았어요! 식중독에 걸렸어요!!</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>폼폼프리</div>
                    <div>세균맨</div>
                    <div class="clickList">정말 품질 나쁜 물품을 팔았어요! 식중독에 걸렸어요!!</div>
                    <div>2025.02.25</div>
                    <div>블랙</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>폼폼프리</div>
                    <div>세균맨</div>
                    <div class="clickList">정말 품질 나쁜 물품을 팔았어요! 식중독에 걸렸어요!!</div>
                    <div>2025.02.25</div>
                    <div>반려</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>폼폼프리</div>
                    <div>세균맨</div>
                    <div class="clickList">정말 품질 나쁜 물품을 팔았어요! 식중독에 걸렸어요!!</div>
                    <div>2025.02.25</div>
                    <div>경고</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>폼폼프리</div>
                    <div>세균맨</div>
                    <div class="clickList">정말 품질 나쁜 물품을 팔았어요! 식중독에 걸렸어요!!</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>폼폼프리</div>
                    <div>세균맨</div>
                    <div class="clickList">정말 품질 나쁜 물품을 팔았어요! 식중독에 걸렸어요!!</div>
                    <div>2025.02.25</div>
                    <div>블랙</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>폼폼프리</div>
                    <div>세균맨</div>
                    <div class="clickList">정말 품질 나쁜 물품을 팔았어요! 식중독에 걸렸어요!!</div>
                    <div>2025.02.25</div>
                    <div>반려</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>폼폼프리</div>
                    <div>세균맨</div>
                    <div class="clickList">정말 품질 나쁜 물품을 팔았어요! 식중독에 걸렸어요!!</div>
                    <div>2025.02.25</div>
                    <div>경고</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>폼폼프리</div>
                    <div>세균맨</div>
                    <div class="clickList">정말 품질 나쁜 물품을 팔았어요! 식중독에 걸렸어요!!</div>
                    <div>2025.02.25</div>
                    <div>반려</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>폼폼프리</div>
                    <div>세균맨</div>
                    <div class="clickList">정말 품질 나쁜 물품을 팔았어요! 식중독에 걸렸어요!!</div>
                    <div>2025.02.25</div>
                    <div>경고</div>
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


        
    </div>
    <div id="modal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2> 신고</h2>

            <div class="modalInner brandInner">

                <div class="modalTop">
                    <!-- <div class="modalTitle">
                        <strong>제목:</strong> 정말 나쁜 말을 했어요! 마상입었어요!
                    </div> -->
                    <div class="modalReport">
                        <strong>제목:</strong> 정말 품질 나쁜 물품을 팔았어요! 식중독에 걸렸어요!!
                    </div>
                    <div class="modal-submit">  
                        <select name="modalSubmit" id="modalSubmit" class="modalSubmit barndSubmit">
                            <option disabled selected>선택</option>
                            <option>반려</option>
                            <option>블랙</option>
                            <option>경고</option>
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

                <div class="midBtn barndBtn">
                    <button>브랜드 정보 조회</button>
                    <button>문제 상품 조회</button>
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

<script src="/resources/js/manager-js/modal.js"></script>
</body>

</html>
