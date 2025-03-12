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
    <link rel="stylesheet" href="/resources/css/manager-css/brand/result-list.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/graph.css" />
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
             &nbsp; <div> - 성과</div>
        </div>
    </header>

    <!-- 본문(종앙) -->
    <div id="container-center">
        <section class="cus-board list-card">
            <!-- 성과 데이터 리스트 -->
            <div class="board-title bottom-line">
                <div class="title">성과 데이터</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>클릭수</option>
                        <option>상품수</option>
                    </select>
                </div>
            </div>

            <!-- 리스트 내역 -->
            
            <div id="list-area">
                <div class="list">
                    <div>순위</div>
                    <div>브랜드</div>
                    <div>상품명</div>
                    <div>판매기간</div>
                    <div>클릭수</div>
                    <div>판매수</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
                </div>
                
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>델몬트</div>
                    <div>사과, 오렌지 주스 세트</div>
                    <div>2025.02.25 - 2025.02.10</div>
                    <div>10000</div>
                    <div>10000</div>
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


        
        <!-- 광고 신청 규모 -->
        <section class="cus-board graph-card">
        
            <div class="board-title ">
                <div class="title">판매 순위</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>주</option>
                        <option>월</option>
                        <option>년</option>
                    </select>
                </div>
                
            </div>
            
            <div class="graph-container">
                <div class="label">1. 델몬트</div>
                <div class="graphArea">
                    <div class="graphBar blue"></div>
                    <div class="graphBar red"></div>
                </div>
            </div>
            <div class="graph-container">
                <div class="label">1. 델몬트</div>
                <div class="graphArea">
                    <div class="graphBar blue"></div>
                    <div class="graphBar red"></div>
                </div>
            </div>
            <div class="graph-container">
                <div class="label">1. 델몬트</div>
                <div class="graphArea">
                    <div class="graphBar blue"></div>
                    <div class="graphBar red"></div>
                </div>
            </div>
            <div class="graph-container">
                <div class="label">1. 델몬트</div>
                <div class="graphArea">
                    <div class="graphBar blue"></div>
                    <div class="graphBar red"></div>
                </div>
            </div>
            <div class="graph-container">
                <div class="label">1. 델몬트</div>
                <div class="graphArea">
                    <div class="graphBar blue"></div>
                    <div class="graphBar red"></div>
                </div>
            </div>
            <div class="graph-container">
                <div class="label">1. 델몬트</div>
                <div class="graphArea">
                    <div class="graphBar blue"></div>
                    <div class="graphBar red"></div>
                </div>
            </div>
        </section>

        
    </div>


</main>

</body>

</html>
