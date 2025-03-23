const modal = document.querySelector('#modal');
const clickList = document.getElementsByClassName("clickList");
const modalTop = document.querySelector(".modalTop"); 
const modalReport = document.querySelector(".modalReport"); 
const modalSubmit = document.querySelector("#modalSubmit"); 
const memberName = document.querySelector(".memberName"); 
const reportedName = document.querySelector(".reportedName"); 
const customerText = document.querySelector(".customerText"); 
const managerReportText = document.querySelector(".managerReportText"); 
const infoBtn = document.querySelector("#infoBtn"); 
const BoardBtn = document.querySelector("#BoardBtn"); 

const modalTitle = document.querySelector(".modalTitle");
const managerText = document.querySelector(".managerText");

let custBoardNo = 0;
let state = '';
let memberNo = 0;

// // 신고 화면
// function clickReport(reportNo){
//     console.log(reportNo);
//     modal.classList.add("modalActive");
    
//     fetch("reportDetail?reportNo="+reportNo)
//     .then(resp=>resp.json())
//     .then(reportDetail =>{
//         console.log(reportDetail);

//         modalReport.innerHTML = ` <strong>제목:</strong> ${reportDetail.reportTitle} (${reportDetail.reportTypeName})`;


//         if(reportDetail.reportStatus == '대기'){
//             modalSubmit.innerHTML=`   <option disabled selected>선택</option>
//                                                         <option>반려</option>
//                                                         <option>블랙</option>
//                                                         <option>경고</option>`
//         }

//         switch(reportDetail.reportStatus){
//             case "대기":
//                  modalSubmit.innerHTML=`   <option disabled selected>선택</option>
//                                                             <option>반려</option>
//                                                             <option>블랙</option>
//                                                             <option>경고</option>`; break;
//             case "반려":
//                 modalSubmit.innerHTML=`   <option disabled >선택</option>
//                                                         <option selected>반려</option>
//                                                         <option>블랙</option>
//                                                         <option>경고</option>`; break;
//             case "블랙":
//                 modalSubmit.innerHTML=`   <option disabled >선택</option>
//                                                         <option>반려</option>
//                                                         <option selected>블랙</option>
//                                                         <option>경고</option>`; break;
//             case "경고":
//                 modalSubmit.innerHTML=`   <option disabled >선택</option>
//                                                         <option >반려</option>
//                                                         <option>블랙</option>
//                                                         <option selected>경고</option>`; break;
//             case "처리 완료료":
//                 modalSubmit.innerHTML=`   <option disabled >선택</option>
//                                                         <option >반려</option>
//                                                         <option>블랙</option>
//                                                         <option selected>경고</option>`; break;
//         }


//         memberName.innerHTML=` <strong>신고자:</strong> ${reportDetail.memberNick} `;
//         reportedName.innerHTML=` <strong>신고 대상:</strong> ${reportDetail.reportedUserNick} `;
//         customerText.innerText = reportDetail.reportDetail;
//         infoBtn.innerText = reportDetail.reportedUserNick +" 정보 조회";
//         infoBtn.setAttribute("path", "/manageBrand/brandProfile/-1?boardNo="+reportNo);
//         managerReportText.value  = reportDetail.reply == null? '': reportDetail.reply;

//     })
//     .catch(err=>console.log(err))
// }

/* 모달 닫기 */
document.getElementsByClassName("close")[0].addEventListener("click", e=>{
    modal.classList.remove("modalActive");

    // modalReport.innerHTML = ``;

    // memberName.innerHTML=``;
    // if(reportedName != undefined){
    //     reportedName.innerHTML=``;
    // }
    customerText.innerText = '';

        managerText.innerText  = '';
})

// function goProfile(){
//     const clickBtn = infoBtn.getAttribute("path");
//     location.href = clickBtn;
// }



