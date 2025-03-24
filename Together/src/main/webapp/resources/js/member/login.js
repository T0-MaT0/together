console.log('main.js');

/* const KaApiKey = KAKAO_API_KEY;
      //2. 카카오 초기화
      Kakao.init(KaApiKey);
      Kakao.isInitialized();
      //3. 카카오로그인 코드 확인
      function loginWithKakao() {
        Kakao.Auth.login({
          success: function (authObj) {
            console.log(authObj); //access토큰 값
            Kakao.Auth.setAccessToken(authObj.access_token); //access 토큰 값 저장
            getInfo();
          },
          fail: function (err) {
            console.log(err);
          },
        });
      }
      //4. 엑세스 토큰을 발급받고, 아래 함수를 호출시켜 사용자 정보 받아옴.
      function getInfo() {
        Kakao.API.request({
          url: "/v2/user/me",
          success: function (res) {
            console.log(res);
            var id = res.id;
            var profile_nickname = res.kakao_account.profile.nickname;
            localStorage.setItem("nickname", profile_nickname);
            localStorage.setItem("id", id);
            console.log(profile_nickname);
            console.log(id);
          },
          fail: function (error) {
            alert("카카오 로그인 실패" + JSON.stringify(error));
          },
        });
      }

      //5.로그아웃 기능 - 카카오 서버에 접속하는 액세스 토큰을 만료 시킨다.
      function kakaoLogOut() {
        if (!Kakao.Auth.getAccessToken()) {
          alert("로그인을 먼저 하세요.");
          return;
        }
        Kakao.Auth.logout(function () {
          alert("로그아웃" + Kakao.Auth.getAccessToken());
        });
      } */
document.addEventListener("DOMContentLoaded", function () {
    const memberTypes = document.querySelectorAll(".member-type");
    const authorityInput = document.getElementById("authority-input");
    const goToSignUp = document.getElementById("goToSignUp");
    const underLine = document.getElementById("underLine");
    const findId = document.getElementById("find-id");
    const findPw = document.getElementById("find-pw");

    console.log("findId: ", findId); 
    console.log("findPw: ", findPw); 
  
    
  
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
          goToSignUp.href = "/member/signUp1";
          findId.href = "/member/findId";
          findPw.href = "/member/findPw";
          underLine.classList.add("personal-line");
          underLine.classList.remove("company-line");
        } else if (selectedType === "company") {
          authorityInput.value = "3";
          goToSignUp.classList.add("company");
          goToSignUp.classList.remove("personal");
          goToSignUp.innerText ="기업 회원가입";
          goToSignUp.href = "/member/signUp2";
          findId.href = "/member/findId2";
          findPw.href = "/member/findPw2";
          underLine.classList.add("company-line");
          underLine.classList.remove("personal-line");

        }
      });
    });
  });


