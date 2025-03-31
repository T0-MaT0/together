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
    const loadingCover = document.querySelector(".loadingCoverPurple");
    loadingCover.classList.add('active');

    // console.log(reportNo);

    outRepotNo = reportNo;

    modal.classList.add("modalActive");
    
    fetch("reportDetail?reportNo="+reportNo)
    .then(resp=>resp.json())
    .then(reportDetail =>{
        console.log(reportDetail);
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
        


        // const  modalbtn = document.querySelector(".modal-btn");
        // modalbtn.innerHTML ='';
        // // 처리 버튼
        // if(reportDetail.reportStatus=='대기'){
        //     managerReportText.innerText  = reportDetail.reply == null? '': reportDetail.reply;
        //     managerReportText.setAttribute("contenteditable","true");
        //     modalbtn.innerHTML = `<button onclick="reportSubmit('customer')">처리</button>`
        // }else{
        //     managerReportText.setAttribute("contenteditable","false");
        // }


        let beforeContent = reportDetail.reply == null ? '' : reportDetail.reply;

        beforeContent =  beforeContent.replaceAll("&amp;", "&");
        beforeContent =  beforeContent.replaceAll("&lt;", "<");
        beforeContent =  beforeContent.replaceAll("&gt;", ">");
        beforeContent =  beforeContent.replaceAll("&quot;", "\"");

        
        const  modalbtn = document.querySelector(".modal-btn");
        const managerReportText = document.querySelector(".managerReportText");
        modalbtn.innerHTML ='';
        managerReportText.innerText  = beforeContent ;

        // 처리 버튼
        if(reportDetail.reportStatus=='대기'){
            managerReportText.setAttribute("contenteditable","true");
            modalbtn.innerHTML = `<button onclick="reportSubmit('customer')">처리</button>`
        }else{
            managerReportText.setAttribute("contenteditable","false");
        }
       
       
        // 버튼 영역
        infoBtn.innerText = reportDetail.reportedUserNick +" 정보 조회";
        infoBtn.setAttribute("path", "/manageBrand/brandProfile/-1?boardNo="+reportNo);
        BoardBtn.innerText = "문제 "+ reportDetail.reportTypeName +" 조회";
        BoardBtn.setAttribute("onclick",`openBoard(${reportDetail.reportType}, ${reportDetail.reportTypeNo})`)

   

    })
    .catch(err=>console.log(err))


    setTimeout(() => {
        loadingCover.classList.remove('active');

    }, 1000);
}

/* 모달 닫기 */
document.getElementsByClassName("close")[0].addEventListener("click", e=>{
    modal.classList.toggle("modalActive");

    // modalReport.innerHTML = ``;

    // memberName.innerHTML=``;
    // if(reportedName != undefined){
    //     reportedName.innerHTML=``;
    // }
    customerText.innerText = '';

        // managerText.innerText  = '';
        closeProfile();
})




// 신고 이동 화면
const reportProfileModal = document.querySelector(".draggable");
const profileDetail = document.querySelector(".profile-detail");
const profileList = document.querySelector(".profile-list");
const profileContent = document.querySelector(".profile-content");


function openProfile(){
    console.log("openProfile");
    console.log(reportedUserNo);
    reportProfileModal.classList.toggle("active");

    if (location.href.includes("manageBrand")) {
        profileContent.style.backgroundColor = "#D2BDFE";
    } else {
        profileContent.style.backgroundColor = "#FFE9F3";
    }
    
    fetch("modalInfo?memberNo="+reportedUserNo)
    .then(resp=>resp.json())
    .then(member=>{
        console.log(member);
        profileDetail.innerHTML='';
        // 이미지 요소 생성
        const img = document.createElement("img");
        if(member.profileImg == null){
            img.setAttribute("src", "/resources/images/image-manager/profile.png");
        }else{
            img.setAttribute("src", "/resources/upload/profile/"+member.profileImg);
        }

        // 닉네임 요소 생성
        const nick = document.createElement("div");
        nick.innerHTML = `<strong>닉네임: </strong>${member.memberNick}`;
        // 경고 상태

        // 신고 횟수
        const reportCount = document.createElement("div");
        reportCount.innerHTML = `<strong>경고 횟수: </strong>${member.warnCount}`;

        // 부모요소에 담기
        profileDetail.append(img);
        profileDetail.append(nick);
        profileDetail.append(reportCount);

    })
    .catch(err=>console.log(err));

    console.log("번호"+outRepotNo);

    fetch("infoList/3?memberNo="+ reportedUserNo)
    .then(resp=>resp.json())
    .then(reportList =>{
        // console.log(reportList);
        profileList.innerHTML = '';
        for(let item of reportList){
            let proBoard = document.createElement("div");
            proBoard.classList.add("pro-board", "body-board");
            proBoard.setAttribute("onclick", `clickProDetail(${item.no})`);

            const div1 = document.createElement("div");
            div1.append(item.no);
            const div2 = document.createElement("div");
            div2.append(item.title);
            const div3 = document.createElement("div");
            div3.append(item.createDate);
            const div4 = document.createElement("div");
            div4.append(item.state);

            proBoard.append(div1, div2, div3, div4);    
            profileList.append(proBoard);
        }


    })
    .catch(err=>console.log(err))

}


// profile 신고 대상 고객 상세 내용 조회
const reportListSection = document.getElementsByClassName("report-list-section")[0];

