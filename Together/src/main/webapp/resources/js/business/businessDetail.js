console.log("businessDetail.js");

const productOptions = document.querySelectorAll(".product-option");
const myQNA = document.getElementById("myQNA");
const notSecret = document.getElementById("notSecret");

document.addEventListener("DOMContentLoaded", ()=>{
    loadList(myQNA.checked, notSecret.checked);
    productOptions.forEach(productOption=>productOption.value = "default");
});

function adjustMargin() {
    const headerHeight = document.getElementsByClassName("fixed-option-bar")[0].offsetHeight;
    document.getElementsByClassName("footer-container")[0].style.marginBottom = `${headerHeight}px`;
}

window.onload = adjustMargin;
window.onresize = adjustMargin;

function formatDate(dateString) {
    if (!dateString) return "-";
    
    const date = new Date(dateString);
    const now = new Date();

    // 날짜 비교를 위해 "YYYY-MM-DD" 형식으로 변환
    const dateStr = date.toISOString().split("T")[0]; 
    const nowStr = now.toISOString().split("T")[0];

    if (dateStr === nowStr) {
        // 오늘이면 "HH:mm" 형식
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        return `${hours}:${minutes}`;
    } else {
        // 오늘 이전이면 "YYYY-MM-DD" 형식
        return dateStr;
    }
}

const loadList = (myQNA, notSecret)=>{
    fetch(`${location.pathname}/list?myQNA=${myQNA}&notSecret=${notSecret}`)
    .then(resp=>resp.json())
    .then(list=>renderList(list))
    .catch(err=>console.log(err));
};

myQNA.addEventListener("change", ()=>{
    if(loginMemberNo=="") {
        alert("로그인 후 이용해 주세요");
        myQNA.checked=false;
        return;
    }
    loadList(myQNA.checked, notSecret.checked);
});

notSecret.addEventListener("change", ()=>{
    loadList(myQNA.checked, notSecret.checked);
});

