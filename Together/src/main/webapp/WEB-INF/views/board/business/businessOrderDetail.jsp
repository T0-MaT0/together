<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="thumbnail" value="${business.imageList[0].imagePath}${business.imageList[0].imageReName}"/>
<c:set var="optionCount" value="${fn:length(business.optionList)}"/>
<c:set var="price" value="${business.productPrice * param.quantity}"/>
<c:set var="totalPrice" value="${price + business.deliveryFee}"/>
<c:set var="sumPrice" value="${loginMember.point-totalPrice}"/>

<c:choose>
    <c:when test="${sumPrice>=0}">
        <c:set var="resultClassName" value="violet-color"/>
    </c:when>
    <c:otherwise>
        <c:set var="resultClassName" value="minus"/>
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>브랜드 상품 주문 내역</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <link rel="stylesheet" href="/resources/css/businessOrder-style.css">
    
    <script src="https://kit.fontawesome.com/f8edd1a12b.js" crossorigin="anonymous"></script>
</head>

<body>
	<section class="order-header">
        <div class="header-up">
            <a href="/">
                <img src="/resources/images/business/logo.png">
            </a>
            <span>To 브랜드</span>
            <a href="/mypage/home">
                <c:choose>
                    <c:when test="${empty loginMember.profileImg}">
                        <i class="fa-regular fa-user"></i>
                    </c:when>
                    <c:otherwise>
                        <img src="${loginMember.profileImg}">
                    </c:otherwise>
                </c:choose>
            </a>
        </div>
        <div class="header-down">
            <span>주문 내역</span>
        </div>
    </section>

    <main>
        <section>
            <div class="content-box delivery">
                <span class="small">2025.03.07 15:20:26</span>
                <span>주문 번호: 1</span>
                <span>운송장 번호: 배송 준비 중입니다.</span>
            </div>
            <h2 class="title">주문 상품</h2>
            <div class="content-box">
                <div class="business-title">
                    <div>
                        <span>브랜드명</span>
                        <span class="small">배송비 무료</span>
                    </div>
                    <button>문의하기</button>
                </div>
                <span class="small">구매일 2025.03.07(금)</span>
                <div class="option-area">
                    <img src="/resources/images/business/product.png">
                    <div>
                        <span>상품명</span>
                        <span class="small">옵션명|1개</span>
                        <span>10,000원</span>
                    </div>
                </div>
            </div>
            <h2 class="title">결제 정보</h2>
            <div class="content-box">
                <div class="total-price">
                    <span>주문금액</span>
                    <span>총 10,000원</span>
                </div>
                <div class="price-area">
                    <div>
                        <span>상품 금액</span>
                        <span>배송비</span>
                    </div>
                    <div>
                        <span>10,000원</span>
                        <span>무료</span>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <script>
        const memberAddr="${loginMember.memberAddr}".split("^^^ ");
    </script>
    <script src="/resources/js/business/order.js"></script>
</body>
</html>