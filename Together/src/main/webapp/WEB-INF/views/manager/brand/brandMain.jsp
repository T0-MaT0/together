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
                <div>상품 판매 건수</div> <a href="${url}goods">상세 보기 ></a>
            </div>
            <div class="board-content">
                <!-- 총 판매건 진행중 판매 중지 판매 완료 -->
                 <div class="ch-number">
                    <div>총 상품</div>
                    <div>${map.totalSellCount}</div>
                 </div>
                 <div class="ch-number">
                    <div>진행 중</div>
                    <div>${map.sellingCount}</div>
                 </div>
                 <div class="ch-number">
                    <div>판매 종료</div>
                    <div>${map.soldCount}</div>
                 </div>
                 <div class="ch-number">
                    <div>총 판매수량</div>
                    <div>${map.quantityCount}</div>
                 </div>
            </div>
        </section>
        
        <!-- 신고 -->
        <section class="brand-board">
            <div class="board-title">
                <div>브랜드 대상 신고</div> <a href="${url}report">상세 보기 ></a>
            </div>
            <div class="board-content">
                 <div class="ch-number">
                    <div>대기</div>
                    <div>${map.waitCount}</div>
                 </div>
                 <div class="ch-number">
                    <div>반려</div>
                    <div>${map.returnCount}</div>
                 </div>
                 <div class="ch-number">
                    <div>경고</div>
                    <div>${map.warnCount}</div>
                 </div>
                 <div class="ch-number">
                    <div>블랙</div>
                    <div>${map.blackCount}</div>
                 </div>
            </div>
        </section>
        
        <!-- 제휴 신청 현황 -->
        <section class="brand-board">
            <div class="board-title">
                <div>제휴 문의</div> <a href="${url}apply">상세 보기 ></a>
            </div>
            
            <div class="board-content">
                 <div class="ch-number">
                    <div>총 건수</div>
                    <div>${map.totalApplyCount}</div>
                 </div>
                 <div class="ch-number">
                    <div>대기</div>
                    <div>${map.waitApplyCount}</div>
                 </div>
                 <div class="ch-number">
                    <div>승인</div>
                    <div>${map.acceptApplyCount}</div>
                 </div>
                 <div class="ch-number">
                    <div>거절</div>
                    <div>${map.refuseApplyCount}</div>
                 </div>
            </div>

            <div class="board-list">
                <div class="ch-list">
                        <div>브랜드명</div>
                        <div>상품명</div>
                        <div>신청일자</div>
                        <div>상태</div>
                </div>
                <c:forEach var="apply" items="${map.applyList}">
                    <div class="ch-list bottom-line">
                            <div>${apply.brandName}</div>
                            <div>${apply.boardTitle}</div>
                            <div>${apply.createDate}</div>
                            <div>${apply.state}</div>
                    </div>
                </c:forEach>
                <!-- <div class="ch-list bottom-line">
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
                </div> -->

            </div>
        </section>
        
        <!-- 광고 신청 현황 -->
        <section class="brand-board">
            <div class="board-title">
                <div>광고 문의</div> <a href="${url}promotion">상세 보기 ></a>
            </div>
            
            <div class="board-content">
                <div class="ch-number">
                   <div>진행 중</div>
                   <div>${map.totalPromCount}</div>
                </div>
                <div class="ch-number">
                   <div>대기</div>
                   <div>${map.waitPromCount}</div>
                </div>
                <div class="ch-number">
                   <div>승인</div>
                   <div>${map.acceptPromCount}</div>
                </div>
                <div class="ch-number">
                   <div>거절</div>
                   <div>${map.refusePromCount}</div>
                </div>
           </div>

           <div class="board-list">

                <div class="ch-list">
                        <div>브랜드명</div>
                        <div>상품명</div>
                        <div>신청일자</div>
                        <div>상태</div>
                </div>
                <c:forEach var="prom" items="${map.promList}">
                    <div class="ch-list bottom-line">
                        <div>${prom.brandName}</div>
                        <div>${prom.boardTitle}</div>
                        <div>${prom.createDate}</div>
                        <div>${prom.state}</div>
                    </div>
                </c:forEach>
                <!-- <div class="ch-list bottom-line">
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
                </div> -->

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
