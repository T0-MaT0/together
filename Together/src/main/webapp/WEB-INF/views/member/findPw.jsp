<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
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
        <form action="/member/findPw" method="POST" name="findPwFrm" id="findPwFrm">
            <input type="hidden" name="authority" value="2">

            <div id="find-id-info">회원정보에 등록된 이메일로 비밀번호를 찾을 수 있습니다.</div>

            <div class="input-area area-first underline">
                <label for="memberId">아이디</label>
                <input type="text" name="memberId" id="memberId">
            </div>

            <div class="input-area">
                <label for="memberBirth">생년월일</label>
                <input type="text" name="memberBirth" id="memberBirth" placeholder="YYYYMMDD">
            </div>

            <div class="input-area area-middle">
                <label for="memberEmail">이메일 주소</label>
                <input type="text" name="memberEmail" id="memberEmail">
                <button id="sendAuthKeyBtn" type="button">인증번호 받기</button>
            </div>

            <div class="input-area area-last">
                <label for="emailCheck">인증 번호</label>
                <input type="text" name="emailCheck" id="emailCheck">
                <button id="checkAuthKeyBtn" type="button">인증번호 확인</button>
            </div>

            <button id="findPwBtn">비밀번호 변경</button>
        </form>
    </div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
    const memberId = document.getElementById("memberId");
    const memberBirth = document.getElementById("memberBirth");
    const memberEmail = document.getElementById("memberEmail");
    const sendAuthKeyBtn = document.getElementById("sendAuthKeyBtn");
    const checkAuthKeyBtn = document.getElementById("checkAuthKeyBtn");
    const emailCheck = document.getElementById("emailCheck");

    const checkObj = {
        "memberId": false,
        "memberBirth": false,
        "memberEmail": false,
        "emailCheck": false
    };

    memberId.addEventListener("input", () => {
        checkObj.memberId = memberId.value.trim().length > 0;
    });

    memberBirth.addEventListener("input", () => {
        checkObj.memberBirth = memberBirth.value.trim().length === 8;
    });

    memberEmail.addEventListener("input", () => {
        if (memberEmail.value.trim().length == 0) {
            checkObj.memberEmail = false;
            return;
        }

        const reqExp = /^[A-Za-z\d\-\_]{4,}@\w+(\.\w+){1,3}$/;

        checkObj.memberEmail = reqExp.test(memberEmail.value.trim());
    });

    let authTimer;
    let authMin = 4;
    let authSec = 59;
    let tempEmail;

    sendAuthKeyBtn.addEventListener("click", function () {
        authMin = 4;
        authSec = 59;
        checkObj.emailCheck = false;

        if (checkObj.memberEmail) {
            fetch("/sendEmail/signUp?email=" + memberEmail.value)
                .then(resp => resp.text())
                .then(result => {
                    if (result > 0) {
                        console.log("인증번호가 발송되었습니다.");
                        tempEmail = memberEmail.value;
                    } else {
                        console.log("인증번호 발송 실패");
                    }
                })
                .catch(err => {
                    console.log("이메일 발송 중 에러 발생");
                    console.log(err);
                });

            alert("인증번호가 발송되었습니다.");

            clearInterval(authTimer);

            authTimer = window.setInterval(() => {
                if (authMin == 0 && authSec == 0) {
                    checkObj.emailCheck = false;
                    clearInterval(authTimer);
                    return;
                }

                if (authSec == 0) {
                    authSec = 60;
                    authMin--;
                }

                authSec--;

            }, 1000);

        } else {
            alert("유효한 이메일을 입력해주세요.");
            memberEmail.focus();
        }
    });

    checkAuthKeyBtn.addEventListener("click", function () {
        if (authMin > 0 || authSec > 0) {
            const obj = { "inputKey": emailCheck.value, "email": tempEmail };
            const query = new URLSearchParams(obj).toString();

            fetch("/sendEmail/checkAuthKey?" + query)
                .then(resp => resp.text())
                .then(result => {
                    if (result > 0) {
                        clearInterval(authTimer);
                        alert("인증되었습니다.");
                        checkObj.emailCheck = true;
                    } else {
                        alert("인증번호가 일치하지 않습니다.");
                        checkObj.emailCheck = false;
                    }
                })
                .catch(err => console.log(err));
        } else {
            alert("인증 시간이 만료되었습니다. 다시 시도해주세요.");
        }
    });

    document.getElementById("findPwFrm").addEventListener("submit", function (e) {
        let message = "";

        for (let key in checkObj) {
            if (!checkObj[key]) {
                switch (key) {
                    case "memberId": message = "아이디가"; break;
                    case "memberBirth": message = "생년월일이"; break;
                    case "memberEmail": message = "이메일 주소가"; break;
                    case "emailCheck": message = "인증 번호가"; break;
                }

                message += " 유효하지 않습니다.";
                alert(message);
                document.getElementById(key).focus();
                e.preventDefault();
                return false;
            }
        }
    });
</script>
</body>
</html>
