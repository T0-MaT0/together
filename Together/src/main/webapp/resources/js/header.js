const currentUrl = window.location.pathname; 
const navLinks = document.querySelectorAll(".sub-nav .left-links a");

navLinks.forEach(link => {
    if (link.getAttribute("href") === currentUrl) {
        link.classList.add("active"); 
    } else {
        link.classList.remove("active"); 
    }
});

document.addEventListener("DOMContentLoaded", function () {
    const recruitBtn = document.querySelector(".btn-recruit");
    
    if (recruitBtn) {
        recruitBtn.addEventListener("click", function () {
            // 팝업창 옵션(크기, 위치)을 지정
            const width = 930;
            const height = 700;
            
            // 화면 중앙에 팝업 위치시키기
            const left = (window.screen.width / 2) - (width / 2);
            const top = (window.screen.height / 2) - (height / 2);

            // 팝업창 옵션 문자열
            const windowFeatures = `width=${width},height=${height},left=${left},top=${top},resizable=no,scrollbars=yes`;

            // 팝업창 열기
            window.open("/group/create", "groupCreatePopup", windowFeatures);
        });
    }
});