const renderList=map=>{
    // console.log(map);
    const reviewCounts = document.querySelectorAll('a[href="#review"] span');
    const replyCounts = document.querySelectorAll('a[href="#q&a"] span');
    reviewCounts.forEach(reviewCount=>{
        reviewCount.textContent = map.reviewPagination.listCount;
    });
    replyCounts.forEach(replyCount=>{
        replyCount.textContent = map.replyPagination.listCount;
    });

    const reviewListArea = document.getElementById("reviewListArea");
    const reviewList = map.reviewList;
    reviewListArea.innerHTML = "";

    if(reviewList.length==0){
        const reviewRow = document.createElement("tr");
        const reviewCell = document.createElement("td");
        reviewCell.setAttribute("colspan", "5");
        reviewCell.innerText = "리뷰가 없습니다.";
        reviewRow.append(reviewCell);
        reviewListArea.append(reviewRow);
    }

    for(let review of reviewList){
        const reviewRow = document.createElement("tr");
        const reviewNo = document.createElement("td");
        const reviewImg = document.createElement("td");
        const reviewContent = document.createElement("td");
        const reviewNickName = document.createElement("td");
        const reviewDate = document.createElement("td");
    
        reviewNo.innerText = review.reviewNo;
        
        const reviewThumbnail = document.createElement("img");
        if(review.imageList.length>0){
            reviewThumbnail.src = review.imageList[0].imagePath+review.imageList[0].imageReName;
        } else {
            reviewThumbnail.src = review.businessThumbnail;
        }
        reviewImg.append(reviewThumbnail);

        review.reviewContent = review.reviewContent.replaceAll("&amp;", "&");
        review.reviewContent = review.reviewContent.replaceAll("&lt;", "<");
        review.reviewContent = review.reviewContent.replaceAll("&gt;", ">");
        review.reviewContent = review.reviewContent.replaceAll("&quot;", "\"");
        reviewContent.innerText = review.reviewContent;
        reviewContent.addEventListener("click", ()=>modalShow(review));

        reviewNickName.innerText = review.memberNickname;
        if(review.reviewUpdateDate==null){
            reviewDate.innerText = formatDate(review.reviewCreatedDate);
        } else {
            reviewDate.innerText = formatDate(review.reviewUpdateDate);
        }

        reviewRow.append(reviewNo, reviewImg, reviewContent, reviewNickName, reviewDate);
        reviewListArea.append(reviewRow);
    }

    const reviewPagination = map.reviewPagination;
    const reviewPaginationArea = document.getElementById("reviewPaginationArea");
    reviewPaginationArea.innerHTML = "";
    if(reviewPagination.maxPage>1){
        const startPage = document.createElement("li");
        const prevPage = document.createElement("li");
        const page = document.createElement("li");
        const nextPage = document.createElement("li");
        const endPage = document.createElement("li");

        startPage.innerHTML = `<a url="">&lt;&lt;</a>`;
        prevPage.innerHTML = `<a url="">&lt;</a>`;

        for(let i=replyPagination.startPage;i<=reviewPagination.endPage;i++){
            if(replyPagination.currentPage==1){
                page.innerHTML = `<a class="current">${i}</a>`;
            } else {
                page.innerHTML = `'<a url="">${i}</a>';`
            }
        }

        nextPage.innerHTML = `<a url="">&gt;</a>`;
        endPage.innerHTML = `<a url="">&gt;&gt;</a>`;

        reviewPaginationArea.append(startPage, prevPage, page, nextPage, endPage);
    }

    const replyListArea = document.getElementById("replyListArea");
    const replyList = map.replyList;
    replyListArea.innerHTML = "";

    if(replyList.length==0){
        const replyRow = document.createElement("tr");
        const replyCell = document.createElement("td");
        replyCell.setAttribute("colspan", "5");
        replyCell.innerText = "Q&A가 없습니다.";
        replyRow.append(replyCell);
        replyListArea.append(replyRow);
    }

    for(let reply of replyList){
        const replyRow = document.createElement("tr");
        const replyNo = document.createElement("td");
        const replyImg = document.createElement("td");
        const replyContent = document.createElement("td");
        const replyNickName = document.createElement("td");
        const replyDate = document.createElement("td");
    
        replyNo.innerText = reply.replyNo;
        
        const replyThumbnail = document.createElement("img");
        replyThumbnail.src = reply.thumbnail;
        replyImg.append(replyThumbnail);
        
        if(reply.secretReplyStatus=='N'||reply.memberNo==loginMemberNo){
            reply.replyContent = reply.replyContent.replaceAll("&amp;", "&");
            reply.replyContent = reply.replyContent.replaceAll("&lt;", "<");
            reply.replyContent = reply.replyContent.replaceAll("&gt;", ">");
            reply.replyContent = reply.replyContent.replaceAll("&quot;", "\"");
            replyContent.innerText = reply.replyContent;
            if(reply.secretReplyStatus=='Y'){
                replyContent.innerText+="🔒";
            }
            replyContent.addEventListener("click", ()=>currentQNA(replyRow));
        } else {
            replyContent.innerText = "비밀글 입니다.🔒";
            replyContent.addEventListener("click", ()=>alert("비밀글 입니다."));
        }

        replyNickName.innerText = reply.memberNickname;
        replyDate.innerText = formatDate(reply.replyCreatedDate);

        replyRow.append(replyNo, replyImg, replyContent, replyNickName, replyDate);
        replyListArea.append(replyRow);

        const currentCommentArea = document.createElement("tr");
        const currentReplyArea = document.createElement("tr");
        currentCommentArea.classList.add("current-detail");
        currentReplyArea.classList.add("current-detail");

        const currentCommentContent = document.createElement("td");
        currentCommentContent.setAttribute("colspan", "5");
        currentCommentContent.innerText = reply.replyContent;
        currentCommentArea.append(currentCommentContent);
        replyListArea.append(currentCommentArea);

        const childReply = reply.commentList[0];
        if(childReply!=null){
            const currentReplyContent = document.createElement("td");
            currentReplyContent.setAttribute("colspan", "3");
            currentReplyContent.innerText = childReply.replyContent;
            const currentReplyNickname = document.createElement("td");
            currentReplyNickname.innerText = childReply.memberNickname;
            const currentReplyDate = document.createElement("td");
            currentReplyDate.innerText = formatDate(childReply.replyCreatedDate);
            currentReplyArea.append(currentReplyContent, currentReplyNickname, currentReplyDate);
            replyListArea.append(currentReplyArea);
        }
    }

    const replyPagination = map.replyPagination;
    const replyPaginationArea = document.getElementById("replyPaginationArea");
    replyPaginationArea.innerHTML = "";
    if(replyPagination.maxPage>1){
        const startPage = document.createElement("li");
        const prevPage = document.createElement("li");
        const page = document.createElement("li");
        const nextPage = document.createElement("li");
        const endPage = document.createElement("li");

        startPage.innerHTML = `<a url="">&lt;&lt;</a>`;
        prevPage.innerHTML = `<a url="">&lt;</a>`;

        for(let i=replyPagination.startPage;i<=replyPagination.endPage;i++){
            if(replyPagination.currentPage==1){
                page.innerHTML = `<a class="current">${i}</a>`;
            } else {
                page.innerHTML = `'<a url="">${i}</a>';`
            }
        }

        nextPage.innerHTML = `<a url="">&gt;</a>`;
        endPage.innerHTML = `<a url="">&gt;&gt;</a>`;

        replyPaginationArea.append(startPage, prevPage, page, nextPage, endPage);
    }
}

