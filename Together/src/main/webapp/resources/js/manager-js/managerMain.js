/* 메인 요청 주소 */

/* 고객 관리 */
const customerBtn = document.querySelector("#customerBtn");
// console.log('connect');

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

/* -------------------------------------------------------------------------------- */

/* 그래프 요일 조회*/
function graphWeek() {
    console.log('connect!!');
    fetch("graphWeek")
    .then(resp=>resp.json())
    .then(map=>{
        console.log(map.TODAY);

    })
}



/* 로딩 */
document.addEventListener("DOMContentLoaded", ()=>{})