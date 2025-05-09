<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="thumbnail" value="${business.imageList[0].imagePath}${business.imageList[0].imageReName}"/>
<c:set var="price" value="${business.productPrice * order.quantity}"/>
<c:set var="totalPrice" value="${price + business.deliveryFee}"/>

<fmt:parseDate value="${usage.usageDate}" var="parsedDate" pattern="yyyy-MM-dd HH:mm:ss" />

<c:forEach var="option" items="${business.optionList}">
    <c:if test="${option.optionNo==order.optionNo}">
        <c:set var="optionName" value="${option.optionName}"/>
    </c:if>
</c:forEach>

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
                <span class="small">${usage.usageDate}</span>
                <span>주문 번호: ${order.orderNo}</span>
                <span>
                    운송장 번호:
                    <c:if test="${empty order.trackingNo}">
                        배송 준비 중입니다.
                    </c:if>
                    <c:if test="${!empty order.trackingNo}">
                        ${usage.trackingNo}
                    </c:if>
                </span>
            </div>
            <h2 class="title">주문 상품</h2>
            <div class="content-box">
                <div class="business-title">
                    <div>
                        <span onclick="gotoDetail()">${business.boardTitle}</span>
                        <span class="small">
                            배송비 
                            <c:if test="${empty business.deliveryFee}">
                                무료
                            </c:if>
                            <c:if test="${!empty business.deliveryFee}">
                                <fmt:formatNumber value="${business.deliveryFee}" type="number" maxFractionDigits="0"/>원
                            </c:if>
                        </span>
                    </div>
                    <div>
                        <button onclick="openPopup('view')">리뷰작성</button>
                        <button onclick="openPopup('ply')">문의하기</button>
                    </div>
                </div>
                <span class="small">
                    구매일 <fmt:formatDate value="${parsedDate}" pattern="yyyy.MM.dd(E)" />
                </span>
                <div class="option-area">
                    <img src="${thumbnail}" onclick="gotoDetail()">
                    <div>
                        <span onclick="gotoDetail()">${business.boardTitle}</span>
                        <span class="small">${optionName} | ${order.quantity}개</span>
                        <span>
                            <fmt:formatNumber value="${price}" type="number" maxFractionDigits="0"/>원
                        </span>
                    </div>
                </div>
            </div>
            <h2 class="title">결제 정보</h2>
            <div class="content-box">
                <div class="total-price">
                    <span>주문금액</span>
                    <span>
                        총 <fmt:formatNumber value="${totalPrice}" type="number" maxFractionDigits="0"/>원
                    </span>
                </div>
                <div class="price-area">
                    <div>
                        <span>상품 금액</span>
                        <span>배송비</span>
                    </div>
                    <div>
                        <span>
                            <fmt:formatNumber value="${price}" type="number" maxFractionDigits="0"/>원
                        </span>
                        <span>
                            <c:if test="${empty business.deliveryFee}">
                                무료
                            </c:if>
                            <c:if test="${!empty business.deliveryFee}">
                                <fmt:formatNumber value="${business.deliveryFee}" type="number" maxFractionDigits="0"/>원
                            </c:if>
                        </span>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <script>
        const memberAddr="${loginMember.memberAddr}".split("^^^ ");
        const boardCode = "${boardCode}";
        const boardNo = "${boardNo}";
        const orderNo = "${order.orderNo}";
    </script>
    <script src="/resources/js/business/order.js"></script>
</body>
</html>