<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>recruitmentParticipation</title>
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css/recruitment/recruitment_settlement.css">

</head>

<body>
    
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main>
        <div class="settlement-container">
            <!-- 정산하기 헤더 -->
            <div class="settlement-header">
                <h2>정산하기</h2>
            </div>

            <!-- 상품명 -->
            <div class="product-name">
                <p><strong>${recruitment.productName}</strong></p>
            </div>

            <!-- 결제 금액 -->
            <div class="payment-info">
                <p>내가 결제할 금액 : 
                    <strong>
                        <span class="amount">
                            <fmt:formatNumber 
                                value="${(recruitment.productPrice / recruitment.maxParticipants) * (recruitment.myParticipationCount > 0 ? recruitment.myParticipationCount : 1)}" 
                                pattern="#\,###"/> pt
                        </span>
                    </strong>
                </p>
            </div>

            <!-- 내 포인트 -->
            <div class="payment-info">
                <p>내 현재 포인트 : 
                    <strong>
                        <span class="current-point">
                            <fmt:formatNumber value="${loginMember.point}" pattern="#\,###"/> pt
                        </span>
                    </strong>
                </p>
            </div>

            <!-- 결제 후 잔액 -->
            <div class="payment-info">
                <p>결제 후 남은 잔액 : 
                    <strong>
                        <span class="remaining-point">
                            <fmt:formatNumber 
                                value="${loginMember.point - ((recruitment.productPrice / recruitment.maxParticipants) * (recruitment.myParticipationCount > 0 ? recruitment.myParticipationCount : 1))}" 
                                pattern="#\,###"/> pt
                        </span>
                    </strong>
                </p>
            </div>

            <!-- 결제하기 버튼 -->
            <form action="/group/settlement/complete" method="post">
                <input type="hidden" name="recruitmentNo" value="${recruitment.recruitmentNo}" />
                <input type="hidden" name="boardNo" value="${recruitment.boardNo}" />
                <input type="hidden" name="paymentAmount" 
                       value="${(recruitment.productPrice / recruitment.maxParticipants) * (recruitment.myParticipationCount > 0 ? recruitment.myParticipationCount : 1)}" />
                <input type="hidden" id="currentPoint" value="${loginMember.point}" />
                <input type="hidden" name="myQuantity" value="${recruitment.myParticipationCount}" />
                <button class="payment-btn" type="submit">결제하기</button>
            </form>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/individual/recruitment_settlement.js"></script>
    
</body>

</html>