const modal = document.getElementsByClassName("modal")[0];
const closeModalBtn = document.getElementById("closeModalBtn");
const modalShow = review=>{
    modal.style.display = "flex";
    setTimeout(() => {
        modal.classList.remove("hide");
        modal.classList.add("show");
    }, 10);
    
    const modalImgArea = document.getElementsByClassName("modal-img-area")[0];
    const ratingArea = document.getElementsByClassName("rating-area")[0];
    const userArea = document.getElementsByClassName("user-area")[0];
    const reviewContent = document.getElementsByClassName("review-content")[0];
    const replyMemberArea = document.getElementById("replyMemberArea");
    const replyContentArea = document.getElementById("replyContentArea");
    
    modalImgArea.innerHTML = "";
    const imageList = review.imageList;
    imageList.forEach(image=>{
        const img = document.createElement("img");
        img.src = image.imagePath + image.imageReName;
        modalImgArea.append(img);
    });
    
    ratingArea.innerHTML = "";
    for(let i=1;i<6;i++){
        const star = document.createElement("i");
        star.classList.add("fa-star");
        if(i<=review.reviewStar){
            star.classList.add("fa-solid");
        } else {
            star.classList.add("fa-regular");
        }
        ratingArea.append(star);
    }
    
    const span = document.createElement("span");
    span.innerText = review.reviewStar;
    ratingArea.append(span);

    userArea.innerHTML = "";
    const profile = document.createElement("img");
    if(review.memberProfile==null){
        profile.src = "/resources/images/mypage/관리자 프로필.webp";
    } else {
        profile.src = review.memberProfile;
    }

    const memberNickname = document.createElement("span");
    memberNickname.innerText = review.memberNickname;

    const reviewCreatedDate = document.createElement("span");
    reviewCreatedDate.innerText = formatDate(review.reviewCreatedDate);

    userArea.append(profile, memberNickname, reviewCreatedDate);

    if(loginMemberNo==review.memberNo){
        const editBtn = document.createElement("span");
        editBtn.classList.add("clickBtn");
        editBtn.addEventListener("click", ()=>updateReview(review));
        editBtn.innerText = "수정";

        const deleteBtn = document.createElement("span");
        deleteBtn.classList.add("clickBtn");
        deleteBtn.addEventListener("click", ()=>deleteReview(review));
        deleteBtn.innerHTML = "삭제";

        userArea.append(editBtn, deleteBtn);
    } else {
        const reportBtn = document.createElement("span");
        reportBtn.classList.add("clickBtn")
        reportBtn.addEventListener("click", ()=>reportReview(review));
        reportBtn.innerText = "신고";
        userArea.append(reportBtn);
    }

    // 옵션 내용 추가 예정

    reviewContent.innerText = review.reviewContent;

    replyMemberArea.innerHTML = "";
    replyContentArea.innerHTML = "";
    const replyMember = document.createElement("span");
    replyMember.innerText = review.replyList[0].memberNickname + " | " +
                            formatDate(review.replyList[0].replyCreatedDate);

    replyMemberArea.append(replyMember, " | ");
    if(loginMemberNo==review.replyList[0].memberNo){
        const editBtn = document.createElement("span");
        editBtn.classList.add("clickBtn");
        editBtn.addEventListener("click", ()=>editReply(review.replyList[0]));
        editBtn.innerText = "수정";

        const deleteBtn = document.createElement("span");
        deleteBtn.classList.add("clickBtn");
        deleteBtn.addEventListener("click", ()=>deleteReply(review.replyList[0]));
        deleteBtn.innerText = "삭제";

        replyMemberArea.append(editBtn, " | ", deleteBtn);
    } else {
        const replyReport = document.createElement("span");
        replyReport.classList.add("clickBtn");
        replyReport.addEventListener("click", ()=>reportReply(review.replyList[0]));
        replyReport.innerText = "신고";
        replyMemberArea.append(replyReport);
    }

    const replyContent = document.createElement("div");
    replyContent.innerText = review.replyList[0].replyContent;

    replyContentArea.append(replyContent);
};

