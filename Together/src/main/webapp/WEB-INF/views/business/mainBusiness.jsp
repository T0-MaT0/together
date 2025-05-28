<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 서버에서 전달받은 데이터 변수로 저장 -->
<c:set var="businessHotList" value="${map.businessHotList}"/>
<c:set var="businessNewList" value="${map.businessNewList}"/>
<c:set var="url" value="/product/"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>브랜드 메인 페이지</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css/mainBusiness-style.css">
</head>

<body>
    <!-- 헤더 영역 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <main>
        <section class="content">
            <!-- 배너 영역 -->
            <div class="banner">
                <img src="/resources/images/business/businessbanner.png" id="bannerImg">
            </div>

            <!-- 조회수 순 상품 6개 정렬 -->
            <section class="productList">
                <div class="title-area">
                    <a href="/product/search?category=hot">지금 🔥HOT🔥한 상품들</a>

                    <!-- 토들 버튼(리스트 스타일 변경용) -->
                    <input type="checkbox" id="hotListToggle" class="list-toggle hidden">

                    <!-- 토글 아이콘 영역 -->
                    <label for="hotListToggle">
                        <div class="list-style">
                            <div></div>
                            <div></div>
                            <div></div>
                        </div>
                    </label>
                </div>

                <!-- 상품 리스트 영역 -->
                <div class="list-area">
                    <!-- 상품 목록 조회 결과가 비어있다면 -->
                    <c:if test="${empty businessHotList}">
                        등록된 상품이 없습니다.
                    </c:if>
                    <!-- 상품 목록 조회 결과가 비어있지 않다면 -->
                    <c:if test="${!empty businessHotList}">
                        <c:forEach var="product" items="${businessHotList}">
                            <div class="product-item">
                                <div class="product-img-area">
                                    <a href="${url}${product.productNo}">
                                        <img src="${product.thumbnail}">
                                    </a>
                                </div>
                                <div class="product-info" url="${url}${product.productNo}">
                                    <span>${product.memberNick}</span>
                                    <a href="${url}${product.productNo}">${product.productTitle}</a>
                                    <div class="product-price-area">
                                        <!-- <span>
                                            <fmt:formatNumber value="${product.productPrice / 2}" type="number" maxFractionDigits="0"/>원
                                        </span> -->
                                        <span>
                                            <fmt:formatNumber value="${product.productPrice}" type="number" maxFractionDigits="0"/>원
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </section>

            <!-- 최신순 상품 6개 정렬 -->
            <section class="productList">
                <div class="title-area">
                    <a href="/product/search?category=new">🆕새로 올라온 상품들🆕</a>

                    <!-- 토글 버튼(리스트 스타일 변경용) -->
                    <input type="checkbox" id="newListToggle" class="list-toggle hidden">

                    <label for="newListToggle">
                        <div class="list-style">
                            <div></div>
                            <div></div>
                            <div></div>
                        </div>
                    </label>
                </div>

                <!-- 상품 리스트 영역 -->
                <div class="list-area">
                    <!-- 상품 목록 조회 결과가 비어있다면 -->
                    <c:if test="${empty businessNewList}">
                        등록된 상품이 없습니다.
                    </c:if>
                    <!-- 상품 목록 조회 결과가 비어있지 않다면 -->
                    <c:if test="${!empty businessNewList}">
                        <c:forEach var="product" items="${businessNewList}">
                            <div class="product-item">
                                <div class="product-img-area">
                                    <a href="${url}${product.productNo}">
                                        <img src="${product.thumbnail}">
                                    </a>
                                </div>
                                <div class="product-info" url="${url}${product.productNo}">
                                    <span>${product.memberNick}</span>
                                    <a href="${url}${product.productNo}">${product.productTitle}</a>
                                    <div class="product-price-area">
                                        <span>
                                            <fmt:formatNumber value="${product.productPrice}" type="number" maxFractionDigits="0"/>원
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </section>
        </section>
    </main>

    <!-- 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <!-- 해더/푸터용 JS 파일 로드 -->
    <script src="/resources/js/main.js"></script>
    <script>
        // 동적으로 배너 리스트 삽입
        const bannerList = JSON.parse(`${bannerList}`);
        // 서버에서 JSON 형식으로 데이터를 보내서 받은 데이터도 JSON 형식으로 파싱해야함
    </script>
    <!-- JS 파일 로드 -->
    <script src="/resources/js/business/businessList.js"></script>
</body>
</html>