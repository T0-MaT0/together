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

// 상품 이미지 캐러셀
document.addEventListener("DOMContentLoaded", function () {
    const track = document.querySelector(".carousel-track");
    const items = document.querySelectorAll(".carousel-item");
    const totalSlides = items.length;
    let currentIndex = 1; // 첫 번째 실제 이미지에서 시작 (복제된 이미지 때문에 1부터 시작)
    
    // 첫 번째 & 마지막 이미지 복제하여 무한 루프 구현
    const firstClone = items[0].cloneNode(true);
    const lastClone = items[totalSlides - 1].cloneNode(true);
    
    track.appendChild(firstClone); // 마지막 뒤에 첫 번째 복제
    track.insertBefore(lastClone, items[0]); // 처음 앞에 마지막 복제
    
    const allSlides = document.querySelectorAll(".carousel-item"); // 복제 포함한 전체 리스트
    const totalSlidesWithClones = allSlides.length;
    
    // 초기 위치 설정 (첫 번째 실제 이미지가 중앙에 오도록)
    track.style.transform = `translateX(-${100}%)`;

    function moveSlide(direction) {
        currentIndex += direction;
        track.style.transition = "transform 0.5s ease-in-out";
        track.style.transform = `translateX(-${currentIndex * 100}%)`;

        // 마지막에서 첫 번째로 자연스럽게 이동
        if (currentIndex === totalSlidesWithClones - 1) {
            setTimeout(() => {
                track.style.transition = "none";
                currentIndex = 1;
                track.style.transform = `translateX(-${100}%)`;
            }, 500);
        }

        // 첫 번째에서 마지막으로 자연스럽게 이동
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

// 댓글 ajax
document.addEventListener("DOMContentLoaded", function () {
    const commentBtn = document.querySelector(".comment-btn");
    const commentInput = document.querySelector(".comment-input");
    const hiddenBoardNo = document.getElementById("boardNo");

    commentBtn.addEventListener("click", function () {
        const replyContent = commentInput.value.trim();
        const boardNo = parseInt(hiddenBoardNo.value, 10); // 숫자로 변환

        if (!replyContent) {
            alert("댓글을 입력해주세요.");
            return;
        }

        fetch("/reply/add", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                replyContent: replyContent,
                boardNo: boardNo
            }),
        })
        .then(response => response.text())
        .then(result => {
            if (result === "success") {
                alert("댓글이 등록되었습니다.");
                location.reload();
            } else if (result === "fail") {
                alert("댓글 등록 실패");
            } else {
                alert(result); // "로그인이 필요합니다." 등
            }
        })
        .catch(error => console.error("Error:", error));
    });
});
    
    
// 댓글 삭제
function deleteReply(replyNo) {
    if (!confirm("정말로 댓글을 삭제하시겠습니까?")) {
        return;
    }
    
    fetch("/reply/delete", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ replyNo: replyNo })
    })
    .then(response => response.text())
    .then(result => {
        if (result === "success") {
            alert("댓글이 삭제되었습니다.");
            const replyElement = document.getElementById(`reply-${replyNo}`);
            if (replyElement) {
                replyElement.remove(); 
            }
        } else if (result === "loginNeeded") {
            alert("로그인이 필요합니다.");
        } else {
            alert("댓글 삭제 실패");
        }
    })
    .catch(error => console.error("Error:", error));
}

/* 수정 버튼 */
function openEditPopup(recruitmentNo, boardNo) {
    const width = 930;
    const height = 700;
    const left = (window.screen.width / 2) - (width / 2);
    const top = (window.screen.height / 2) - (height / 2);
    const options = `width=${width},height=${height},left=${left},top=${top},resizable=no,scrollbars=yes`;

    window.open(`/group/edit?recruitmentNo=${recruitmentNo}&boardNo=${boardNo}`, "groupEditPopup", options);
}