modal.addEventListener("click", e=>closeModal(e));

const closeModal = e=>{
    if(e.target!==modal&&e.target!==closeModalBtn) return;

    modal.classList.add("hide");
    modal.classList.remove("show");

    modal.addEventListener("transitionend", function hideModal() {
        modal.style.display = "none";
        modal.removeEventListener("transitionend", hideModal);
    });
};

/* Q&A 링크 연결 */

setTimeout(()=>{
  const url = new URL(location.href);
  const getReplyNo = url.searchParams.get("qa");
  if (getReplyNo) {
    myQNA.click();
    setTimeout(()=>{
      const area =  document.getElementById('replyListArea');
      const replytds = area.getElementsByTagName('td');
      Array.from(replytds).forEach(td => {
        if (td.innerText == getReplyNo) {
          td.nextElementSibling.nextElementSibling.click();
        }
      });
    }, 1500);
  }

  const reviewNo = url.searchParams.get("review");
  console.log(reviewNo);
  if (reviewNo == 0) {
    setTimeout(()=>{
    openPopup('view');
    }, 800);
  }
} , 150);



const currentQNA = replyRow=>{
    const existingComment = replyRow.nextElementSibling;
    const tdList = existingComment.querySelectorAll("td");
    const nextSibling = existingComment.nextElementSibling;
    const tds = nextSibling?.querySelectorAll("td") || []

    if(existingComment.classList.contains("show")){
        existingComment.classList.remove("show");
        tdList.forEach(td => td.style.display = "none");
        if(existingComment.nextElementSibling?.classList.contains("current-detail")){
            existingComment.nextElementSibling.classList.remove("show");
            tds.forEach(td => td.style.display = "none");
        }
        replyRow.classList.remove("qna-current");
    } else {
        tdList.forEach(td => td.style.display = "table-cell");
        existingComment.classList.add("show");
        if(existingComment.nextElementSibling?.classList.contains("current-detail")){
            tds.forEach(td => {
                td.style.display = "table-cell"
                td.style.borderTop = "2px solid #999999";
            });
            existingComment.nextElementSibling.classList.add("show");
        }
        replyRow.classList.add("qna-current");
    }
};

// 팝업창 열기
const openPopup=key=>{
    // 화면 크기 가져오기
    const screenWidth = window.screen.width;
    const screenHeight = window.screen.height;

    // 팝업 창 크기 지정
    const popupWidth = 600;
    const popupHeight = 675;

    // 정가운데 위치 계산
    const left = (screenWidth - popupWidth) / 2;
    const top = (screenHeight - popupHeight) / 2;

    window.open(
        location.pathname + "/insertRe" + key, 
        "PopupWindow", 
        `width=${popupWidth},height=${popupHeight},left=${left},top=${top}`
    );
};

// 리뷰 신고 보내기
const reportReview = review=>{
    
};

// 댓글 신고 보내기
const reportReply = reply=>{

};

// 리뷰 수정
const updateReview = review=>{

};

// 댓글 수정
const editReply = review=>{

};

// 리뷰 삭제
const deleteReview = review=>{

};

// 댓글 삭제
const deleteReply = review=>{

};

// 상품 옵션
let totalPrice = 0;
let totalCount = 0;

productOptions.forEach(select => {
    select.addEventListener("change", (e) => changeOption(e));
});

