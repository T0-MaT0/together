console.log("managerHome!");

const mainPageBtn = document.querySelector("#mainPageBtn");
const privatePageBtn = document.querySelector("#privatePageBtn");
const brandPageBtn = document.querySelector('#brandPageBtn');

/* 메인 페이지 관리 버튼 */
mainPageBtn?.addEventListener("click", ()=>{
    
    location.href = "/manageHome/mainPage";
})

/* 개인 페이지 관리 버튼 */
privatePageBtn?.addEventListener("click", ()=>{

    location.href = "/manageHome/privatePage";
})

/* 브랜드 페이지 관리 버튼 */
brandPageBtn?.addEventListener("click", ()=>{

    location.href = "/manageHome/brandPage";
})


/* 홈페이지 이미지 편집 */
const bannerItems = document.getElementsByClassName("bannerItem");
const bannerInput = document.getElementsByTagName("input");

for (let i = 0; i < bannerItems.length; i++) {
    bannerItems[i].addEventListener("click", () => {
        bannerInput[i].click();
    });

    bannerInput[i].addEventListener("change", function () {
        const file = this.files[0]; 
        
        if (file) {
            console.log("파일 선택됨");
            const reader = new FileReader();

            reader.readAsDataURL(file);

            reader.onload = function (e) {
                bannerItems[i].setAttribute("src", e.target.result);
            };
        } else {
            console.log("파일 없음");
            bannerItems[i].removeAttribute("src");
            bannerInput[i].value = '';
        }
    });
}
