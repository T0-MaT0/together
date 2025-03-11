console.log('signUp.js')

const checkObj = {
    "memberId" : false,
    "memberPw": false,
    "memberPwConfirm": false,
    "memberName" : false,
    "memberBirth" : false,
    "memberEmail": false,
    "memberNickname": false,
    "memberTel": false,
    "authKey" : false
};




// 아이디 유효성 검사
const memberId = document.getElementById("memberId");
const idMessage = document.getElementById("idMessage");

// 아이디 입력 시 처리
memberId.addEventListener("input", function () {
    // 아이디 미 작성시
    if (memberId.value.trim().length == 0) {
        idMessage.classList.remove("confirm", "error");
        idMessage.innerText ="";
        checkObj.memberId = false;
        return;
    }

    // 아이디 정규식
    const reqExp = /^[a-zA-Z0-9]{6,16}$/;

    // 아이디 유효한 경우
    if (reqExp.test(memberId.value)) {
        checkObj.memberId = true;
        idMessage.innerText = "유효한 아이디 형식입니다.";
        idMessage.classList.add("confirm");
        idMessage.classList.remove("error");

    } else {
        checkObj.memberId = false;
        idMessage.innerText = "유효하지 않는 아이디 형식입니다.";
        idMessage.classList.add("error");
        idMessage.classList.remove("confirm");
    }
});

// 비밀번호/비밀번호 확인 유효성 검사
const memberPw = document.getElementById("memberPw");
const memberPwConfirm = document.getElementById("memberPwConfirm");
const pwMessage = document.getElementById("pwMessage");

// 비밀번호 입력 시 처리
memberPw.addEventListener("input", function () {
    // 비밀번호 미 작성시
    if (memberPw.value.trim().length == 0) {
        pwMessage.classList.remove("confirm", "error");
        pwMessage.innerText = "";
        checkObj.memberPw = false;
        return;
    }

    // 비밀번호 정규식
    const reqExp = /^[\w!@#\-\_]{6,20}$/;

    // 비밀번호 유효한 경우
    if (reqExp.test(memberPw.value)) {
        checkObj.memberPw = true;

        // 비밀번호가 유효하게 작성된 상태에서
        // 비밀번호 확인이 입력되지 않았을때
        if(memberPwConfirm.value.trim() == ""){
            pwMessage.innerText = "유효한 비밀번호 형식입니다.";
            pwMessage.classList.add("confirm");
            pwMessage.classList.remove("error");

        } else { // 비밀번호 확인이 입력되었을 때

            if (memberPw.value === memberPwConfirm.value) {
                pwMessage.innerText = "비밀번호가 일치합니다.";
                checkObj.memberPwConfirm = true;
                pwMessage.classList.add("confirm");
                pwMessage.classList.remove("error");
            } else {
                pwMessage.innerText = "비밀번호가 일치하지 않습니다.";
                checkObj.memberPwConfirm = false;
                pwMessage.classList.add("error");
                pwMessage.classList.remove("confirm");
            }

        }

    } else {
        pwMessage.innerText = "유효하지 않는 비밀번호 형식입니다.";
        checkObj.memberPw = false;
        pwMessage.classList.add("error");
        pwMessage.classList.remove("confirm");
    }
});



// 비밀번호 확인 유효성 검사
memberPwConfirm.addEventListener("input", ()=>{

    // 비밀번호가 유효하게 작성된 경우
    if(checkObj.memberPw){

        if (memberPw.value === memberPwConfirm.value) {
            pwMessage.innerText = "비밀번호가 일치합니다.";
            checkObj.memberPwConfirm = true;
            pwMessage.classList.add("confirm");
            pwMessage.classList.remove("error");
        } else {
            pwMessage.innerText = "비밀번호가 일치하지 않습니다.";
            checkObj.memberPwConfirm = false;
            pwMessage.classList.add("error");
            pwMessage.classList.remove("confirm");
        }

    } else { // 비밀번호가 유효하지 않은 경우
        checkObj.memberPwConfirm = false;

    }

})

const memberBirth = document.getElementById("memberBirth");
const birthMessage = document.getElementById("birthMessage");

// 생년월일 확인
memberBirth.addEventListener("input", function () {

    // 생년월일 미 작성시
    if (memberBirth.value.trim().length == 0) {
        checkObj.memberBirth = false;
        birthMessage.innerText = "";
        birthMessage.classList.remove("confirm", "error");
        return;
    }

    // 생년월일 정규식
    const reqExp = /^(19[0-9]{2}|20[0-9]{2})(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])$/;

    // 생년월일이 유효하게 작성된 경우
    if (reqExp.test(memberBirth.value)) {
        birthMessage.innerText = "생년월일이 유효합니다.";
        checkObj.memberBirth = true;
        birthMessage.classList.add("confirm");
        birthMessage.classList.remove("error");
    } else {
        birthMessage.innerText = "생년월일이 유효하지 않습니다.";
        checkObj.memberBirth = false;
        birthMessage.classList.add("error");
        birthMessage.classList.remove("confirm");
    }

})









