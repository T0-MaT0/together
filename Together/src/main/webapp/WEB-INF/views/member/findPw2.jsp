<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기업 비밀번호 찾기</title>
    <link rel="stylesheet" href="/resources/css/member/find-id-style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <section class="find-container">
        <div id="title">기업 회원 비밀번호 찾기</div>
        <div class="find-button-section">
            <div id="find-id-section" class="no-click-company" onclick="location.href='/member/findId2'">아이디 찾기</div>
            <div id="find-pw-section" class="yes-click" onclick="location.href='/member/findPw2'">비밀번호 찾기</div>
        </div>
        <div class="find-content">
            <form action="#" method="POST" name="findPwFrm" id="findPwFrm">


                <div id="find-id-info">회원정보에  등록된 이메일로 비밀번호를 찾을 수 있습니다.</div>
                <div id="id-area" class="input-area company-first">
                    <label for="companyId">아이디</label>
                    <input type="text" name="companyId" id="companyId">
                </div>
                <div id="company-no-area" class="input-area">
                    <label for="companyNo">사업자 등록번호</label>
                    <input type="text" name="companyNo" id="companyNo">
                </div>
                <div id="email-area" class="input-area area-middle">
                    <label for="companyEmail">이메일 주소</label>
                    <input type="text" name="companyEmail" id="companyEmail">
                    <button id="sendAuthKeyBtn" type="button">인증번호 받기</button>
                </div>
                <div id="email-check-area" class="input-area company-last">
                    <label for="emailCheck">인증 번호</label>
                    <input type="text" name="emailCheck" id="emailCheck">
                    <button id="checkAuthKeyBtn" type="button">인증번호 확인</button>
                </div>
                <button id="findPwBtn" class="company">비밀번호 확인</button>
            </form>
        </div>
    </section>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script>
        document.getElementById("findPwFrm").addEventListener("submit", function(e) {
            const memberId = document.getElementById("memberId");
            const memberBirth = document.getElementById("memberBirth");
            const memberEmail = document.getElementById("memberEmail");
            const emailCheck = document.getElementById("emailCheck");
        
            if (memberId.value.trim() === "") {
                alert("아이디를 입력해주세요.");
                memberId.focus();
                e.preventDefault();
                return;
            }
        
            if (memberBirth.value.trim() === "") {
                alert("생년월일을 입력해주세요.");
                memberBirth.focus();
                e.preventDefault();
                return;
            }
        
            if (memberEmail.value.trim() === "") {
                alert("이메일을 입력해주세요.");
                memberEmail.focus();
                e.preventDefault();
                return;
            }
        
            if (emailCheck.value.trim() === "") {
                alert("이메일 인증번호를 입력해주세요.");
                emailCheck.focus();
                e.preventDefault();
                return;
            }
        
            // 모든 입력값이 있을 경우 제출 진행
        });
        </script>
    
</body>
</html>