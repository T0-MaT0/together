<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>개인 아이디 찾기</title>
    <link rel="stylesheet" href="/resources/css/member/find-id-style.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
    <section class="find-container">
        <div id="title">개인 회원 아이디 찾기</div>
        <div class="find-button-section">
            <div id="find-id-section" class="yes-click" onclick="location.href='/member/findId'">아이디 찾기</div>
            <div id="find-pw-section" class="no-click" onclick="location.href='/member/findPw'">비밀번호 찾기</div>
        </div>
        
        <div class="find-content">
            <form action="/member/findId" method="POST" name="findIdFrm" id="findIdFrm">

                <input type="hidden" name="authority" id="authority-input" value="2">

                <div id="find-id-info">회원정보에  등록된 이메일로 아이디를 찾을 수 있습니다.</div>
                <div id="name-area" class="input-area area-first">
                    <label for="memberName">이름</label>
                    <input type="text" name="memberName" id="memberName">
                </div>
                <div id="email-area" class="input-area area-middle">
                    <label for="memberEmail">이메일 주소</label>
                    <input type="text" name="memberEmail" id="memberEmail">
                    <button id="sendAuthKeyBtn" type="button">인증번호 받기</button>
                </div>
                <div id="email-check-area" class="input-area area-last">
                    <label for="emailCheck">인증 번호</label>
                    <input type="text" name="emailCheck" id="emailCheck">
                    <button id="checkAuthKeyBtn" type="button">인증번호 확인</button>
                </div>
                <button id="findIdBtn">아이디 확인</button>
            </form>
        </div>
    </section>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script>
        document.getElementById("findIdFrm").addEventListener("submit", function(e) {
        const memberName = document.getElementById("memberName");
        const memberEmail = document.getElementById("memberEmail");
        const emailCheck = document.getElementById("emailCheck");

        if (memberName.value.trim() === "") {
            alert("이름을 입력해주세요.");
            memberName.focus();
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

        // 모든 입력이 올바르면 제출 진행
    });
    </script>
    
</body>
</html>