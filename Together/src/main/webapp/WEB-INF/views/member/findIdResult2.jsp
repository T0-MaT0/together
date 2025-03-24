<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기업 아이디 결과</title>
    <link rel="stylesheet" href="/resources/css/member/find-id-style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <section class="find-container">
        <div id="title">개인 회원 아이디 찾기</div>
        <div class="find-button-section">
            <div id="find-id-section" class="yes-click" onclick="location.href='/member/findId2'">아이디 찾기</div>
            <div id="find-pw-section" class="no-click-company" onclick="location.href='/member/findPw2'">비밀번호 찾기</div>
        </div>
        <div class="find-content">
            <c:choose>
                <c:when test="${not empty findMember}">
                    <div>
                        <div id="find-id-info">이메일 주소와 일치하는 아이디입니다.</div>
                        <div id="id-area" class="input-area area-first">
                            <label for="memberId">아이디</label>
                            <input type="text" name="memberId" id="memberId" value="${findMember.memberId}" disabled>
                        </div>
                        <div id="signUpDate-area" class="input-area area-last">
                            <label for="signUpDate">가입일</label>
                            <input type="text" name="signUpDate" id="signUpDate" value="${findMember.enrollDate}" disabled>
                        </div>
                        <button id="goBackLogin" onclick="location.href='/member/login'">확인</button>
                        <button id="changePwPage" onclick="location.href='/member/findPw'">비밀번호 재설정</button>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-result-container">
                        <div class="no-result-message">
                            이름과 이메일을 만족하는 회원이 없습니다.
                        </div>
                        <button class="goback" onclick="location.href='/member/findId'">다시 시도하기</button>

                    </div>
                </c:otherwise>
            </c:choose>



        </div>
    </section>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
</body>
</html>