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
document.addEventListener("DOMContentLoaded", function () {
    const memberTypes = document.querySelectorAll(".member-type");
    const authorityInput = document.getElementById("authority-input");
    const goToSignUp = document.getElementById("goToSignUp");
    const underLine = document.getElementById("underLine");
  
    
  
    memberTypes.forEach(type => {
      type.addEventListener("click", function () {
  
        memberTypes.forEach(t => t.classList.remove("font-bold"));
        this.classList.add("font-bold");
  
        const selectedType = this.dataset.type;
  
        if (selectedType === "personal") {
          authorityInput.value = "2";
          goToSignUp.classList.add("personal");
          goToSignUp.classList.remove("company");
          goToSignUp.innerText ="개인 회원가입";
          underLine.classList.add("personal-line");
          underLine.classList.remove("company-line");
        } else if (selectedType === "company") {
          authorityInput.value = "3";
          goToSignUp.classList.add("company");
          goToSignUp.classList.remove("personal");
          goToSignUp.innerText ="기업 회원가입";
          underLine.classList.add("company-line");
          underLine.classList.remove("personal-line");

        }
      });
    });
  });


