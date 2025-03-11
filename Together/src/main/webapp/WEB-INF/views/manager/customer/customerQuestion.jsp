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
                    <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>미처리</option>
                        <option>처리</option>
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
                <div class="list item bottom-line ">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div class="clickList">문의할게 있어요!! 상품 판매하고 싶은데...</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line ">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div class="clickList">모집글이 올라가지 않아요!!! 그래서 환불하려고요!</div>
                    <div>2025.02.25</div>
                    <div>처리</div>
                </div>
                <div class="list item bottom-line ">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div class="clickList">광고 이미지를 바꾸고 싶습니다.</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line ">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div class="clickList">문의할게 있어요!! 상품 판매하고 싶은데...</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line ">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div class="clickList">모집글이 올라가지 않아요!!! 그래서 환불하려고요!</div>
                    <div>2025.02.25</div>
                    <div>처리</div>
                </div>
                <div class="list item bottom-line ">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div class="clickList">광고 이미지를 바꾸고 싶습니다.</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
     
                <div class="list item bottom-line ">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div class="clickList">광고 이미지를 바꾸고 싶습니다.</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line ">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div class="clickList">문의할게 있어요!! 상품 판매하고 싶은데...</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line ">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div class="clickList">모집글이 올라가지 않아요!!! 그래서 환불하려고요!</div>
                    <div>2025.02.25</div>
                    <div>처리</div>
                </div>
                <div class="list item bottom-line ">
                    <div>1</div>
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                    <div>폼폼프리</div>
                    <div class="clickList">광고 이미지를 바꾸고 싶습니다.</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
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
                    <textarea name="managerText" class="managerText">ㅁㄴㅇㄹㅁㄴㅇㄹ</textarea>
                </div>
                <div class="modal-btn">
                    <button>제출</button>
                </div>
            </div>

        </div>
    </div>

</main>

<script src="/resources/js/manager-js/modal.js"></script>
</body>

</html>
