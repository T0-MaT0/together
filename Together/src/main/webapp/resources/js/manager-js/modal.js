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

function clickTitle(reportNo){
    console.log(reportNo);
    modal.classList.add("modalActive");
    
    fetch("reportDetail?reportNo="+reportNo)
    .then(resp=>resp.json())
    .then(reportDetail =>{
        console.log(reportDetail);

        modalReport.innerHTML = ` <strong>제목:</strong> ${reportDetail.reportTitle}`;

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
        managerReportText.innerText  = reportDetail.reply == null? '': reportDetail.reply;

    })
    .catch(err=>console.log(err))
}

/* 모달 닫기 */
document.getElementsByClassName("close")[0].addEventListener("click", e=>{
    modal.classList.remove("modalActive");

    modalReport.innerHTML = ` <strong>제목:</strong>`;

    memberName.innerHTML=` <strong>신고자:</strong> `;
    reportedName.innerHTML=` <strong>신고 대상:</strong> `;
    customerText.innerText = '';
    managerReportText.innerText  = '';
})


