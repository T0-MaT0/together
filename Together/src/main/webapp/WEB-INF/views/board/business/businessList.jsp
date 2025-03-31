<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="title" value="${param.query}/부모 카테고리>자식 카테고리"/>
<c:set var="businessList" value="${map.businessList}"/>
<c:set var="pagination" value="${map.pagination}"/>
<c:set var="url" value="search?cp="/>
<c:set var="qs" value="&category=${param.category}&query=${param.query}"/>

<c:if test="${param.category=='hot'||param.category=='new'}">
	<c:set var="qs" value="&category=${param.category}"/>
</c:if>

<c:if test="${param.category=='hot'}">
    <c:set var="title" value="지금 🔥HOT🔥한 상품들"/>
</c:if>

<c:if test="${param.category=='new'}">
    <c:set var="title" value="🆕새로 올라온 상품들🆕"/>
</c:if>

<c:if test="${param.category=='hot'||param.category=='new'}">
    <c:set var="toggleId" value="${param.category}"/>
</c:if>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>브랜드 목록 페이지</title>

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
                <img src="" id="bannerImg">
            </div>

            
            <section class="boardList">
                <div class="title-area">
                    <span>${title}</span>

                    <input type="checkbox" id="${toggleId}ListToggle" class="list-toggle hidden">

                    <label for="${toggleId}ListToggle">
                        <div class="list-style">
                            <div></div>
                            <div></div>
                            <div></div>
                        </div>
                    </label>
                </div>

                <div class="list-area">
                    <c:if test="${!empty businessList}">
                        <c:forEach var="product" items="${businessList}">
                            <div class="product-item">
                                <div class="product-img-area">
                                    <a href="/board/${boardCode}/${product.boardNo}">
                                        <img src="${product.imageList[0].imagePath}${product.imageList[0].imageReName}">
                                    </a>
                                </div>
                                <div class="product-info" url="/board/${boardCode}/${product.boardNo}">
                                    <span>${product.memberNickname}</span>
                                    <a href="/board/${boardCode}/${product.boardNo}">${product.boardTitle}</a>
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
            <div class="pagination-area">
                <c:if test="${pagination.maxPage>1}">
                    <ul class="pagination">
                        <li><a href="${url}1${qs}">&lt;&lt;</a></li>
    
                        <li><a href="${url}${pagination.prevPage}${qs}">&lt;</a></li>
                        
                        <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
                            <c:if test="${pagination.currentPage==i}">
                                <li><a class="current">${i}</a></li>
                            </c:if>
                            
                            <c:if test="${pagination.currentPage!=i}">
                                <li><a href="${url}${i}${qs}">${i}</a></li>
                            </c:if>
                        </c:forEach>
                        
                        <li><a href="${url}${pagination.nextPage}${qs}">&gt;</a></li>
    
                        <li><a href="${url}${pagination.maxPage}${qs}">&gt;&gt;</a></li>
                    </ul>
                </c:if>
            </div>
        </section>
    </main>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/main.js"></script>
    <script>
        const bannerList = JSON.parse(`${bannerList}`);
    </script>
    <script src="/resources/js/business/businessList.js"></script>
</body>
</html>