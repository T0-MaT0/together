console.log("asdf");


//------------- 고객 상태 페이지


// 고객 목록 클릭
function customerState(memberNo){
    console.log(memberNo);
    location.href="customerProfile/0?memberNo="+memberNo;
}



/* 고객 프로필 게시판 조회 */
function boardList(boardCode){

    fetch(boardCode)
    .then()
    .then()
    .catch(err => console.log(err))
}

