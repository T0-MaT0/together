/* const allFAQ = document.getElementById("allFAQ");
const memberFAQ = document.getElementById("memberFAQ");
const togetherFAQ = document.getElementById("togetherFAQ");
const buyFAQ = document.getElementById("buyFAQ");
const shipFAQ = document.getElementById("shipFAQ");
const memberguitarFAQFAQ = document.getElementById("guitarFAQ");
 */

function openAnswer(event) {
    const questionRow = event.target.closest("tr");
    const answerRow = questionRow.nextElementSibling;
  
    // hidden-answer 클래스 토글 (있으면 제거, 없으면 추가)
    answerRow.classList.toggle("hidden-answer");
  }

document.addEventListener("DOMContentLoaded", function () {
const faqButtons = document.querySelectorAll(".faq-btn");
const tbody = document.querySelector(".list-table tbody");

faqButtons.forEach(btn => {
    btn.addEventListener("click", function () {
    const boardCode = this.dataset.code;

    // current-focus 클래스 갱신
    faqButtons.forEach(b => b.classList.remove("current-focus"));
    this.classList.add("current-focus");

    // 비동기 요청으로 FAQ 리스트 가져오기
    fetch(`/customer/FAQBoard/${boardCode}/fragment`)
        .then(res => res.text())
        .then(html => {
        tbody.innerHTML = html;
        })
        .catch(err => {
        console.error("FAQ 로딩 실패", err);
        });
    });
});
});