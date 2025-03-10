console.log('main.js');

const loginFrm = document.getElementById("loginFrm");

const memberId = document.getElementsByName("memberId")[0];
const memberPw = document.getElementsByName("memberPw")[0];

if(loginFrm != null){
    // 로그인 시도를 할 때
    loginFrm.addEventListener("submit", e => {
        // 아이디가 입력되지 않은 경우
        if(memberId.value.trim() == ""){

            alert("아이디를 입력해주세요");
            e.preventDefault(); // 제출 못하게 막기
            memberId.focus(); // 아이디 input 태그에 초점 맞추기
            memberId.value = ""; // 잘못 입력된 값 제거
            return; 

        }
        // 비밀번호가 입력되지 않은 경우
        if(memberPw.value.trim().length == 0){

            alert("비밀번호를 입력해주세요");
            e.preventDefault(); // 제출 못하게 막기
            memberPw.focus(); // 비밀번호 input 태그에 초점 맞추기
            memberPw.value = ""; // 잘못 입력된 값 제거

    
        }

        
    })
}



