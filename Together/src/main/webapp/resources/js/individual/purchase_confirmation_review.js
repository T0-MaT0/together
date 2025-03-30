let selectedRating = 0;
const stars = document.querySelectorAll(".star-rating span");

// 클릭 이벤트
stars.forEach((star, index) => {
  star.addEventListener("click", () => {
    selectedRating = index + 1;
    updateStars(selectedRating);
  });

  // 마우스 오버 시 미리보기
  star.addEventListener("mouseover", () => {
    updateStars(index + 1);
  });

  // 마우스 아웃 시 다시 선택한 별로 유지
  star.addEventListener("mouseout", () => {
    updateStars(selectedRating);
  });
});

// 별 색 업데이트 함수
function updateStars(count) {
  stars.forEach((s, i) => {
    if (i < count) {
      s.classList.add("selected");
    } else {
      s.classList.remove("selected");
    }
  });
}

function submitReview() {
    const reviewContent = document.getElementById("reviewContent").value;

    if (selectedRating == 0) {
        alert("별점을 선택해주세요.");
        return;
    }

    if (reviewContent.trim() === "") {
        alert("후기를 입력해주세요.");
        return;
    }

    fetch("/review/write", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: `recruitmentNo=${recruitmentNo}&boardNo=${boardNo}&targetNo=${targetNo}&reviewContent=${encodeURIComponent(reviewContent)}&rating=${selectedRating}`
    })
    .then(response => response.text())
    .then(result => {
        if (result === "success") {
            alert("후기가 등록되었습니다!");
            window.opener.location.reload();
            window.close();
        } else {
            alert("후기 등록에 실패했습니다.");
        }
    })
    .catch(error => {
        console.error("에러 발생:", error);
        alert("서버 오류가 발생했습니다.");
    });
}