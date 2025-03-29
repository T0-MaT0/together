<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기업 비밀번호 변경</title>
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
            <form action="/member/changePw2" method="POST" name="findPwFrm" id="findPwFrm">

                <input type="hidden" name="memberNo" value="${findMember.memberNo}">
                <input type="hidden" name="memberId" value="${findMember.memberId}">
                <div>
                <input type="hidden" name="authority" id="authority-input" value="3">

                    
    
                    <div id="find-id-info">비밀번호 변경하기.</div>
                    <div id="new-pw-area" class="input-area company-first">
                        <label for="memberPw">새 비밀번호</label>
                        <input type="password" name="memberPw" id="memberPw" class="memberNewPw">
                    </div>
                    <div id="new-pw-check-area" class="input-area company-last">
                        <label for="memberPwConfirm">비밀번호 확인</label>
                        <input type="password" name="memberPwConfirm" id="memberPwConfirm" class="newPwCheck">
                    </div>
                    <span id="pwMessage" class="signUp-message"></span>
                    <button id="change-pw" type="submit" class="company">비밀번호 변경하기</button>
                </div>

            </form>


        </div>
    </section>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script>
        const findPwFrm = document.getElementById("findPwFrm");
        const memberPw = document.getElementById("memberPw");
        const memberPwConfirm = document.getElementById("memberPwConfirm");

        findPwFrm.addEventListener("submit", function(e) {
            const pw = memberPw.value.trim();
            const pwCheck = memberPwConfirm.value.trim();

            // 비밀번호 정규식 (6~20자, 영문/숫자/특수문자 일부 허용)
            const regExp = /^[\w!@#\-_]{6,20}$/;

            // 비어있는지 확인
            if (pw === "" || pwCheck === "") {
                alert("비밀번호와 비밀번호 확인을 모두 입력해주세요.");
                e.preventDefault();
                return;
            }

            // 정규식 검사
            if (!regExp.test(pw)) {
                alert("비밀번호는 6~20자의 영문, 숫자, 특수문자(!@#-_ )만 사용 가능합니다.");
                e.preventDefault();
                return;
            }

            // 비밀번호 일치 여부 확인
            if (pw !== pwCheck) {
                alert("비밀번호가 서로 일치하지 않습니다.");
                e.preventDefault();
                return;
            }

            // 모든 조건을 만족하면 제출 진행 (alert 없이 그냥 통과)
        });
    </script>
    
</body>
</html>