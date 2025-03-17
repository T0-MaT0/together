<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>개인 비밀번호 찾기</title>
    <link rel="stylesheet" href="/resources/css/member/find-id-style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <section class="find-container">
        <div id="title">개인 회원 비밀번호 찾기</div>
        <div class="find-button-section">
            <div id="find-id-section" class="no-click" onclick="location.href='/member/findId'">아이디 찾기</div>
            <div id="find-pw-section" class="yes-click" onclick="location.href='/member/findPw'">비밀번호 찾기</div>
        </div>
        <div class="find-content">
            <form action="#" method="POST" name="findPwFrm" id="findPwFrm">

                <input type="hidden" name="authority" id="authority-input" value="2">
                <div id="find-id-info">회원정보에  등록된 이메일로 비밀번호를 찾을 수 있습니다.</div>
                <div id="id-area" class="input-area area-first">
                    <label for="memberId">아이디</label>
                    <input type="text" name="memberId" id="memberId">
                </div>
                <div id="birth-area" class="input-area">
                    <label for="memberBirth">생년월일</label>
                    <input type="text" name="memberBirth" id="memberBirth" placeholder="YYYYMMDD">
                </div>
                <div id="email-area" class="input-area area-middle">
                    <label for="memberEmail">이메일 주소</label>
                    <input type="text" name="memberEmail" id="memberEmail">
                    <button id="sendAuthKeyBtn" type="button">인증번호 받기</button>
                </div>
                <div id="email-check-area" class="input-area area-last">
                    <label for="emailCheck">인증 번호</label>
                    <input type="text" name="emailCheck" id="emailCheck">
                </div>
                <button id="findPwBtn">인증 확인</button>
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