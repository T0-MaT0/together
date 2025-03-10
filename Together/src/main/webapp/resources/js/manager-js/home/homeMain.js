console.log("managerHome!");

const mainPageBtn = document.querySelector("#mainPageBtn");
const privatePageBtn = document.querySelector("#privatePageBtn");
const brandPageBtn = document.querySelector('#brandPageBtn');

/* 메인 페이지 관리 버튼 */
mainPageBtn.addEventListener("click", ()=>{
    
    location.href = "/manageHome/mainPage";
})

/* 개인 페이지 관리 버튼 */
privatePageBtn.addEventListener("click", ()=>{

    location.href = "/manageHome/privatePage";
})

/* 브랜드 페이지 관리 버튼 */
brandPageBtn.addEventListener("click", ()=>{

    location.href = "/manageHome/brandPage";
})