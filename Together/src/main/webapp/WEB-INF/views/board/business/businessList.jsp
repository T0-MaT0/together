<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
                <img src="/resources/images/business/banner.png">
                <div class="banner-text">
                    Buy Together,<br>
                    <span>Sell Together!</span>
                </div>
            </div>

            <section class="boardList">
                <div class="title-area">
                    <a href="/board/2/search?search=">지금 🔥HOT🔥한 상품들</a>

                    <input type="checkbox" id="hotListToggle" class="list-toggle" checked>

                    <label for="hotListToggle">
                        <div class="list-style">
                            <div></div>
                            <div></div>
                            <div></div>
                        </div>
                    </label>
                </div>

                <div class="list-area">
                    <div>
                        <div class="product-img-area">
                            <img src="../../../resources/images/business/product.png">
                        </div>
                        <div class="product-detail-area">
                            <span>제품 회사 이름</span>
                            <span>제품 이름이 긴 상품</span>
                            <div class="product-price-area">
                                <span>5000원</span>
                                <span>10000원</span>
                            </div>
                        </div>
                    </div>
                    
                    <div>
                        <div class="product-img-area">
                            <img src="../../../resources/images/business/product.png">
                        </div>
                        <div class="product-detail-area">
                            <span>제품 회사 이름</span>
                            <span>제품 이름이 긴 상품</span>
                            <div class="product-price-area">
                                <span>5000원</span>
                                <span>10000원</span>
                            </div>
                        </div>
                    </div>
                    
                    <div>
                        <div class="product-img-area">
                            <img src="../../../resources/images/business/product.png">
                        </div>
                        <div class="product-detail-area">
                            <span>제품 회사 이름</span>
                            <span>제품 이름이 긴 상품</span>
                            <div class="product-price-area">
                                <span>5000원</span>
                                <span>10000원</span>
                            </div>
                        </div>
                    </div>
                    
                    <div>
                        <div class="product-img-area">
                            <img src="../../../resources/images/business/product.png">
                        </div>
                        <div class="product-detail-area">
                            <span>제품 회사 이름</span>
                            <span>제품 이름이 긴 상품</span>
                            <div class="product-price-area">
                                <span>5000원</span>
                                <span>10000원</span>
                            </div>
                        </div>
                    </div>
                    
                    <div>
                        <div class="product-img-area">
                            <img src="../../../resources/images/business/product.png">
                        </div>
                        <div class="product-detail-area">
                            <span>제품 회사 이름</span>
                            <span>제품 이름이 긴 상품</span>
                            <div class="product-price-area">
                                <span>5000원</span>
                                <span>10000원</span>
                            </div>
                        </div>
                    </div>
                    
                    <div>
                        <div class="product-img-area">
                            <img src="../../../resources/images/business/product.png">
                        </div>
                        <div class="product-detail-area">
                            <span>제품 회사 이름</span>
                            <span>제품 이름이 긴 상품</span>
                            <div class="product-price-area">
                                <span>5000원</span>
                                <span>10000원</span>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="product-img-area">
                            <img src="../../../resources/images/business/product.png">
                        </div>
                        <div class="product-info">
                            <span class="hidden">제품 회사 이름</span>
                            <span>제품 이름이 긴 상품</span>
                            <div class="product-price-area">
                                <span>5000원</span>
                                <span>10000원</span>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="product-img-area">
                            <img src="../../../resources/images/business/product.png">
                        </div>
                        <div class="product-info">
                            <span class="hidden">제품 회사 이름</span>
                            <span>제품 이름이 긴 상품</span>
                            <div class="product-price-area">
                                <span>5000원</span>
                                <span>10000원</span>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="product-img-area">
                            <img src="../../../resources/images/business/product.png">
                        </div>
                        <div class="product-info">
                            <span class="hidden">제품 회사 이름</span>
                            <span>제품 이름이 긴 상품</span>
                            <div class="product-price-area">
                                <span>5000원</span>
                                <span>10000원</span>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <div class="pagination-area">
                <ul class="pagination">
                    <li><a href="#">&lt;&lt;</a></li>

                    <li><a href="#">&lt;</a></li>
                    
                    <li><a class="current">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li><a href="#">6</a></li>
                    <li><a href="#">7</a></li>
                    <li><a href="#">8</a></li>
                    <li><a href="#">9</a></li>
                    <li><a href="#">10</a></li>
                    
                    <li><a href="#">&gt;</a></li>

                    <li><a href="#">&gt;&gt;</a></li>
                </ul>
            </div>
        </section>
    </main>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/main.js"></script>
</body>
</html>