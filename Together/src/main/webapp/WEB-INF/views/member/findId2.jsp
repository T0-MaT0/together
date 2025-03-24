<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기업 아이디 찾기</title>
    <link rel="stylesheet" href="/resources/css/member/find-id-style.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
    <section class="find-container">
        <div id="title">기업 회원 아이디 찾기</div>
        <div class="find-button-section">
            <div id="find-id-section" class="yes-click" onclick="location.href='/member/findId2'">아이디 찾기</div>
            <div id="find-pw-section" class="no-click-company" onclick="location.href='/member/findPw2'">비밀번호 찾기</div>
        </div>
        <div class="find-content">
            <form action="/member/findId" method="POST" name="findIdFrm" id="findIdFrm">


                <input type="hidden" name="authority" id="authority-input" value="3">

                <div id="find-id-info">회원정보에  등록된 이메일로 아이디를 찾을 수 있습니다.</div>
                <div id="name-area" class="input-area company-first">
                    <label for="memberName">이름</label>
                    <input type="text" name="memberName" id="memberName">
                </div>
                <div id="email-area" class="input-area area-middle">
                    <label for="memberEmail">이메일 주소</label>
                    <input type="text" name="memberEmail" id="memberEmail">
                    <button id="sendAuthKeyBtn" type="button">인증번호 받기</button>
                </div>
                <div id="email-check-area" class="input-area company-last">
                    <label for="emailCheck">인증 번호</label>
                    <input type="text" name="emailCheck" id="emailCheck">
                    <button id="checkAuthKeyBtn" type="button">인증번호 확인</button>
                </div>
                <button id="findIdBtn" class="company">아이디 확인</button>
            </form>
        </div>
    </section>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script>
        const memberEmail = document.getElementById("memberEmail");
        const sendAuthKeyBtn = document.getElementById("sendAuthKeyBtn");
        const checkAuthKeyBtn = document.getElementById("checkAuthKeyBtn");
        const emailCheck = document.getElementById("emailCheck");
        const checkObj = {
            "memberName" : false,
            "memberEmail": false,
            "emailCheck": false
        };

        const memberName = document.getElementById("memberName");
        memberName.addEventListener("input", ()=>{
            if (memberName.value.trim().length === 0) {
                checkObj.memberName = false;
            } else {
                checkObj.memberName = true;
            }
        })

        memberEmail.addEventListener("input", function () {

            if (memberEmail.value.trim().length == 0) {
                checkObj.memberEmail = false;
                return;
            }

            const reqExp = /^[A-Za-z\d\-\_]{4,}@\w+(\.\w+){1,3}$/;

            if(reqExp.test(memberEmail.value)){ // 이메일 유효한 경우
                checkObj.memberEmail = true;
            } else {
                checkObj.memberEmail = false;
            }

        })

        let authTimer;
        let authMin = 4;
        let authSec = 59;
        let tempEmail;

        sendAuthKeyBtn.addEventListener("click", function(){

        authMin = 4;
        authSec = 59;
        checkObj.emailCheck = false;

        if(checkObj.memberEmail){


            /* fetch() API 방식 ajax */
            fetch("/sendEmail/signUp?email="+memberEmail.value)
            .then(resp => resp.text()) 
            .then(result => {
                if(result > 0){
                    console.log("인증 번호가 발송되었습니다.")
                    tempEmail = memberEmail.value;
                }else{
                    console.log("인증번호 발송 실패")
                }
            })
            .catch(err => {
                console.log("이메일 발송 중 에러 발생");
                console.log(err);
            });
        
            alert("인증번호가 발송 되었습니다.");


            clearInterval(authTimer); // 기존 타이머 삭제

            authTimer = window.setInterval(()=>{

                // 남은 시간이 0분 0초인 경우
                if(authMin == 0 && authSec == 0){
                    checkObj.emailAuthKey = false;
                    clearInterval(authTimer);
                    return;
                }

                // 0초인 경우
                if(authSec == 0){
                    authSec = 60;
                    authMin--;
                }

                authSec--; // 1초 감소


            }, 1000)


        } else{
            alert("유효한 이메일을 작성해주세요.");
            memberEmail.focus();
        }


        });

        checkAuthKeyBtn.addEventListener("click", function(){
            if(authMin > 0 || authSec > 0){ // 시간 제한이 지나지 않은 경우에만 인증번호 검사 진행
                /* fetch API */
                const obj = {"inputKey":emailCheck.value, "email":tempEmail}
                const query = new URLSearchParams(obj).toString()
                
                fetch("/sendEmail/checkAuthKey?" + query)
                .then(resp => resp.text())
                .then(result => {
                    if(result > 0){
                        clearInterval(authTimer);
                        alert("인증되었습니다.")
                        checkObj.emailCheck = true;


                    } else{
                        alert("인증번호가 일치하지 않습니다.")
                        checkObj.emailCheck = false;
                    }
                })
                .catch(err => console.log(err));




            } else{
                alert("인증 시간이 만료되었습니다. 다시 시도해주세요.")
            }


        });

        document.getElementById("findIdFrm").addEventListener("submit", function(e) {
            let message = "";
            for (let key in checkObj) {
                if (!checkObj[key]) {
                    switch (key) {
                        case "memberName": message = "이름이"; break;
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
        })
    </script>
    
</body>
</html>