// 이메일 유효성 검사

const memberEmail = document.getElementById("memberEmail");
const emailMessage = document.getElementById("emailMessage");

memberEmail.addEventListener("input", function () {

    const reqExp = /^[A-Za-z\d\-\_]{4,}@\w+(\.\w+){1,3}$/;


    if(reqExp.test(memberEmail.value)){ // 이메일 유효한 경우

        /*****************************************************************/
        fetch("/dupCheck/email?email=" + memberEmail.value)
        .then(response => response.text()) // 응답 객체 -> 파싱(parsing, 데이터 형태 변환)
        .then(count => {
            if(count == 1){
                emailMessage.innerText = "이미 사용중인 이메일입니다."
                checkObj.memberEmail = false;
                emailMessage.classList.add("error");
                emailMessage.classList.remove("confirm");
            } 
            if(count == 0){
                emailMessage.innerText = "사용 가능한 이메일입니다."
                checkObj.memberEmail = true;
                emailMessage.classList.add("confirm");
                emailMessage.classList.remove("error");
            }

        })
        .catch( e => {console.log(e)})

        
        emailMessage.innerText = "유효한 형식입니다.";
        checkObj.memberEmail = true;
        emailMessage.classList.add("confirm");
        emailMessage.classList.remove("error");
    } else {
        emailMessage.innerText = "유효하지 않은 이메일 형식입니다.";
        checkObj.memberEmail = false;
        emailMessage.classList.add("error");
        emailMessage.classList.remove("confirm");
    }

})

// -----------------------------------------------------------------------------------
// 이메일 인증
// 인증번호 발송
const sendAuthKeyBtn = document.getElementById("sendAuthKeyBtn");
const authKeyMessage = document.getElementById("authKeyMessage");
let authTimer;
let authMin = 4;
let authSec = 59;


// 인증번호를 발송한 이메일 저장
let tempEmail;


