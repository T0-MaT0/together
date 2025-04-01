
  document.querySelector("#faq-list-body").addEventListener("click", function (e) {
    const questionRow = e.target.closest("tr");
    if (!questionRow || questionRow.classList.contains("answer-style")) return;
  
    const answerRow = questionRow.nextElementSibling;
    if (answerRow && answerRow.classList.contains("answer-style")) {
      answerRow.classList.toggle("hidden-answer");
    }
  });
  
  document.addEventListener("DOMContentLoaded", function () {
    const faqButtons = document.querySelectorAll(".faq-btn");
    const tbody = document.querySelector("#faq-list-body");
    const paginationArea = document.querySelector("#faq-pagination");
  
    let currentBoardCode = 0;
  
    // 📌 카테고리 버튼 클릭
    faqButtons.forEach(btn => {
      btn.addEventListener("click", function () {
        currentBoardCode = this.dataset.code;
  
        // 포커스 스타일 업데이트
        faqButtons.forEach(b => b.classList.remove("current-focus"));
        this.classList.add("current-focus");
  
        loadFAQList(currentBoardCode, 1);
        loadFAQPagination(currentBoardCode, 1);
      });
    });
  
    // 📌 페이지네이션 클릭 (이벤트 위임)
    document.addEventListener("click", function (e) {
        const target = e.target.closest("#faq-pagination a");
        if (target) {
          const isSearchPage = window.location.pathname.includes("/search");
      
          // ✅ 검색 모드에서는 기본 링크로 이동 (비동기 막음)
          if (isSearchPage) return;
      
          e.preventDefault();
          const cpMatch = target.href.match(/cp=(\d+)/);
          const cp = cpMatch ? cpMatch[1] : 1;
      
          loadFAQList(currentBoardCode, cp);
          loadFAQPagination(currentBoardCode, cp);
        }
      });
      
  
    // 📌 FAQ 리스트 비동기 로딩
    function loadFAQList(boardCode, cp) {
      fetch(`/customer/FAQBoard/${boardCode}/fragment/list?cp=${cp}`)
        .then(res => res.text())
        .then(html => {
          tbody.innerHTML = html;
  
        })
        .catch(err => console.error("FAQ 리스트 로딩 실패", err));
    }
  
    // 📌 페이지네이션 비동기 로딩
    function loadFAQPagination(boardCode, cp) {
      fetch(`/customer/FAQBoard/${boardCode}/fragment/page?cp=${cp}`)
        .then(res => res.text())
        .then(html => {
          paginationArea.innerHTML = html;
        })
        .catch(err => console.error("FAQ 페이지네이션 로딩 실패", err));
    }
  });


  function editFAQ(boardNo) {
    // 예: 수정 페이지로 이동
    location.href = `/customer2/4/${boardNo}/update`;
  }
  
  function deleteFAQ(boardNo) {
    if (confirm("정말 삭제하시겠습니까?")) {
      // GET 방식으로 요청
      location.href = `/customer2/4/${boardNo}/delete`;
    }
  }