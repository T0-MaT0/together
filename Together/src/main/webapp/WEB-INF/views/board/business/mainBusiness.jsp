<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="businessHotList" value="${map.businessHotList}"/>
<c:set var="businessNewList" value="${map.businessNewList}"/>

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
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <main>
        <section class="content">
            <div class="banner">
                <img src="/resources/images/business/banner.png">
                <div class="banner-text">
                    Buy Together,<br>
                    <span>Sell Together!</span>
                </div>
            </div>

            <section class="boardList">
                <div class="title-area">
                    <a href="/board/2/search?category=hot">지금 🔥HOT🔥한 상품들</a>

                    <input type="checkbox" id="hotListToggle" class="list-toggle hidden">

                    <label for="hotListToggle">
                        <div class="list-style">
                            <div></div>
                            <div></div>
                            <div></div>
                        </div>
                    </label>
                </div>

                <div class="list-area">
                    <!-- 상품 목록 조회 결과가 비어있지 않다면 -->
                    <c:if test="${!empty businessHotList}">
                        <c:forEach var="product" items="${businessHotList}">
                            <div class="product-item">
                                <div class="product-img-area">
                                    <a href="#">
                                        <img src="/resources/images/business/product.png">
                                    </a>
                                </div>
                                <div class="product-info">
                                    <span>${product.memberNickname}</span>
                                    <a href="#">${product.boardTitle}</a>
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

            <section class="boardList">
                <div class="title-area">
                    <a href="/board/2/search?category=new">🆕새로 올라온 상품들🆕</a>

                    <input type="checkbox" id="newListToggle" class="list-toggle hidden">

                    <label for="newListToggle">
                        <div class="list-style">
                            <div></div>
                            <div></div>
                            <div></div>
                        </div>
                    </label>
                </div>

                <div class="list-area">
                    <!-- 상품 목록 조회 결과가 비어있지 않다면 -->
                    <c:if test="${!empty businessNewList}">
                        <c:forEach var="product" items="${businessNewList}">
                            <div class="product-item">
                                <div class="product-img-area">
                                    <a href="#">
                                        <img src="/resources/images/business/product.png">
                                    </a>
                                </div>
                                <div class="product-info">
                                    <span>${product.memberNickname}</span>
                                    <a href="#">${product.boardTitle}</a>
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

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/main.js"></script>
    <script src="/resources/js/business/businessList.js"></script>
</body>
</html>