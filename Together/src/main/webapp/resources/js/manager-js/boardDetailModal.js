
const recruitmentNo = 0;



// 모집글 화면
// 화면 실행 시 사용하는 이벤트 리스너
document.addEventListener('DOMContentLoaded', function () {
    console.log('모집글 화면이 로드되었습니다.');
    console.log(no);
    console.log(type);
    if(type == 2){
        console.log(url);
        location.href = `/partyRecruitmentList/${url}/${no}`;
    }
    /* if(type == 3){
        console.log('url');
        if(boardCode == 1){
            location.href = `/partyRecruitmentList/${url}/${no}`;
        }else{
            this.location.href = `/board/${boardCode}/${boardNo}`;
        }
    } */
    // screenSelect();
});


// function screenSelect(){

//     fetch('/manageCustomer/boardDetail/'+type+'?no='+no)
//         .then(resp => resp.json())
//         .then(data => {
//         console.log(data.url);
//             location.href = `/partyRecruitmentList/${data.url}/${no}`
//         })
//         .catch(err => console.error(err));
// }

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
