// 목록으로
(function(){
    const goToListBtn = document.getElementById("go-to-list");
    if(goToListBtn != null){
        goToListBtn.addEventListener("click", ()=>{
            
            // URL 내장 객체 : 주소 관련 정보를 나타내는 객체
            // URL.searchParams : 쿼리 스트링만 별도로 객체를 반환
            const params = new URL(location.href).searchParams;

            let url;


            url = location.origin+ "/customer/noticeBoardList" + location.search


            console.log(url);

            location.href = url;



    
        })
    }

})();