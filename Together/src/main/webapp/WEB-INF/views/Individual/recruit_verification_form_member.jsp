<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>recruit_verification_form</title>
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css/recruitment_detail/recruit_verification_form.css">

</head>

<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main class="verification-container">
        <h2 class="verification-title">공구 인증 폼</h2>

        <div class="verification-section">
            <label class="section-label">공구 인증 QR</label>
            <div class="qr-box">
                <c:choose>
                    <c:when test="${not empty recruitment.qrImagePath}">
                        <img src="${recruitment.qrImagePath}" alt="공구 인증 QR" class="qr-preview">
                    </c:when>
                    <c:otherwise>
                        <span class="plus-icon">+</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="verification-section">
            <label class="section-label">운송장</label>
            <p>${recruitment.trackingNumber}</p>
        </div>
        <div class="date-section">
            <div class="date-box">
                <label class="date-label">택배 예상 도착일</label>
                <p>
                    ${recruitment.deliveryExpected}
                </p>
            </div>
            <div class="date-box">
                <label class="date-label">모집원 예상 수령일</label>
                <p>
                    ${recruitment.memberReceiveDate}
                </p>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>

</html>