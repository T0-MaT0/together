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
        basePath = "/customer/askBoardList";
      } else {
        basePath = params.get("query") ? "/customer/notice/search" : "/customer/noticeBoardList";
      }

      const url = location.origin + basePath + location.search;
      console.log("🔁 목록으로 URL:", url);
      location.href = url;
    });
  }
})();
