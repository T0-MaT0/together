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
    const images = document.querySelectorAll(".carousel-image");
    const itemsPerSlide = 3;
    const totalItems = images.length;
    let currentIndex = 0;
    const maxIndex = Math.ceil(totalItems / itemsPerSlide) - 1; // 마지막 인덱스 계산

    function moveSlide(direction) {
        currentIndex += direction;

        // 🔹 무한 루프 설정
        if (currentIndex < 0) {
            currentIndex = maxIndex; // 왼쪽 끝에서 다시 마지막으로 이동
        } else if (currentIndex > maxIndex) {
            currentIndex = 0; // 오른쪽 끝에서 다시 처음으로 이동
        }

        const offset = -(currentIndex * 100) + "%";
        track.style.transform = `translateX(${offset})`;
    }

    window.moveSlide = moveSlide;
});