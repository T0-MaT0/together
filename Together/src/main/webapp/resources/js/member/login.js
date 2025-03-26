console.log('login.js');

document.addEventListener("DOMContentLoaded", function () {
  const memberTypes = document.querySelectorAll(".member-type");
  const authorityInput = document.getElementById("authority-input");
  const goToSignUp = document.getElementById("goToSignUp");
  const underLine = document.getElementById("underLine");
  const findId = document.getElementById("find-id");
  const findPw = document.getElementById("find-pw");

  const loginForm = document.querySelector("#loginFrm");
  const captchaImg = document.querySelector("#captcha-img");
  const reloadBtn = document.querySelector("#reload");
  const captchaInput = document.querySelector(".check-captcha-code");

  const memberIdInput = document.querySelector("[name='memberId']");
  const memberPwInput = document.querySelector("[name='memberPw']");

  // URL 파라미터 읽기
  const urlParams = new URLSearchParams(window.location.search);
  const typeParam = urlParams.get("type");

  // 로그인 화면 로딩 시 기본 기업 회원 선택 처리
  if (typeParam === "company") {
    setTimeout(() => {
      const companyBtn = document.querySelector(".member-type[data-type='company']");
      if (companyBtn) companyBtn.click();
    }, 0); // 또는 100ms 줘도 되고
  }

  // 1. 캡차 이미지 최초 로딩
  if (captchaImg) {
    captchaImg.src = "/captcha?" + new Date().getTime(); // 캐시 방지
  }

  // 2. 새로고침 버튼 클릭 시 캡차 갱신
  if (reloadBtn && captchaImg) {
    reloadBtn.addEventListener("click", (e) => {
      e.preventDefault(); // form 전송 방지
      captchaImg.src = "/captcha?" + new Date().getTime();
    });
  }

  // 3. 로그인 폼 제출 시 캡차 검증 + 입력값 확인
  if (loginForm) {
    loginForm.addEventListener("submit", function (e) {
      e.preventDefault(); // 기본 제출 막기

      const memberId = memberIdInput.value.trim();
      const memberPw = memberPwInput.value.trim();
      //const userCaptcha = captchaInput.value.trim();

      // 아이디/비번 미입력 시
      if (memberId === "" || memberPw === "") {
        alert("아이디 또는 비밀번호를 입력해주세요.");
        if (memberId === "") memberIdInput.focus();
        else memberPwInput.focus();
        return;
      }

      // 서버의 캡차 값 가져오기
      // fetch("/getCaptchaValue")
      //   .then(res => res.text())
      //   .then(serverCaptcha => {
      //     if (userCaptcha.toLowerCase() !== serverCaptcha.toLowerCase()) {
      //       alert("보안문자가 일치하지 않습니다.");
      //       captchaImg.src = "/captcha?" + new Date().getTime(); // 이미지 갱신
      //       captchaInput.value = "";
      //       captchaInput.focus();
      //     } else {
      //       loginForm.submit(); // 검증 통과 시 로그인 진행
      //     }
      //   })
      //   .catch(err => {
      //     console.error("보안문자 확인 중 오류 발생", err);
      //     alert("보안문자 확인에 실패했습니다. 다시 시도해주세요.");
      //   });

      // 위에 주석풀면 지우기
      loginForm.submit();
    });
  }

  // 4. 회원 유형 선택
  memberTypes.forEach(type => {
    type.addEventListener("click", function () {
      memberTypes.forEach(t => t.classList.remove("font-bold"));
      this.classList.add("font-bold");

      const selectedType = this.dataset.type;

      if (selectedType === "personal") {
        authorityInput.value = "2";
        goToSignUp.classList.add("personal");
        goToSignUp.classList.remove("company");
        goToSignUp.innerText = "개인 회원가입";
        goToSignUp.href = "/member/signUp1";
        findId.href = "/member/findId";
        findPw.href = "/member/findPw";
        underLine.classList.add("personal-line");
        underLine.classList.remove("company-line");
      } else if (selectedType === "company") {
        authorityInput.value = "3";
        goToSignUp.classList.add("company");
        goToSignUp.classList.remove("personal");
        goToSignUp.innerText = "기업 회원가입";
        goToSignUp.href = "/member/signUp2";
        findId.href = "/member/findId2";
        findPw.href = "/member/findPw2";
        underLine.classList.add("company-line");
        underLine.classList.remove("personal-line");
      }
    });
  });
});
