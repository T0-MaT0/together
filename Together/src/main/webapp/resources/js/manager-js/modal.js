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


// 신고 화면
function clickReport(reportNo){
    console.log(reportNo);
    modal.classList.add("modalActive");
    
    fetch("reportDetail?reportNo="+reportNo)
    .then(resp=>resp.json())
    .then(reportDetail =>{
        console.log(reportDetail);

        modalReport.innerHTML = ` <strong>제목:</strong> ${reportDetail.reportTitle} (${reportDetail.reportTypeName})`;


        if(reportDetail.reportStatus == '대기'){
            modalSubmit.innerHTML=`   <option disabled selected>선택</option>
                                                        <option>반려</option>
                                                        <option>블랙</option>
                                                        <option>경고</option>`
        }

        switch(reportDetail.reportStatus){
            case "대기":
                 modalSubmit.innerHTML=`   <option disabled selected>선택</option>
                                                            <option>반려</option>
                                                            <option>블랙</option>
                                                            <option>경고</option>`; break;
            case "반려":
                modalSubmit.innerHTML=`   <option disabled >선택</option>
                                                        <option selected>반려</option>
                                                        <option>블랙</option>
                                                        <option>경고</option>`; break;
            case "블랙":
                modalSubmit.innerHTML=`   <option disabled >선택</option>
                                                        <option>반려</option>
                                                        <option selected>블랙</option>
                                                        <option>경고</option>`; break;
            case "경고":
                modalSubmit.innerHTML=`   <option disabled >선택</option>
                                                        <option >반려</option>
                                                        <option>블랙</option>
                                                        <option selected>경고</option>`; break;
            case "처리 완료료":
                modalSubmit.innerHTML=`   <option disabled >선택</option>
                                                        <option >반려</option>
                                                        <option>블랙</option>
                                                        <option selected>경고</option>`; break;
        }


        memberName.innerHTML=` <strong>신고자:</strong> ${reportDetail.memberNick} `;
        reportedName.innerHTML=` <strong>신고 대상:</strong> ${reportDetail.reportedUserNick} `;
        customerText.innerText = reportDetail.reportDetail;
        infoBtn.innerText = reportDetail.reportedUserNick +" 정보 조회";
        infoBtn.setAttribute("path", "/manageBrand/brandProfile/-1?boardNo="+reportNo);
        managerReportText.value  = reportDetail.reply == null? '': reportDetail.reply;

    })
    .catch(err=>console.log(err))
}

/* 모달 닫기 */
document.getElementsByClassName("close")[0].addEventListener("click", e=>{
    modal.classList.remove("modalActive");

    // modalReport.innerHTML = ``;

    // memberName.innerHTML=``;
    // if(reportedName != undefined){
    //     reportedName.innerHTML=``;
    // }
    // customerText.innerText = '';
    // if(managerReportText != undefined){

    //     managerReportText.value  = '';
    // }
})

function goProfile(){
    const clickBtn = infoBtn.getAttribute("path");
    location.href = clickBtn;
}



// 제휴 화면
function clickApply(boardNo){

    modal.classList.add("modalActive");
    console.log(boardNo);

    fetch("boardDetail/8?boardNo="+boardNo)
    .then(resp=>resp.json())
    .then(applyDetail =>{
        console.log(applyDetail);



        
        modalReport.innerHTML = ` <strong>제목:</strong> ${applyDetail.boardTitle}`;


        switch(applyDetail.state){
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

        customerText.innerText = applyDetail.boardContent;
        memberName.innerHTML=` <strong>브랜드명:</strong> ${applyDetail.brandName} `;
        managerReportText.value  = applyDetail.reply == null? '': applyDetail.reply;
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






/* 고객 */
const modalTitle = document.querySelector(".modalTitle");
const managerText = document.querySelector(".managerText");

// 고객 문의 화면
function customerQuest(boardNo){

    console.log(boardNo);
    modal.classList.add("modalActive");
    
    fetch("questDetail?boardNo="+boardNo)
    .then(resp=>resp.json())
    .then(questDetail =>{
        console.log(questDetail);
        
        
        
        modalTitle.innerHTML = ` <strong>제목:</strong> ${questDetail.boardTitle}`;
        
        customerText.innerText = questDetail.boardContent;
        memberName.innerHTML=` <strong>회원명:</strong> ${questDetail.memberNick} `;
        managerText.value  = questDetail.reply == null? '': questDetail.reply;
        
        // 버튼 유무
        const submitBtn = document.querySelector(".modal-btn");
        if(questDetail.boardDelFl =='N'){
            submitBtn.innerHTML = `<button>제출</button>`;
        }
        return;
    })


}


// 고객 신고 화면
function customerReport(reportNo){

    console.log(reportNo);
    modal.classList.add("modalActive");
    fetch("reportDetail?reportNo="+reportNo)
    .then(resp=>resp.json())
    .then(reportDetail =>{
        console.log(reportDetail);
        
        modalReport.innerHTML = ` <strong>제목:</strong> ${reportDetail.reportTitle} (${reportDetail.reportTypeName})`;
        
        
        
        
        switch(reportDetail.reportStatus){
            case "대기":
                 modalSubmit.innerHTML=`   <option disabled selected>선택</option>
                                                            <option>반려</option>
                                                            <option>블랙</option>
                                                            <option>경고</option>`; break;
            case "반려":
                modalSubmit.innerHTML=`   <option disabled >선택</option>
                                                        <option selected>반려</option>
                                                        <option>블랙</option>
                                                        <option>경고</option>`; break;
            case "블랙":
                modalSubmit.innerHTML=`   <option disabled >선택</option>
                                                        <option>반려</option>
                                                        <option selected>블랙</option>
                                                        <option>경고</option>`; break;
            case "경고":
                modalSubmit.innerHTML=`   <option disabled >선택</option>
                                                        <option >반려</option>
                                                        <option>블랙</option>
                                                        <option selected>경고</option>`; break;
            case "처리 완료료":
                modalSubmit.innerHTML=`   <option disabled >선택</option>
                                                        <option >반려</option>
                                                        <option>블랙</option>
                                                        <option selected>경고</option>`; break;
        }

        memberName.innerHTML=` <strong>신고자:</strong> ${reportDetail.memberNick} `;
        reportedName.innerHTML=` <strong>신고 대상:</strong> ${reportDetail.reportedUserNick} `;
        customerText.innerText = reportDetail.reportDetail;
        infoBtn.innerText = reportDetail.reportedUserNick +" 정보 조회";
        infoBtn.setAttribute("path", "/manageBrand/brandProfile/-1?boardNo="+reportNo);
        managerReportText.value  = reportDetail.reply == null? '': reportDetail.reply;
        return;

    })
    .catch(err=>console.log(err))

}