const changeOption = (e) => {
    const selectOption = e.target.value;
    if (selectOption === "default") return;

    // 모든 select 요소를 찾아서 동기화
    productOptions.forEach(select => {
        select.value = selectOption;
    });

    const choiceLists = document.querySelectorAll(".choice-option-area");

    // 기존 옵션이 있는 경우 삭제 후 추가
    if (document.querySelector(".choice-option-area tr")) {
        const confirmDelete = confirm("이미 선택된 옵션이 있습니다. 새로운 옵션을 선택하면 기존 옵션이 삭제됩니다. 계속하시겠습니까?");
        if (!confirmDelete) {
            e.target.value = "default"; // 선택 취소
            return;
        }
        removeAllOptions();
    }

    // 옵션 행 생성
    const optionRow = document.createElement("tr");
    optionRow.setAttribute("data-option", selectOption);

    const optionName = document.createElement("td");
    optionName.innerText = selectOption;

    const optionCount = document.createElement("td");
    const optionInput = document.createElement("input");
    optionInput.type = "number";
    optionInput.value = "1";
    optionInput.min = "1";

    const optionSpan = document.createElement("span");
    optionSpan.innerHTML = "&times";

    optionCount.append(optionInput, optionSpan);

    const optionPrice = document.createElement("td");
    optionPrice.innerText = productPrice.toLocaleString() + "원";

    optionRow.append(optionName, optionCount, optionPrice);

    // 모든 choice-option-area에 같은 옵션 추가
    choiceLists.forEach(list => {
        const clonedRow = optionRow.cloneNode(true);
        list.append(clonedRow);

        const clonedInput = clonedRow.querySelector("input");
        const clonedSpan = clonedRow.querySelector("span");
        const clonedPrice = clonedRow.querySelector("td:last-child");

        // 수량 변경 이벤트 추가
        clonedInput.addEventListener("change", () => updateOptionPrice(clonedInput, clonedPrice));

        // 삭제 이벤트 추가
        clonedSpan.addEventListener("click", removeAllOptions);
    });

    updateTotal();
};

// 금액 업데이트 함수
const updateOptionPrice = (input, optionPrice) => {
    const price = (productPrice * parseInt(input.value, 10)).toLocaleString() + "원";
    optionPrice.innerText = price;
    updateTotal();
};

// 모든 옵션 삭제 함수
const removeAllOptions = () => {
    document.querySelectorAll(".choice-option-area tr").forEach(row => row.remove());
    productOptions.forEach(select => select.value = "default");
    updateTotal();
};

// 총 금액 업데이트 함수
const updateTotal = () => {
    const totalPriceAreas = document.querySelectorAll(".total-price-area");
    const totalCountAreas = document.querySelectorAll(".total-count-area");
    const input = document.querySelector("input[type='number']");

    let newTotalPrice = 0;
    let newTotalCount = 0;

    if (input) {
        newTotalPrice = deliveryFee;
    
        const quantity = parseInt(input.value, 10);
        newTotalPrice += productPrice * quantity;
        newTotalCount += quantity;
    } else {
        productOptions.forEach(select => select.value = "default");
    }

    totalPrice = newTotalPrice;
    totalCount = newTotalCount;
    
    totalPriceAreas.forEach(totalPriceArea=>{totalPriceArea.innerText = totalPrice});
    totalCountAreas.forEach(totalCountArea=>totalCountArea.innerText = totalCount);
};

// 옵션바 클릭
const changeOptionBar=changeOptionBar=>{
    const optionArea = document.getElementsByClassName("fixed-option-area")[0];
    if(!optionArea.classList.contains("show")){
        changeOptionBar.innerText = "옵션보기<";
        optionArea.classList.add("show");
        return;
    }

    changeOptionBar.innerText = "옵션보기>";
    optionArea.classList.remove("show");
};

const goToBuys = document.querySelectorAll(".go-to-buy");
goToBuys.forEach(goToBuy=>{
    goToBuy.addEventListener("click", ()=>{
        const input = document.querySelector("input[type='number']");
        if(!input){
            alert("상품 옵션을 선택 후 구매할 수 있습니다.");
            return;
        }

        if(loginMemberNo=="") {
            alert("로그인 후 구매할 수 있습니다.");
            return;
        }

        window.location.href = `${location.pathname}/order?optionName=${productOptions[0].value}&optionNo=${productOptions[0].getAttribute("data-optionNo")}&quantity=${input.value}`;
    });
});