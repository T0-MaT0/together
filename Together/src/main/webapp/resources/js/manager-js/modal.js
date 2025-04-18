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
let imageNo = 0;

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
    const loadingCover = document.querySelector(".loadingCoverPurple");
    loadingCover.classList.add('active');

    custBoardNo = boardNo;

    modal.classList.add("modalActive");
    console.log(boardNo);

    fetch("boardDetail/8?boardNo="+boardNo)
    .then(resp=>resp.json())
    .then(applyDetail =>{
        console.log("apply",applyDetail);

        memberNo= applyDetail.memberNo;
        
        modalReport.innerHTML = ` <strong>제목:</strong> ${applyDetail.boardTitle}`;

        state = applyDetail.state;
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
            managerText.setAttribute("contenteditable", "true");
            submitBtn.innerHTML = `<button onclick="submitReply()">제출</button>`;
            
        }



        modalSubmit.addEventListener("change", function () {
            const selectedValue = modalSubmit.value;
            state = selectedValue;
            console.log("선택된 값:", state);
        
        });
    })

    setTimeout(() => {
        loadingCover.classList.remove('active');

    }, 1000);
}



const closeImage = document.querySelector(".closeImage");
const brandBtn = document.querySelector(".brandBtn");
// 광고 화면
function clickProm(boardNo){
    const loadingCover = document.querySelector(".loadingCoverPurple");
    loadingCover.classList.add('active');    
    
    console.log(boardNo);
    modal.classList.add("modalActive");
    custBoardNo = boardNo;

    fetch("boardDetail/7?boardNo="+boardNo)
    .then(resp=>resp.json())
    .then(boardDetail =>{
        console.log(boardDetail);

        state = boardDetail.state;

        
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
        customerText.innerText = boardDetail.boardContent;
    
        // 버튼의 유무
        const submitBtn = document.querySelector(".modal-btn");
        submitBtn.innerHTML = '';
        if(boardDetail.state!='대기'){
            submitBtn.innerHTML=''
        }else{
            submitBtn.innerHTML = '<button onclick="promotionBtn()">처리</button>';
        }

        imageWarp.innerHTML ='';
        const closeSpan = document.createElement('span');
        closeSpan.classList.add('closeImage');
        closeSpan.innerHTML = '&times;';
        closeSpan.setAttribute("onclick", "closePromotion()")
        imageWarp.appendChild(closeSpan);

        ImageList();
    })

    setTimeout(() => {
        loadingCover.classList.remove('active');

    }, 1000);
}



//광고 이미지 조회
function ImageList(){
    fetch("promotionImageSelect?no=" + custBoardNo)
        .then(resp => resp.json())
        .then(images => {
    
            console.log(images[0]);
            imageNo = Number(images[0].imageNo);
            
            const img = document.createElement('img');
            img.setAttribute("src", `${images[0].imagePath}${images[0].imageReName}`)
            
            imageWarp.append(img);
            console.log(imageWarp);
            
            })
            .catch(err => console.error(err))
}

const imageWarp = document.querySelector(".proImage-wrap")
document.querySelector("#proImgBtn")?.addEventListener("click", () => {
    document.querySelector("#imageView").classList.toggle("active");
})

// 이미지 닫기
function closePromotion(){
    document.querySelector("#imageView").classList.toggle("active");
}

// 광고 승인 처리
const imgType = document.querySelector("#imgType");
function promotionBtn(){

    if(state=="대기"){
        alert("해당 문의에 대한 상태를 선택해주세요.");
        imgType,value='';
        return;
    }
    if(state=='승인'){
        if(imgType.value=='선택') {
            alert("이미지의 종류를 선택해주세요.")
            return;
        }
    }
    
    // 이미지 타입 설정
    let imgTypeNumber = 0;
    if(imgType.value == 'mid'){
        imgTypeNumber = 7;
    }else{
        imgTypeNumber = 8;
    }
    console.log(imgTypeNumber);
    // console.log("submit!");
    // console.log(imgType);
    // console.log(custBoardNo);
    // console.log(state);
    // console.log(imageNo);
    fetch("promotionApproval", {
        method: "POST",
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            boardNo: custBoardNo,
            state: state,
            "imgType": imgTypeNumber,
            imageNo: imageNo
        })
    })
    .then(resp => resp.text())
    .then(result => {
        console.log(result);
        if (result > 0) {
            alert("광고 승인 처리가 완료되었습니다.");
            modal.classList.remove("modalActive");
            location.reload();
        } else {
            alert("광고 승인 처리에 실패했습니다.");
        }
    })
    .catch(err => console.error("Error during promotion approval:", err));
}












// 고객 문의 화면
function customerQuest(boardNo){
    const loadingCover = document.querySelector(".loadingCover");
    loadingCover.classList.add('active');

    // 버튼 요소
    const submitBtn = document.querySelector(".modal-btn");

    submitBtn.innerHTML = '';
    
    custBoardNo = boardNo;
    console.log(boardNo);
    modal.classList.add("modalActive");
    
    fetch("questDetail?boardNo="+boardNo)
    .then(resp=>resp.json())
    .then(questDetail =>{
        console.log(questDetail);


        // 관리자 답변 유무에 따른 답변 글쓰기 가능 및 버튼 생성
        if(!questDetail.state){
            managerText.setAttribute("contenteditable", "true");
            submitBtn.innerHTML = `<button onclick="submitReply()">제출</button>`;
        }else{
            managerText.setAttribute("contenteditable", "false");
        }
        
        
        modalTitle.innerHTML = ` <strong>제목:</strong> ${questDetail.boardTitle}`;
        
        customerText.innerText = questDetail.boardContent;
        memberName.innerHTML=` <strong>회원명:</strong> ${questDetail.memberNick} `;
        

        let beforeContent = questDetail.reply == null ? '' : questDetail.reply;

        beforeContent =  beforeContent.replaceAll("&amp;", "&");
        beforeContent =  beforeContent.replaceAll("&lt;", "<");
        beforeContent =  beforeContent.replaceAll("&gt;", ">");
        beforeContent =  beforeContent.replaceAll("&quot;", "\"");

        managerText.innerText = beforeContent;
        
        
    })

    setTimeout(() => {
        loadingCover.classList.remove('active');

    }, 1000);

}




// 상태 값 변화
modalSubmit?.addEventListener("change", function () {
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
        
        if(state == ''||state=='대기'){
            alert("상태를 설정해주세요.");
            return;
        }
    }
    console.log(data)
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