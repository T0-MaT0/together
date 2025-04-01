(function(){
  const goToListBtn = document.getElementById("go-to-list");

  if(goToListBtn != null){
    goToListBtn.addEventListener("click", () => {
      const urlObj = new URL(location.href);
      const params = urlObj.searchParams;

      let basePath;

      // HTML 내에 숨겨둔 boardCd 값을 가져옴
      const boardCd = document.getElementById("boardCd")?.value;

      // boardCd 값으로 목록 경로 분기
      if(boardCd == "6") {
        basePath = "/mypage/ask";
      } else {
        basePath = params.get("query") ? "/customer/notice/search" : "/customer/noticeBoardList";
      }

      const url = location.origin + basePath + location.search;
      location.href = url;
    });
  }
})();


function togglePin(boardNo, action) {
  if (action === 'pin') {
    fetch(`/customer2/pin-check`)
      .then(resp => resp.text())
      .then(count => {
        if (parseInt(count) >= 4) {
          alert("고정한 공지가 이미 4개 입니다. 다른 글의 고정을 해제하고 고정해주세요.");
        } else {
          location.href = `/customer2/pin/${boardNo}`;
        }
      })
      .catch(err => console.error("고정 체크 에러", err));
  }

  if (action === 'unpin') {
    location.href = `/customer2/unpin/${boardNo}`;
  }
}