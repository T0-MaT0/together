(function(){
    const goToListBtn = document.getElementById("go-to-list");
  
    if(goToListBtn != null){
      goToListBtn.addEventListener("click", () => {
        const urlObj = new URL(location.href);
        const params = urlObj.searchParams;
  
        let basePath;
  
        //  query 파라미터가 있으면 검색 결과 페이지로 이동
        if(params.get("query")) {
          basePath = "/customer/notice/search";
        } else {
          basePath = "/customer/noticeBoardList";
        }
  
        const url = location.origin + basePath + location.search;
  
        console.log("🔁 목록으로 URL:", url);
  
        location.href = url;
      });
    }
  })();
  