// 제휴 화면
function clickApply(boardNo){
    custBoardNo = boardNo;

    modal.classList.add("modalActive");
    console.log(boardNo);

    fetch("boardDetail/8?boardNo="+boardNo)
    .then(resp=>resp.json())
    .then(applyDetail =>{
        console.log(applyDetail);

        memberNo= applyDetail.memberNo;
        
        modalReport.innerHTML = ` <strong>제목:</strong> ${applyDetail.boardTitle}`;


        switch(applyDetail.state){
            case "대기":
                modalSubmit.innerHTML=`   <option disabled selected>선택</option>
                <option>승인</option>
                <option>거부</option>`; break;
            case "승인":
                modalSubmit.innerHTML=`   <option disabled >선택</option>
                <option selected>승인</option>
                <option >거부</option>`;
                modalSubmit.disabled = false;  break;
            case "거부":
                modalSubmit.innerHTML=`   <option disabled selected>선택</option>
                <option>승인</option>
                <option selected>거부</option>`; 
                modalSubmit.disabled = false; 
                break;
        }

        customerText.innerText = applyDetail.boardContent;
        memberName.innerHTML=` <strong>브랜드명:</strong> ${applyDetail.brandName} `;
        
        const submitBtn = document.querySelector(".modal-btn");
        submitBtn.innerHTML = '';
        
        if(applyDetail.state =='승인' || applyDetail.state =='거부'){
            managerText.setAttribute("contenteditable", "false");
            let beforeContent = applyDetail.reply == null ? '' : applyDetail.reply;

            beforeContent =  beforeContent.replaceAll("&amp;", "&");
            beforeContent =  beforeContent.replaceAll("&lt;", "<");
            beforeContent =  beforeContent.replaceAll("&gt;", ">");
            beforeContent =  beforeContent.replaceAll("&quot;", "\"");

            managerText.innerText = beforeContent;
        }else{
            managerText.innerText  = applyDetail.reply == null? '': applyDetail.reply;
            submitBtn.innerHTML = `<button onclick="submitReply()">제출</button>`;
        }
    })
}




// 광고 화면
function clickProm(boardNo){
    console.log(boardNo);
    modal.classList.add("modalActive");

    fetch("boardDetail/7?boardNo="+boardNo)
    .then(resp=>resp.json())
    .then(boardDetail =>{
        console.log(boardDetail);



        
        modalReport.innerHTML = ` <strong>제목:</strong> ${boardDetail.boardTitle}`;


        switch(boardDetail.state){
            case "대기":
                modalSubmit.innerHTML=`   <option disabled selected>선택</option>
                <option>승인</option>
                <option>거부</option>`; break;
            case "승인":
                modalSubmit.innerHTML=`   <option disabled >선택</option>
                <option selected>승인</option>
                <option >거부</option>`; break;
            case "거부":
                modalSubmit.innerHTML=`   <option disabled selected>선택</option>
                <option>승인</option>
                <option selected>거부</option>`; break;
        }

        memberName.innerHTML=` <strong>브랜드명:</strong> ${boardDetail.brandName} `;

    })
}



/* 브랜드 제출 */









// 고객 문의 화면
function customerQuest(boardNo){
    custBoardNo = boardNo;
    console.log(boardNo);
    modal.classList.add("modalActive");
    
    fetch("questDetail?boardNo="+boardNo)
    .then(resp=>resp.json())
    .then(questDetail =>{
        console.log(questDetail);
        
        
        
        modalTitle.innerHTML = ` <strong>제목:</strong> ${questDetail.boardTitle}`;
        
        customerText.innerText = questDetail.boardContent;
        memberName.innerHTML=` <strong>회원명:</strong> ${questDetail.memberNick} `;
        

        if(questDetail.boardDelFl =='N'){
            // managerText.style.display = "block";
            managerText.innerText  = questDetail.reply == null? '': questDetail.reply;
        }else{
            managerText.setAttribute("contenteditable", "false");
            let beforeContent = questDetail.reply == null ? '' : questDetail.reply;

            beforeContent =  beforeContent.replaceAll("&amp;", "&");
            beforeContent =  beforeContent.replaceAll("&lt;", "<");
            beforeContent =  beforeContent.replaceAll("&gt;", ">");
            beforeContent =  beforeContent.replaceAll("&quot;", "\"");

            managerText.innerText = beforeContent;
        }
        // 버튼 유무
        const submitBtn = document.querySelector(".modal-btn");
        if(questDetail.boardDelFl =='N'){
            submitBtn.innerHTML = `<button onclick="submitReply()">제출</button>`;
        }
        return;
    })


}