sendAuthKeyBtn.addEventListener("click", function(){
    authMin = 4;
    authSec = 59;


    checkObj.authKey = false;


    if(checkObj.memberEmail){ // 중복이 아닌 이메일인 경우




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


       
        authKeyMessage.innerText = "05:00";
        authKeyMessage.classList.remove("confirm");

        clearInterval(authTimer); // 기존 타이머 삭제

        authTimer = window.setInterval(()=>{


            authKeyMessage.innerText = "0" + authMin + ":" + (authSec<10 ? "0" + authSec : authSec);
           
            // 남은 시간이 0분 0초인 경우
            if(authMin == 0 && authSec == 0){
                checkObj.authKey = false;
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
        alert("중복되지 않은 이메일을 작성해주세요.");
        memberEmail.focus();
    }


});




// 인증 확인
const authKey = document.getElementById("authKey");
const checkAuthKeyBtn = document.getElementById("checkAuthKeyBtn");


checkAuthKeyBtn.addEventListener("click", function(){


    if(authMin > 0 || authSec > 0){ // 시간 제한이 지나지 않은 경우에만 인증번호 검사 진행
        /* fetch API */
        const obj = {"inputKey":authKey.value, "email":tempEmail}
        const query = new URLSearchParams(obj).toString()
        
        fetch("/sendEmail/checkAuthKey?" + query)
        .then(resp => resp.text())
        .then(result => {
            if(result > 0){
                clearInterval(authTimer);
                authKeyMessage.innerText = "인증되었습니다.";
                authKeyMessage.classList.add("confirm");
                checkObj.authKey = true;


            } else{
                alert("인증번호가 일치하지 않습니다.")
                checkObj.authKey = false;
            }
        })
        .catch(err => console.log(err));




    } else{
        alert("인증 시간이 만료되었습니다. 다시 시도해주세요.")
    }


});

// -----------------------------------------------------------------------------------














const memberNickname = document.getElementById("memberNickname");
const nickMessage = document.getElementById("nickMessage");

memberNickname.addEventListener("input", function () {

    // 닉네임 미 작성시
    if (memberNickname.value.trim().length == 0) {
        nickMessage.classList.remove("confirm", "error");
        nickMessage.innerText = "영어/숫자/한글 2~10글자 사이로 작성해주세요.";
        checkObj.memberNickname = false;
        return;
    }

    // 닉네임 정규식
    const reqExp = /^[\d\w가-힣]{2,10}$/;

    if(reqExp.test(memberNickname.value)){

        fetch("/dupCheck/nickname?nickname=" + memberNickname.value)
        .then(response => response.text()) // 응답 객체 -> 파싱(parsing, 데이터 형태 변환)
        .then(count => {
            if(count == 1){
                nickMessage.innerText = "이미 사용중인 닉네임입니다."
                checkObj.memberNickname = false;
                nickMessage.classList.add("error");
                nickMessage.classList.remove("confirm");
            } 
            if(count == 0){
                nickMessage.innerText = "사용 가능한 닉네임입니다."
                checkObj.memberNickname = true;
                nickMessage.classList.add("confirm");
                nickMessage.classList.remove("error");
            }

        })
        .catch( e => {console.log(e)})




        nickMessage.innerText = "유효한 닉네임 형식입니다.";
        checkObj.memberNickname = true;
        nickMessage.classList.remove("error");
    } else {
        nickMessage.innerText = "유효하지 않은 닉네임 형식입니다.";
        checkObj.memberNickname = false;
        nickMessage.classList.add("error");
        nickMessage.classList.remove("confirm");
    }

})

// 전화번호 유효성 검사
const memberTel = document.getElementById("memberTel");
const telMessage = document.getElementById("telMessage");

memberTel.addEventListener("input", function () {
    // 전화번호 미 작성시
    if (memberTel.value.trim().length == 0) {
        telMessage.classList.remove("confirm", "error");
        telMessage.innerText = "전화번호를 입력해주세요. (- 제외)";
        checkObj.memberTel = false;
        return;
    }

    // 전화번호 정규식
    const reqExp = /^0(1[01]|2|[3-6][1-5]|70)\d{7,8}$/;

    // 전화번호가 유효한 경우 : 유효한 전화번호 형식입니다. 초록글씨

    if (reqExp.test(memberTel.value)) {
        telMessage.innerText = "유효한 전화번호 형식입니다.";
        checkObj.memberTel = true;
        telMessage.classList.add("confirm");
        telMessage.classList.remove("error");
    } else {
        telMessage.innerText = "유효하지 않는 전화번호 형식입니다.";
        checkObj.memberTel = false;
        telMessage.classList.add("error");
        telMessage.classList.remove("confirm");
    }


})


// 회원 가입 form 태그가 제출 되었을 때
const signUpFrm = document.getElementById("signUpFrm");

signUpFrm.addEventListener("submit", function(e) {

    // 이름 유무 검사
    const memberName = document.getElementById("memberName");
    if (memberName.value.trim().length === 0) {
        checkObj.memberName = false;
    } else {
        checkObj.memberName = true;
    }
    
    let message = "";
    // checkObj에 모든 value가 true인지 검사
    
    // 배열용 향상된 for문 (for ... of)
    // -> iterator(반복자) 속성을 지닌 배열, 유사 배열 사용 가능

    // 객체용 향상된 for문 (for ... in)
    // -> JS 객체가 가지고 있는 key를 순서대로 하나씩 꺼내는 반복문
    for (let key in checkObj) { 
        // 점 표기법(obj.property)을 사용하는 경우 속성 이름이 고정
        // 대괄호 표기법(obj["property"])을 사용하는 경우는 변수를 통해 동적으로 속성 이름을 지정 가능
        if (!checkObj[key]) {
            switch (key) {
                case "memberEmail": message = "이메일이"; break;
                case "memberPw": message = "비밀번호가"; break;
                case "memberPwConfirm": message = "비밀번호 확인이"; break;
                case "memberNickname": message = "닉네임이"; break;
                case "memberTel": message = "전화번호가"; break;
                case "authKey": message = "이메일 인증번호가"; break;
            }

            message += " 유효하지 않습니다.";
            alert(message); // 0000가 유효하지 않습니다. 알림창

            // 유효하지 않은 input 태그로 focus
            // -> key와 input의 id를 똑같이 지정
            document.getElementById(key).focus();
            // form 태그 기본 이벤트 제거
            e.preventDefault();
            return false; 

        }
    }
})