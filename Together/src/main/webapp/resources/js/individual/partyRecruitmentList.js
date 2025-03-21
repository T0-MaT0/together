document.addEventListener("DOMContentLoaded", function () {
    const badges = document.querySelectorAll(".badge");

    badges.forEach(badge => {
        const status = badge.getAttribute("data-status");

        switch (status) {
            case "진행":
                badge.style.backgroundColor = "#FFD700"; // 노랑
                badge.style.color = "black";
                break;
            case "마감":
                badge.style.backgroundColor = "#800080"; // 보라
                badge.style.color = "white";
                break;
            case "완료":
                badge.style.backgroundColor = "#ff66b2"; // 핑크
                badge.style.color = "white";
                break;
            default:
                badge.style.backgroundColor = "#A9A9A9"; // 기본 회색
                badge.style.color = "white";
                break;
        }
    });


});


document.addEventListener("DOMContentLoaded", function () {
    const track = document.querySelector(".carousel-track");
    const items = document.querySelectorAll(".carousel-item");
    const totalSlides = items.length;
    let currentIndex = 1; // 첫 번째 실제 이미지에서 시작 (복제된 이미지 때문에 1부터 시작)
    
    // 🔹 첫 번째 & 마지막 이미지 복제하여 무한 루프 구현
    const firstClone = items[0].cloneNode(true);
    const lastClone = items[totalSlides - 1].cloneNode(true);
    
    track.appendChild(firstClone); // 마지막 뒤에 첫 번째 복제
    track.insertBefore(lastClone, items[0]); // 처음 앞에 마지막 복제
    
    const allSlides = document.querySelectorAll(".carousel-item"); // 복제 포함한 전체 리스트
    const totalSlidesWithClones = allSlides.length;
    
    // 🔹 초기 위치 설정 (첫 번째 실제 이미지가 중앙에 오도록)
    track.style.transform = `translateX(-${100}%)`;

    function moveSlide(direction) {
        currentIndex += direction;
        track.style.transition = "transform 0.5s ease-in-out";
        track.style.transform = `translateX(-${currentIndex * 100}%)`;

        // 🔹 마지막에서 첫 번째로 자연스럽게 이동
        if (currentIndex === totalSlidesWithClones - 1) {
            setTimeout(() => {
                track.style.transition = "none";
                currentIndex = 1;
                track.style.transform = `translateX(-${100}%)`;
            }, 500);
        }

        // 🔹 첫 번째에서 마지막으로 자연스럽게 이동
        if (currentIndex === 0) {
            setTimeout(() => {
                track.style.transition = "none";
                currentIndex = totalSlidesWithClones - 2;
                track.style.transform = `translateX(-${currentIndex * 100}%)`;
            }, 500);
        }
    }

    window.moveSlide = moveSlide;
});

document.addEventListener("DOMContentLoaded", function () {
    const commentBtn = document.querySelector(".comment-btn");
    const commentInput = document.querySelector(".comment-input");

    commentBtn.addEventListener("click", function () {
        const replyContent = commentInput.value.trim();
        if (replyContent === "") {
            alert("댓글을 입력해주세요.");
            return;
        }

        fetch("/reply/add", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                replyContent: replyContent,
                boardNo: boardNo // 현재 게시글 번호
            }),
        })
        .then(response => response.text())
        .then(result => {
            alert(result);
            location.reload(); // 댓글 등록 후 새로고침
        })
        .catch(error => console.error("Error:", error));
    });
});