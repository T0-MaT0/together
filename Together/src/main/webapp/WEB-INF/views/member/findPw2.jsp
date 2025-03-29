<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
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
        <form action="/member/findPw2" method="POST" name="findPwFrm" id="findPwFrm">

            <div id="find-id-info">회원정보에 등록된 이메일로 비밀번호를 찾을 수 있습니다.</div>

            <div class="input-area company-first underline">
                <label for="companyId">아이디</label>
                <input type="text" name="companyId" id="companyId">
            </div>

            <div class="input-area">
                <label for="companyNo">사업자 등록번호</label>
                <input type="text" name="companyNo" id="companyNo">
            </div>

            <div class="input-area area-middle">
                <label for="companyEmail">이메일 주소</label>
                <input type="text" name="companyEmail" id="companyEmail">
                <button type="button" id="sendAuthKeyBtn">인증번호 받기</button>
            </div>

            <div class="input-area company-last">
                <label for="emailCheck">인증 번호</label>
                <input type="text" name="emailCheck" id="emailCheck">
                <button type="button" id="checkAuthKeyBtn">인증번호 확인</button>
            </div>

            <button id="findPwBtn" class="company">비밀번호 확인</button>
        </form>
    </div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
    const companyId = document.getElementById("companyId");
    const companyNo = document.getElementById("companyNo");
    const companyEmail = document.getElementById("companyEmail");
    const emailCheck = document.getElementById("emailCheck");
    const sendAuthKeyBtn = document.getElementById("sendAuthKeyBtn");
    const checkAuthKeyBtn = document.getElementById("checkAuthKeyBtn");

    const checkObj = {
        companyId: false,
        companyNo: false,
        companyEmail: false,
        emailCheck: false
    };

    companyId.addEventListener("input", () => {
        checkObj.companyId = companyId.value.trim().length > 0;
    });

    companyNo.addEventListener("input", () => {
        checkObj.companyNo = companyNo.value.trim().length > 0;
    });

    companyEmail.addEventListener("input", () => {
        const regex = /^[A-Za-z\d\-\_]{4,}@\w+(\.\w+){1,3}$/;
        checkObj.companyEmail = regex.test(companyEmail.value.trim());
    });

    let authTimer;
    let authMin = 4;
    let authSec = 59;
    let tempEmail;

    sendAuthKeyBtn.addEventListener("click", () => {
        authMin = 4;
        authSec = 59;
        checkObj.emailCheck = false;

        if (checkObj.companyEmail) {
            fetch("/sendEmail/signUp?email=" + companyEmail.value)
                .then(resp => resp.text())
                .then(result => {
                    if (result > 0) {
                        alert("인증번호가 발송되었습니다.");
                        tempEmail = companyEmail.value;

                        clearInterval(authTimer);
                        authTimer = window.setInterval(() => {
                            if (authMin == 0 && authSec == 0) {
                                clearInterval(authTimer);
                                checkObj.emailCheck = false;
                                return;
                            }
                            if (authSec == 0) {
                                authSec = 60;
                                authMin--;
                            }
                            authSec--;
                        }, 1000);
                    } else {
                        alert("인증번호 발송 실패");
                    }
                })
                .catch(err => {
                    console.log("이메일 발송 중 에러 발생");
                    console.log(err);
                });
        } else {
            alert("유효한 이메일을 입력해주세요.");
            companyEmail.focus();
        }
    });

    checkAuthKeyBtn.addEventListener("click", () => {
        if (authMin <= 0 && authSec <= 0) {
            alert("인증 시간이 만료되었습니다. 다시 시도해주세요.");
            return;
        }

        const obj = { inputKey: emailCheck.value, email: tempEmail };
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
    });

    document.getElementById("findPwFrm").addEventListener("submit", function (e) {
        let message = "";

        for (let key in checkObj) {
            if (!checkObj[key]) {
                switch (key) {
                    case "companyId": message = "아이디가"; break;
                    case "companyNo": message = "사업자 등록번호가"; break;
                    case "companyEmail": message = "이메일 주소가"; break;
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