// // 고객 신고 화면
// function customerReport(reportNo){

//     console.log(reportNo);
//     modal.classList.add("modalActive");
//     fetch("reportDetail?reportNo="+reportNo)
//     .then(resp=>resp.json())
//     .then(reportDetail =>{
//         console.log(reportDetail);
        
//         modalReport.innerHTML = ` <strong>제목:</strong> ${reportDetail.reportTitle} (${reportDetail.reportTypeName})`;
        
        
        
        
//         switch(reportDetail.reportStatus){
//             case "대기":
//                  modalSubmit.innerHTML=`   <option disabled selected>선택</option>
//                                                             <option>반려</option>
//                                                             <option>블랙</option>
//                                                             <option>경고</option>`; break;
//             case "반려":
//                 modalSubmit.innerHTML=`   <option disabled >선택</option>
//                                                         <option selected>반려</option>
//                                                         <option>블랙</option>
//                                                         <option>경고</option>`; break;
//             case "블랙":
//                 modalSubmit.innerHTML=`   <option disabled >선택</option>
//                                                         <option>반려</option>
//                                                         <option selected>블랙</option>
//                                                         <option>경고</option>`; break;
//             case "경고":
//                 modalSubmit.innerHTML=`   <option disabled >선택</option>
//                                                         <option >반려</option>
//                                                         <option>블랙</option>
//                                                         <option selected>경고</option>`; break;
//             case "처리 완료료":
//                 modalSubmit.innerHTML=`   <option disabled >선택</option>
//                                                         <option >반려</option>
//                                                         <option>블랙</option>
//                                                         <option selected>경고</option>`; break;
//         }

//         memberName.innerHTML=` <strong>신고자:</strong> ${reportDetail.memberNick} `;
//         reportedName.innerHTML=` <strong>신고 대상:</strong> ${reportDetail.reportedUserNick} `;
//         customerText.innerText = reportDetail.reportDetail;
//         infoBtn.innerText = reportDetail.reportedUserNick +" 정보 조회";
//         infoBtn.setAttribute("path", "/manageBrand/brandProfile/-1?boardNo="+reportNo);
//         managerReportText.value  = reportDetail.reply == null? '': reportDetail.reply;
//         return;

//     })
//     .catch(err=>console.log(err))

// }



modalSubmit.addEventListener("change", function () {
    const selectedValue = modalSubmit.value;
    state = selectedValue;
    console.log("선택된 값:", state);

});



//  고객 제출 버튼
function submitReply(){
    console.log("제출");
    let data={};

    if(managerText.innerText.trim() == ""){
        alert("답변을 입력해주세요.");
        return;
    }
    
    
    if(state==""){

    console.log("고객 제출");
        data = {
            boardNo: custBoardNo,
            reply: managerText.innerText
        }
    
    }else{
        console.log("브랜드 제출");
         data = {
            boardNo: custBoardNo,
            state: state,
            reply: managerText.innerText,
            "memberNo": memberNo
        }
        
        if(state == ''){
            alert("상태를 설정해주세요.");
            return;
        }
    }

    fetch("submit",{
        method: "POST",
        headers: { 'Content-Type': 'application/json'},
        body: JSON.stringify(data)
    })
    .then( resp => resp.text())
    .then(result =>{
        if(result != 0){
            alert("성공적으로 제출 되었습니다.");
            // modal.classList.remove("modalActive");
           location.reload();
            // customerQuest(custBoardNo);
        }else{
            alert("제출 실패");
        }

    })
    .catch(err=>console.log(err))

}