/* 고객 관리 */
const customerBtn = document.querySelector("#customerBtn");
console.log('connect');

customerBtn.addEventListener("click", ()=>{
    location.href = "customer";
})


/* 브랜드 관리 */
const brandBtn = document.querySelector("#brandBtn");

brandBtn.addEventListener("click", ()=>{
    location.href = "brand";
})


/* 홈페이지 관리 */
const homeBtn = document.querySelector("#homeBtn");

homeBtn.addEventListener("click", ()=>{
    location.href = "home";
})
