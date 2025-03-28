console.log("boardUpdate 연결");

const boardTitle = document.getElementsByName("boardTitle")[0];
const boardContent = document.getElementsByName("boardContent")[0];
const boardUpdateFrm = document.getElementById("boardUpdateFrm");
const checkPw = document.getElementById("check-pw");

// 삭제된 이미지 순서 기록용
const deleteSet = new Set();

// 게시글 수정 시 유효성 + 비밀번호 + 이미지 처리
boardUpdateFrm.addEventListener("submit", async e => {
  e.preventDefault();

  // 제목 검사
  if (boardTitle.value.trim().length === 0) {
    alert("제목을 입력해주세요.");
    boardTitle.focus();
    return;
  }

  // 내용 검사
  if (boardContent.value.trim().length === 0) {
    alert("내용을 입력해주세요.");
    boardContent.focus();
    return;
  }

  // 비밀번호 검사
  if (checkPw && checkPw.value.trim().length === 0) {
    alert("비밀번호를 입력해주세요.");
    checkPw.focus();
    return;
  }

  // 서버 비밀번호 확인 요청
  if (checkPw) {
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

    } catch (err) {
      console.error("비밀번호 확인 중 오류:", err);
      alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
      return;
    }
  }

  // 삭제된 이미지 순서 반영
  document.getElementsByName("deleteList")[0].value = Array.from(deleteSet).join(",");

  // 모든 검사를 통과했으면 폼 제출
  boardUpdateFrm.submit();
});

// 이미지 미리보기 처리
const preview = document.getElementsByClassName("preview");
const inputImage = document.getElementsByClassName("inputImage");
const deleteImage = document.getElementsByClassName("delete-image");

for (let i = 0; i < preview.length; i++) {
  inputImage[i].addEventListener("change", e => {
    const file = e.target.files[0];
    if (file !== undefined) {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function (e) {
        preview[i].setAttribute("src", e.target.result);
      };
    } else {
      preview[i].removeAttribute("src");
      inputImage[i].value = '';
    }
  });

  deleteImage[i].addEventListener("click", e => {
    if (preview[i].getAttribute("src")) {
      preview[i].removeAttribute("src");
      inputImage[i].value = '';
      deleteSet.add(i); // 삭제된 이미지 순서 저장
    }
  });
}
