<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<c:set var="url" value="/manageBrand/"/>
<c:set var="menuName" value="brand"/> <!-- 사이드 메뉴 설정 -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/manager-css/manager-common.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/manager-brand.css" />
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
             <!-- &nbsp; <div> - 대시보드</div> -->
        </div>
    </header>

    <!-- 본문(중앙) -->
    <div id="container-center">
        
        <!-- 판매 -->
        <section class="brand-board">
            <div class="board-title">
                <div>판매 실적</div> <a href="${url}goods">상세 보기 ></a>
            </div>
            <div class="board-content">
                <!-- 총 판매건 진행중 판매 중지 판매 완료 -->
                 <div class="ch-number">
                    <div>총 판매</div>
                    <div>0</div>
                 </div>
                 <div class="ch-number">
                    <div>진행 중</div>
                    <div>0</div>
                 </div>
                 <div class="ch-number">
                    <div>판매 중지</div>
                    <div>0</div>
                 </div>
                 <div class="ch-number">
                    <div>판매 완료</div>
                    <div>0</div>
                 </div>
            </div>
        </section>
        
        <!-- 신고 -->
        <section class="brand-board">
            <div class="board-title">
                <div>브랜드관련 신고</div> <a href="${url}report">상세 보기 ></a>
            </div>
            <div class="board-content">
                 <div class="ch-number">
                    <div>미처리 건</div>
                    <div>0</div>
                 </div>
                 <div class="ch-number">
                    <div>반려</div>
                    <div>0</div>
                 </div>
                 <div class="ch-number">
                    <div>경고</div>
                    <div>0</div>
                 </div>
                 <div class="ch-number">
                    <div>블랙</div>
                    <div>0</div>
                 </div>
            </div>
        </section>
        
        <!-- 제휴 신청 현황 -->
        <section class="brand-board">
            <div class="board-title">
                <div>제휴 신청</div> <a href="${url}apply">상세 보기 ></a>
            </div>
            
            <div class="board-content">
                 <div class="ch-number">
                    <div>총 건수</div>
                    <div>0</div>
                 </div>
                 <div class="ch-number">
                    <div>대기</div>
                    <div>0</div>
                 </div>
                 <div class="ch-number">
                    <div>승인</div>
                    <div>0</div>
                 </div>
                 <div class="ch-number">
                    <div>거절</div>
                    <div>0</div>
                 </div>
            </div>

            <div class="board-list">

                <div class="ch-list">
                        <div>브랜드명</div>
                        <div>상품명</div>
                        <div>신청일자</div>
                        <div>상태</div>
                </div>
                <div class="ch-list bottom-line">
                        <div>햇반</div>
                        <div>햇반 10팩</div>
                        <div>2025.02.24</div>
                        <div>대기</div>
                </div>
                <div class="ch-list bottom-line">
                        <div>델몬트</div>
                        <div>델몬트 사과주스 팩 40개</div>
                        <div>2025.02.24</div>
                        <div>승인</div>
                </div>
                <div class="ch-list bottom-line">
                        <div>요플레</div>
                        <div>블루베리 요플레 4개</div>
                        <div>2025.02.24</div>
                        <div>거절</div>
                </div>
                <div class="ch-list bottom-line">
                        <div>양반</div>
                        <div>죽 시리즈(5개)</div>
                        <div>2025.02.24</div>
                        <div>거절</div>
                </div>
                <div class="ch-list bottom-line">
                        <div>빵빠레</div>
                        <div>초코, 바닐라, 딸기 세트</div>
                        <div>2025.02.24</div>
                        <div>대기</div>
                </div>

            </div>
        </section>
        
        <!-- 광고 신청 현황 -->
        <section class="brand-board">
            <div class="board-title">
                <div>광고 신청</div> <a href="${url}promotion">상세 보기 ></a>
            </div>
            
            <div class="board-content">
                <div class="ch-number">
                   <div>진행 중</div>
                   <div>0</div>
                </div>
                <div class="ch-number">
                   <div>대기</div>
                   <div>0</div>
                </div>
                <div class="ch-number">
                   <div>승인</div>
                   <div>0</div>
                </div>
                <div class="ch-number">
                   <div>거절</div>
                   <div>0</div>
                </div>
           </div>

           <div class="board-list">

                <div class="ch-list">
                        <div>브랜드명</div>
                        <div>상품명</div>
                        <div>신청일자</div>
                        <div>상태</div>
                </div>
                <div class="ch-list bottom-line">
                        <div>햇반</div>
                        <div>햇반 10팩</div>
                        <div>2025.02.24</div>
                        <div>대기</div>
                </div>
                <div class="ch-list bottom-line">
                        <div>델몬트</div>
                        <div>델몬트 사과주스 팩 40개</div>
                        <div>2025.02.24</div>
                        <div>승인</div>
                </div>
                <div class="ch-list bottom-line">
                        <div>요플레</div>
                        <div>블루베리 요플레 4개</div>
                        <div>2025.02.24</div>
                        <div>거절</div>
                </div>
                <div class="ch-list bottom-line">
                        <div>양반</div>
                        <div>죽 시리즈(5개)</div>
                        <div>2025.02.24</div>
                        <div>거절</div>
                </div>
                <div class="ch-list bottom-line">
                        <div>빵빠레</div>
                        <div>초코, 바닐라, 딸기 세트</div>
                        <div>2025.02.24</div>
                        <div>진행중</div>
                </div>

            </div>
        </section>

        <!-- 성과 데이터 보기 -->
        <section class="brand-board" id="dataLookBtn">
            <div class="board-onecard">
                성과 데이터 보기
            </div>
            <div class="">-></div>
        </section>
    </div>


</main>



<!-- 성과 데이터 보기 -->
<script>
    const dataLookBtn =document.querySelector("#dataLookBtn");

    dataLookBtn.addEventListener("click", ()=>{
        location.href = "${url}dataLook";
    })
</script>

</body>

</html>