function clickProDetail(no){
    console.log("clickProDetail");

    reportListSection.innerHTML ='<div class="detail-title">신고 내용</div>';
    fetch("infoDetail?reportNo="+no)
    .then(resp=>resp.json())
    .then(report =>{
        console.log(report);

        const boardInfo = document.createElement("div");
        const boardTitle = document.createElement("div");
        const boardDetail = document.createElement("div");

        boardInfo.classList.add("border-board");
        const leftStrong = document.createElement('strong');
        const rightStrong = document.createElement("strong");

        leftStrong.append("신고자: ");
        rightStrong.append("신고 종류: ");
        boardInfo.append(leftStrong);
        boardInfo.append(report.memberNick);
        boardInfo.innerHTML += "&nbsp;&nbsp;&nbsp;&nbsp;"
        boardInfo.append(rightStrong, report.reportTypeName);
        
        boardTitle.classList.add("border-board");
        const titleStrong = document.createElement("strong");
        titleStrong.append("제목: ")
        boardTitle.append(titleStrong, report.reportTitle);

        
        boardDetail.classList.add("border-detail");
        boardDetail.append(report.reportDetail);
        
        reportListSection.append(boardInfo, boardTitle, boardDetail);
    })
    .catch(err=>console.log(err))
    console.log("번호"+no);
}

// 닫기 
function closeProfile(){
    console.log("closeProfile");
    reportProfileModal.classList.remove("active");
}





// 신고 대상 내용 조회
function openBoard(type, no){
    console.log("openBoard");
    
    if(type==1){
        //팝업 창으로 해당 문제 화면 열기
        window.open("boardModal/"+type+"?no="+no, "boardDetail", "width=1210, height=800, left=100, top=50");
        
    }else{
        //팝업 창으로 해당 문제 화면 열기
        window.open("boardModal/"+type+"?no="+no, "boardDetail", "width=800, height=800, left=100, top=50");

    }

}




// 고객 신고 화면
function customerReport(reportNo){
    const loadingCover = document.querySelector(".loadingCover");
    loadingCover.classList.add('active');

    outRepotNo = reportNo;
    
    modal.classList.add("modalActive");
    fetch("reportDetail?reportNo="+reportNo)
    .then(resp=>resp.json())
    .then(reportDetail =>{
        console.log(reportDetail);
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
        
        // 버튼 영역
        infoBtn.innerText = reportDetail.reportedUserNick +" 정보 조회";
        infoBtn.setAttribute("path", "/manageBrand/brandProfile/-1?boardNo="+reportNo);
        BoardBtn.innerText = "문제 "+reportDetail.reportTypeName +" 조회";
        BoardBtn.setAttribute("onclick",`openBoard(${reportDetail.reportType}, ${reportDetail.reportTypeNo})`)


        let beforeContent = reportDetail.reply == null ? '' : reportDetail.reply;

        beforeContent =  beforeContent.replaceAll("&amp;", "&");
        beforeContent =  beforeContent.replaceAll("&lt;", "<");
        beforeContent =  beforeContent.replaceAll("&gt;", ">");
        beforeContent =  beforeContent.replaceAll("&quot;", "\"");

        
        const  modalbtn = document.querySelector(".modal-btn");
        const managerReportText = document.querySelector(".managerReportText");
        modalbtn.innerHTML ='';

        managerReportText.innerText  = beforeContent ;
        
        // 처리 버튼
        if(reportDetail.reportStatus=='대기'){
            managerReportText.setAttribute("contenteditable","true");
            modalbtn.innerHTML = `<button onclick="reportSubmit('customer')">처리</button>`
        }else{
            managerReportText.setAttribute("contenteditable","false");
        }
       

        

        // managerReportText.innerText = beforeContent;


        return;

    })
    .catch(err=>console.log(err))


    setTimeout(() => {
        loadingCover.classList.remove('active');

    }, 1000);
}




modalSubmit.addEventListener("change", function () {
    const selectedValue = modalSubmit.value;
    state = selectedValue;
    console.log("선택된 값:", state);

});



// 신고 제출
function reportSubmit(where){

    
    if(state == ''||state=='대기'){
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


// 신고자 정보 조회
document.addEventListener('DOMContentLoaded', function () {
    // 마우스의 위치값 저장
    let x = 0;
    let y = 0;
  
    // 대상 Element 가져옴
    const ele = document.getElementById('dragMe').parentElement;
    // 마우스 누른 순간 이벤트
    const mouseDownHandler = function (e) {
      // 누른 마우스 위치값을 가져와 저장
    //   console.log(e.target);
      if(e.target == ele ) return;
      x = e.clientX;
      y = e.clientY;
  
      // 마우스 이동 및 해제 이벤트를 등록
      document.addEventListener('mousemove', mouseMoveHandler);
      document.addEventListener('mouseup', mouseUpHandler);
    };
  
    const mouseMoveHandler = function (e) {
      // 마우스 이동시 초기 위치와의 거리차 계산
      const dx = e.clientX - x;
      const dy = e.clientY - y;
  
      // 마우스 이동 거리 만큼 Element의 top, left 위치값에 반영
      ele.style.top = `${ele.offsetTop + dy}px`;
      ele.style.left = `${ele.offsetLeft + dx}px`;
  
      // 기준 위치 값을 현재 마우스 위치로 update
      x = e.clientX;
      y = e.clientY;
    };
  
    const mouseUpHandler = function () {
      // 마우스가 해제되면 이벤트도 같이 해제
      document.removeEventListener('mousemove', mouseMoveHandler);
      document.removeEventListener('mouseup', mouseUpHandler);
    };
  
    ele.addEventListener('mousedown', mouseDownHandler);
  });