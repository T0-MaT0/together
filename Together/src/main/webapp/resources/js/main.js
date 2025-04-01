

function updateProgressFromDivs() {
    const progressBars = document.querySelectorAll(".progress-bar");
    const progressPercents = document.querySelectorAll(".progress-percent");

    progressBars.forEach((progressBar, index) => {
        if (progressPercents[index]) { // 진행률 값이 존재하는 경우만 실행
            const percent = parseInt(progressPercents[index].textContent.trim(), 10);

            if (!isNaN(percent) && percent >= 0) {
                progressBar.style.width = percent + "%";
                
                // 색상 변경
                if (percent < 50) {
                    progressBar.style.backgroundColor = "green";
                } else if (percent < 75) {
                    progressBar.style.backgroundColor = "yellow";
                } else if (percent <= 100) {
                    progressBar.style.backgroundColor = "red";
                } else {
                    progressBar.style.backgroundColor = "pink";
                }
            }
        }
    });
}


/* // 최신 상품 목록 렌더링
function renderRecruitmentList() {
    const grid = document.querySelector(".product-list");
    grid.innerHTML = "";

    // 남은 시간 계산 함수
    function getTimeRemaining(endStr) {
        const now = new Date();
        const endDate = new Date(endStr);

        const diffMs = endDate - now;

        if (diffMs <= 0) return "마감됨";

        const diffHours = Math.floor(diffMs / (1000 * 60 * 60));
        const days = Math.floor(diffHours / 24);
        const hours = diffHours % 24;

        return `${days}일 ${hours}시간 남음`;
    }

    // recruitmentData 배열 전체 반복
    recruitmentData.forEach((recruitment) => {
        const progress = (recruitment.currentParticipants / recruitment.maxParticipants) * 100;
        const discount = Math.ceil(recruitment.productPrice / recruitment.maxParticipants);
        const time = getTimeRemaining(recruitment.recEndDate);

        grid.innerHTML += `
            <div class="product">
                <img src="${recruitment.thumbnail != null ? recruitment.thumbnail : '/resources/images/mypage/관리자 프로필.webp'}" alt="공구 세트">
                <p class="product-name">${recruitment.productName}</p>
                <span class="prior-price">${recruitment.productPrice}원</span>
                <span class="real-price"> → ${discount}</span>

                <p class="deadline">⏳ ${time}</p>
                <div class="progress">
                    <div class="progress-container">
                        <div class="progress-bar"></div>
                    </div>
                    <p class="progress-percent">${progress.toFixed(1)}%</p>
                </div>
                <p class="participants">${recruitment.currentParticipants} / ${recruitment.maxParticipants}명 참여 중</p>
            </div>
        `;
    });

    // 렌더 후 진행률 바 너비 채우기
    updateProgressFromDivs();
}
 */



// 페이지 로드 후 실행
updateProgressFromDivs();



document.addEventListener("DOMContentLoaded", function () {



    const image = document.getElementById("process-image");
    const textBlocks = document.querySelectorAll(".info-text");

    let currentImage = "";

    const changeImage = (newSrc) => {
        if (image.src.includes(newSrc)) return;

        image.classList.add("fade-out");

        setTimeout(() => {
            image.src = newSrc;
            image.classList.remove("fade-out");
        }, 200);
    };

    window.addEventListener("scroll", () => {
        for (let i = 0; i < textBlocks.length; i++) {
            const block = textBlocks[i];
            const rect = block.getBoundingClientRect();

            if (
                rect.top < window.innerHeight * 0.65 &&
                rect.bottom > 0
            ) {
                const newSrc = block.getAttribute("data-img");
                if (newSrc !== currentImage) {
                    changeImage(newSrc);
                    currentImage = newSrc;
                }
                break;
            }
        }
    });

    const images = document.querySelectorAll(".carousel-image");
    let currentIndex = 0;
    const prevBtn = document.querySelector(".carousel-button.prev");
    const nextBtn = document.querySelector(".carousel-button.next");
    let interval;

    function showImage(index) {
        images.forEach(img => img.classList.remove("active"));
        images[index]?.classList.add("active");
    }

    function nextImage() {
        currentIndex = (currentIndex + 1) % images.length;
        showImage(currentIndex);
    }

    function prevImage() {
        currentIndex = (currentIndex - 1 + images.length) % images.length;
        showImage(currentIndex);
    }

    function startAutoSlide() {
        interval = setInterval(nextImage, 5000);
    }

    function resetAutoSlide() {
        clearInterval(interval);
        startAutoSlide();
    }

    // 초기화
    showImage(currentIndex);
    startAutoSlide();

    // 버튼 이벤트
    nextBtn?.addEventListener("click", () => {
        nextImage();
        resetAutoSlide();
    });

    prevBtn?.addEventListener("click", () => {
        prevImage();
        resetAutoSlide();
    });

    const recruitBtn = document.getElementById("btn-recruit");

    if (recruitBtn) {
        recruitBtn.addEventListener("click", function (e) {
            e.preventDefault();

            const width = 930;
            const height = 700;
            const left = (window.screen.width / 2) - (width / 2);
            const top = (window.screen.height / 2) - (height / 2);
            const options = `width=${width},height=${height},left=${left},top=${top},resizable=no,scrollbars=yes`;

            const popup = window.open("/group/create", "groupCreatePopup", options);

            if (!popup || popup.closed || typeof popup.closed === "undefined") {
                alert("팝업이 차단되었습니다. 브라우저 설정을 확인해주세요.");
            }
        });
    }

});
