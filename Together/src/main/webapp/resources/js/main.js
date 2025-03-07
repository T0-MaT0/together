function updateProgressFromDivs() {
    const progressBars = document.querySelectorAll(".progress-bar");
    const progressPercents = document.querySelectorAll(".progress-percent");

    progressBars.forEach((progressBar, index) => {
        if (progressPercents[index]) { // 진행률 값이 존재하는 경우만 실행
            const percent = parseInt(progressPercents[index].textContent.trim(), 10);

            if (!isNaN(percent) && percent >= 0 && percent <= 100) {
                progressBar.style.width = percent + "%";
                
                // 색상 변경
                if (percent < 50) {
                    progressBar.style.backgroundColor = "green";
                } else if (percent < 75) {
                    progressBar.style.backgroundColor = "yellow";
                } else {
                    progressBar.style.backgroundColor = "red";
                }
            }
        }
    });
}

// 페이지 로드 후 실행
updateProgressFromDivs();
