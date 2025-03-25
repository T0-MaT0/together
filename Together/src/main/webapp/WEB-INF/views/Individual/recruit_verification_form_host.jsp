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
        <h2 class="verification-title">모집 인증 폼</h2>
    
        <c:choose>
            <c:when test="${isVerificationFormExists}">
                <form action="/group/verification/update" method="post">
                    <input type="hidden" name="recruitmentNo" value="${recruitment.recruitmentNo}" />
                    <input type="hidden" name="boardNo" value="${recruitment.boardNo}" />
    
                    <div class="verification-section">
                        <label class="section-label">모집 인증 QR</label>
                        <div class="qr-box">
                            <img src="${recruitment.qrImagePath}" alt="모집 인증 QR" class="qr-preview">
                        </div>
                    </div>
    
                    <div class="verification-section">
                        <label class="section-label">운송장</label>
                        <input type="text" name="trackingNumber" class="tracking-input" value="${recruitment.trackingNumber}" placeholder="운송장 번호">
                    </div>
    
                    <div class="date-section">
                        <div class="date-box">
                            <label class="date-label">택배 예상 도착일</label>
                            <input type="date" name="deliveryExpected" class="date-input" value="${recruitment.deliveryExpected}">
                        </div>
                        <div class="date-box">
                            <label class="date-label">모집원 예상 수령일</label>
                            <input type="date" name="memberReceiveDate" class="date-input" value="${recruitment.memberReceiveDate}">
                        </div>
                    </div>
    
                    <button type="submit" class="register-btn">모집 인증 폼 수정하기</button>
                </form>
            </c:when>
    
            <c:otherwise>
                <form action="/group/verification/register" method="post">
                    <input type="hidden" name="recruitmentNo" value="${recruitment.recruitmentNo}" />
                    <input type="hidden" name="boardNo" value="${recruitment.boardNo}" />
    
                    <div class="verification-section">
                        <label class="section-label">모집 인증 QR</label>
                        <div class="qr-box">
                            <span class="plus-icon">+</span>
                        </div>
                    </div>
    
                    <div class="verification-section">
                        <label class="section-label">운송장</label>
                        <input type="text" name="trackingNumber" class="tracking-input" placeholder="운송장 번호를 등록하세요">
                    </div>
    
                    <div class="date-section">
                        <div class="date-box">
                            <label class="date-label">택배 예상 도착일</label>
                            <input type="date" name="deliveryExpected" class="date-input"
                             min="2024-01-01" max="2030-12-31">
                        </div>
                        <div class="date-box">
                            <label class="date-label">모집원 예상 수령일</label>
                            <input type="date" name="memberReceiveDate" class="date-input"
                            min="2024-01-01" max="2030-12-31">
                        </div>
                    </div>
    
                    <button type="submit" class="register-btn">모집 인증 폼 등록하기</button>
                </form>
            </c:otherwise>
        </c:choose>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>

</html>