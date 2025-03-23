console.log("reportModel.js");

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

let outRepotNo = 0;
let state = '';
let reportedUserNo = 0;

// 신고 화면
function clickReport(reportNo){
    console.log(reportNo);

    outRepotNo = reportNo;

    modal.classList.add("modalActive");
    
    fetch("reportDetail?reportNo="+reportNo)
    .then(resp=>resp.json())
    .then(reportDetail =>{
        // console.log(reportDetail);
        state=reportDetail.reportStatus;
        reportedUserNo = reportDetail.reportedUserNo;

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


        managerReportText.innerText  = reportDetail.reply == null? '': reportDetail.reply;

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
    customerText.innerText = '';

        managerText.innerText  = '';
})

function goProfile(){
    const clickBtn = infoBtn.getAttribute("path");
    location.href = clickBtn;
}




// 고객 신고 화면
function customerReport(reportNo){
    // console.log(reportNo);

    outRepotNo = reportNo;
    
    modal.classList.add("modalActive");
    fetch("reportDetail?reportNo="+reportNo)
    .then(resp=>resp.json())
    .then(reportDetail =>{
        // console.log(reportDetail);
        state=reportDetail.reportStatus;
        reportedUserNo = reportDetail.reportedUserNo;
        console.log('고객 신고자 정보:'+ reportedUserNo+" "+state);

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

        let beforeContent = reportDetail.reply == null ? '' : reportDetail.reply;

        beforeContent =  beforeContent.replaceAll("&amp;", "&");
        beforeContent =  beforeContent.replaceAll("&lt;", "<");
        beforeContent =  beforeContent.replaceAll("&gt;", ">");
        beforeContent =  beforeContent.replaceAll("&quot;", "\"");

        managerReportText.innerText = beforeContent;


        return;

    })
    .catch(err=>console.log(err))

}




//
modalSubmit.addEventListener("change", function () {
    const selectedValue = modalSubmit.value;
    state = selectedValue;
    console.log("선택된 값:", state);

});



// 신고 제출
function reportSubmit(where){

    
    if(state == ''){
        alert("처리 방법을 선택해주세요.");
        return;
    }
    if(managerReportText.innerHTML == ''){
        alert("처리 내용을 입력해주세요.");
        return;
    }

    const reportDetail = {
        reportNo: outRepotNo,
        reportStatus: state,
        reply: managerReportText.innerText,
        reportedUserNo: reportedUserNo,  
        "where": where
    }

    console.log(reportDetail);
    fetch("reportSubmit", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(reportDetail),
    })
    .then(resp=>resp.text())
    .then(result=>{
        console.log(result);
        if(result != 0){
            alert("정상적으로 처리되었습니다.");
            location.reload();
        }
    })
    .catch(err=>console.log(err))
}

