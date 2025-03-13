console.log('signUp.js')

const checkObj = {
    "memberId" : false,
    "memberPw": false,
    "memberPwConfirm": false,
    "memberName" : false,
    "memberBirth" : false,
    "memberEmail": false,
    "emailAuthKey" : false,
    "memberNick": false,
    "memberTel": false,
    "memberAddr" : false,
    "agree" : false
};
//--------------------------------------------------------------------
// 아이디 유효성 검사
const memberId = document.getElementById("memberId");
const idMessage = document.getElementById("idMessage");

// 아이디 입력 시 처리
memberId.addEventListener("input", function () {
    // 아이디 미 작성시
    if (memberId.value.trim().length == 0) {
        idMessage.innerText ="";
        checkObj.memberId = false;
        return;
    }

    // 아이디 중복검사해야함

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
//--------------------------------------------------------------------
// 비밀번호/비밀번호 확인 유효성 검사
const memberPw = document.getElementById("memberPw");
const memberPwConfirm = document.getElementById("memberPwConfirm");
const pwMessage = document.getElementById("pwMessage");

// 비밀번호 입력 시 처리
memberPw.addEventListener("input", function () {
    // 비밀번호 미 작성시
    if (memberPw.value.trim().length == 0) {
        
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
// -----------------------------------------------------------------------
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
// -----------------------------------------------------------------------
// 이름 확인 유효성 검사
const memberName = document.getElementById("memberName");
memberName.addEventListener("input", ()=>{
    if (memberName.value.trim().length === 0) {
        checkObj.memberName = false;
    } else {
        checkObj.memberName = true;
    }
})
    
// -----------------------------------------------------------------------
const memberBirth = document.getElementById("memberBirth");
const birthMessage = document.getElementById("birthMessage");

// 생년월일 확인
memberBirth.addEventListener("input", function () {

    // 생년월일 미 작성시
    if (memberBirth.value.trim().length == 0) {
        checkObj.memberBirth = false;
        birthMessage.innerText = "";
        
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
// -----------------------------------------------------------------------
// 이메일 유효성 검사

const memberEmail = document.getElementById("memberEmail");
const emailMessage = document.getElementById("emailMessage");

memberEmail.addEventListener("input", function () {

    // 이메일 미 작성시
    if (memberEmail.value.trim().length == 0) {
        checkObj.memberEmail = false;
        emailMessage.innerText = "";
        
        return;
    }

    const reqExp = /^[A-Za-z\d\-\_]{4,}@\w+(\.\w+){1,3}$/;


    if(reqExp.test(memberEmail.value)){ // 이메일 유효한 경우

        

        /*****************************************************************/
        fetch("/dupCheck/email?email=" + memberEmail.value)
        .then(response => response.text())
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
    checkObj.emailAuthKey = false;

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
                checkObj.emailAuthKey = true;


            } else{
                alert("인증번호가 일치하지 않습니다.")
                checkObj.emailAuthKey = false;
            }
        })
        .catch(err => console.log(err));




    } else{
        alert("인증 시간이 만료되었습니다. 다시 시도해주세요.")
    }


});

// -----------------------------------------------------------------------------------
// 닉네임 확인 유효성 검사
const memberNick = document.getElementById("memberNick");
const nickMessage = document.getElementById("nickMessage");

memberNick.addEventListener("input", function () {

    // 닉네임 미 작성시
    if (memberNick.value.trim().length == 0) {
        
        nickMessage.innerText = "";
        checkObj.memberNick = false;
        return;
    }

    // 닉네임 정규식
    const reqExp = /^[A-Za-z0-9가-힣]{2,10}$/;

    if(reqExp.test(memberNick.value)){

        fetch("/dupCheck/nickname?nickname=" + memberNick.value)
        .then(response => response.text())
        .then(count => {
            if(count == 1){
                nickMessage.innerText = "이미 사용중인 닉네임입니다."
                checkObj.memberNick = false;
                nickMessage.classList.add("error");
                nickMessage.classList.remove("confirm");
            } 
            if(count == 0){
                nickMessage.innerText = "사용 가능한 닉네임입니다."
                checkObj.memberNick = true;
                nickMessage.classList.add("confirm");
                nickMessage.classList.remove("error");
            }

        })
        .catch( e => {console.log(e)})

    } else {
        nickMessage.innerText = "유효하지 않은 닉네임 형식입니다.";
        checkObj.memberNick = false;
        nickMessage.classList.add("error");
        nickMessage.classList.remove("confirm");
    }

})
// -----------------------------------------------------------------------
// 전화번호 유효성 검사
const memberTel = document.getElementById("memberTel");
const telMessage = document.getElementById("telMessage");

memberTel.addEventListener("input", function () {
    // 전화번호 미 작성시
    if (memberTel.value.trim().length == 0) {
        telMessage.innerText = "";
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

// 주소가 유효하지 않습니다까지 뜨고 폼이 넘어감
// 앞에 다 트루 나머지 false인데

// --------------------------------------------------------------------------
// 주소 유무 검사
const sample6_postcode = document.getElementById("sample6_postcode");
const sample6_address = document.getElementById("sample6_address");
const sample6_detailAddress = document.getElementById("sample6_detailAddress");
// 안들어있는거 뽑아내서 포커스할까 생각중
const noneAddr = "";

// 주소 입력값을 검사하는 함수
function validateAddressInputs() {
    if (
        sample6_postcode.value.trim().length != 0 &&
        sample6_address.value.trim().length != 0 &&
        sample6_detailAddress.value.trim().length != 0
    ) {
        checkObj.memberAddr = true;
    } else {
        checkObj.memberAddr = false;
    }
}

// 세 input 요소 모두에 이벤트 리스너 등록
sample6_postcode.addEventListener("input", validateAddressInputs);
sample6_address.addEventListener("input", validateAddressInputs);
sample6_detailAddress.addEventListener("input", validateAddressInputs);

// --------------------------------------------------------------------------



// 필수 체크박스 유무 검사
const useAgree = document.getElementById("use-agree");
const userdataPsAgree = document.getElementById("userdataPS-agree");

// 주소 입력값을 검사하는 함수
function validateAgreeInputs() {
    if (useAgree.checked && userdataPsAgree.checked) {
        checkObj.agree = true;
    } else {
        checkObj.agree = false;
    } 
}

useAgree.addEventListener("input", validateAgreeInputs);
userdataPsAgree.addEventListener("input", validateAgreeInputs);

// --------------------------------------------------------------------------

const signUpFrm = document.getElementById("signUpFrm");


signUpFrm.addEventListener("submit", function(e) {

    // 이메일 인증 상태 처리
    checkObj.emailAuthKey = true;  // 이 값을 true로 설정해야 합니다.
    // "checkObj"의 상태를 체크하는 부분 (반드시 "false"인 항목을 출력)
    let message = "";
    for (let item in checkObj) {
        alert(item + ": " + checkObj[item]); // 각 항목의 상태를 알림으로 출력
    }

    // 모든 필드를 확인하여 유효하지 않은 값이 있을 경우
    for (let key in checkObj) {
        if (!checkObj[key]) {
            switch (key) {
                case "memberId": message = "아이디가"; break;
                case "memberPw": message = "비밀번호가"; break;
                case "memberPwConfirm": message = "비밀번호 확인이"; break;
                case "memberName": message = "이름이"; break;
                case "memberBirth": message = "생년월일이"; break;
                case "memberEmail": message = "이메일이"; break;
                case "emailAuthKey": message = "이메일 인증번호가"; break;
                case "memberNick": message = "닉네임이"; break;
                case "memberTel": message = "전화번호가"; break;
                case "memberAddr": message = "주소가"; break;
                case "agree": message = "약관 동의가"; break;
            }
            message += " 유효하지 않습니다.";
            alert(message); // 유효하지 않은 항목에 대해 알림
            // memberAddress 찾지 못해서 아래 코드가 실행이 되지 않고
            // e.prevent도 실행이 안되서 폼이 제출됨!!

            if(key == "memberAddr"){
                document.getElementById("sample6_detailAddress").focus();
            } else if(key == "agree"){
                document.getElementById("all-agree").focus();
            } else {
                document.getElementById(key).focus();
            }
           
            e.preventDefault();
            return false; // 중단
        }
    }

});

/* // 회원 가입 form 태그가 제출 되었을 때

signUpFrm.addEventListener("submit", function(e) {

    // 이름 유무 검사
    const memberName = document.getElementById("memberName");
    if (memberName.value.trim().length === 0) {
        checkObj.memberName = false;
    } else {
        checkObj.memberName = true;
    }

    // 필수 체크 유무 검사
    const useAgree = document.getElementById("use-agree");
    const userdataPsAgree = document.getElementById("userdataPS-agree");

    if(useAgree.isChecked && userdataPsAgree.isChecked){
        checkObj.agree = true;
    } else{
        checkObj.agree = false;
    }

    // 임시로 true로 지정
    checkObj.emailAuthKey =true;

    // 주소 유무 검사
    const sample6_postcode = document.getElementById("sample6_postcode");
    const sample6_address = document.getElementById("sample6_address");
    const sample6_detailAddress = document.getElementById("sample6_detailAddress");

    if(sample6_postcode.trim().length != 0 
        && sample6_address.trim().length != 0 
        && sample6_detailAddress.trim().length != 0){
            checkObj.memberAddress = true;
        }else{
            checkObj.memberAddress = false;
        }

    
    let message = "";
    const authority = document.getElementById("authority-input");

    
    for (let key in checkObj) { 
       
        if (!checkObj[key]) {
            switch (key) {
                case "memberId": message = "아이디가"; break;
                case "memberPw": message = "비밀번호가"; break;
                case "memberPwConfirm": message = "비밀번호 확인이"; break;
                case "memberName": message = "이름이"; break;
                case "memberBirth": message = "생년월일이"; break;
                case "memberEmail": message = "이메일이"; break;
                case "emailAuthKey": message = "이메일 인증번호가"; break;
                case "memberNick": message = "닉네임이"; break;
                case "memberTel": message = "전화번호가"; break;
                case "memberAddress": message = "주소가"; break;
                case "agree": message = "약관 동의가"; break;
                
            }

            message += " 유효하지 않습니다.";
            alert(message); 

            document.getElementById(key).focus();

            e.preventDefault();
            return false; 

        }
    }

    if(authority.value == 3){
        for (let key in checkObjCompany) { 
           
            if (!checkObjCompany[key]) {
                switch (key) {
                    case "businessNo": message = "사업자 번호가"; break;
                    case "bankName": message = "은행이"; break;
                    case "bankNo": message = "계좌 번호가"; break;
                }
    
                message += " 유효하지 않습니다.";
                alert(message); 
    
                document.getElementById(key).focus();
    
                e.preventDefault();
                return false; 
    
            }

        }
    }
}) */