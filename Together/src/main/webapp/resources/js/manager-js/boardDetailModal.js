
const recruitmentNo = 0;



// 모집글 화면
// 화면 실행 시 사용하는 이벤트 리스너
document.addEventListener('DOMContentLoaded', function () {
    console.log('모집글 화면이 로드되었습니다.');
    console.log(no);
    console.log(type);
    if(type==1){
        location.href = `/board/2/${no}`;
       
    }
    if(type == 2){
        location.href = `/partyRecruitmentList/${no}/${recruitmentBoardNo}`;
         ///partyRecruitmentList/{recruitmentNo}/{boardNo}
    }
});



function replyDelete(replyNo) {
    fetch("/manageCustomer/replyDelete?replyNo="+replyNo)
    .then(response => response.json())
    .then(result => {
        if (result === 0) {
            alert("삭제를 실패하였습니다.");
        } else {
            alert("삭제를 성공하였습니다.");
            location.reload();
        }
    })
    .catch(err => console.log(err));
}


function reviewDelete(reviewNo){
    fetch("/manageCustomer/reviewDelete?reviewNo="+reviewNo)
    .then(response => response.json())
    .then(result => {
        if (result === 0) {
            alert("삭제를 실패하였습니다.");
        } else {
            alert("삭제를 성공하였습니다.");
            location.reload();
        }
    })
    .catch(err => console.log(err));
}
