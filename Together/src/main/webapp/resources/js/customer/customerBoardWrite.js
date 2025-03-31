console.log("CustomerBoardWrite 연결");

const boardTitle = document.getElementsByName("boardTitle")[0];
const boardContent = document.getElementsByName("boardContent")[0];
const boardWriteFrm = document.getElementById("boardWriteFrm");
const checkPw = document.getElementById("check-pw");

// 1:1 문의 작성인 경우에만 캡차 요소 가져오기
const captchaImg = document.querySelector("#captcha-img");
const reloadBtn = document.querySelector("#reload");
const captchaInput = document.querySelector(".check-captcha-code");

// 캡차 이미지 로드 및 새로고침
if (captchaImg) {
  captchaImg.src = "/captcha?" + new Date().getTime(); // 최초 로딩 시

  reloadBtn?.addEventListener("click", (e) => {
    e.preventDefault();
    captchaImg.src = "/captcha?" + new Date().getTime(); // 새로고침 시
  });
}

// 게시글 등록 시 유효성 검사 및 서버 확인
boardWriteFrm.addEventListener("submit", async e => {
  e.preventDefault(); // 항상 가장 먼저 막아줌



  /* const boardCd = document.getElementById("boardCd");

if (boardCd) {
  const selectedValue = boardCd.options[boardCd.selectedIndex].value;
  const selectedIndex = boardCd.selectedIndex;

  console.log("선택된 인덱스:", selectedIndex);
  console.log("선택된 값:", selectedValue);

  if (!selectedValue || selectedValue.trim() === "" || selectedIndex === 0) {
    alert("문의 종류를 선택해주세요.");
    boardCd.focus();
    return;
  }
} 셀렉트 검사 안됨........*/

  // 제목 검사
  if (boardTitle.value.trim().length === 0) {
    alert("제목을 입력해주세요.");
    boardTitle.focus();
    boardTitle.value = "";
    return;
  }

  // 내용 검사
  if (boardContent.value.trim().length === 0) {
    alert("내용을 입력해주세요.");
    boardContent.focus();
    boardContent.value = "";
    return;
  }

  // 비밀번호 검사
  if (checkPw.value.trim().length === 0) {
    alert("비밀번호를 입력해주세요.");
    checkPw.focus();
    checkPw.value = "";
    return;
  }



  // [추가] 캡차 검사 (1:1 문의일 때만 실행)
  if (captchaInput) {
    const userInput = captchaInput.value.trim();

    try {
      const res = await fetch("/getCaptchaValue");
      const serverCaptcha = await res.text();

      if (userInput !== serverCaptcha) {
        alert("보안문자가 일치하지 않습니다.");
        captchaInput.focus();
        captchaImg.src = "/captcha?" + new Date().getTime(); // 이미지 갱신
        return;
      }
    } catch (err) {
      console.error("캡차 확인 오류:", err);
      alert("보안문자 확인 중 오류가 발생했습니다.");
      return;
    }
  }

  // AJAX 비밀번호 확인
  try {
    const response = await fetch("/member/checkPw", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        "memberNo": memberNo,
        "memberPw": checkPw.value
      })
    });

    const result = await response.text();

    if (result === "0") {
      alert("비밀번호가 일치하지 않습니다.");
      checkPw.focus();
      return;
    }

    // 모든 조건 만족 → submit
    boardWriteFrm.submit();

  } catch (err) {
    console.error("비밀번호 확인 중 오류:", err);
    alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
  }
});

const preview = document.getElementsByClassName("preview");
const inputImage = document.getElementsByClassName("inputImage");
const deleteImage = document.getElementsByClassName("delete-image");

for (let i = 0; i < preview.length; i++) {
  inputImage[i].addEventListener("change", e => {
    const file = e.target.files[0];
    if (file != undefined) {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function (e) {
        preview[i].setAttribute("src", e.target.result);
      };
    } else {
      preview[i].removeAttribute('src');
      inputImage[i].value = '';
    }
  });

  deleteImage[i].addEventListener("click", e => {
    if (preview[i].getAttribute("src") != '') {
      preview[i].removeAttribute("src");
      inputImage[i].value = '';
    }
  });
}
