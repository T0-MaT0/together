console.log("businessDetail.js");

const productOptions = document.querySelectorAll(".product-option");
const myQNA = document.getElementById("myQNA");
const notSecret = document.getElementById("notSecret");

document.addEventListener("DOMContentLoaded", ()=>{
    loadList(myQNA.checked, notSecret.checked);
    productOptions.forEach(productOption=>productOption.value = "default");
});

// 날짜 변경 함수
const formatDate=dateString=>{
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

// DB에서 리뷰, Q&A 목록 조회(비동기)
const loadList = (myQNA, notSecret)=>{
    fetch(`${location.pathname}/list?myQNA=${myQNA}&notSecret=${notSecret}`)
    .then(resp=>resp.json())
    .then(list=>renderList(list))
    .catch(err=>console.log(err));
};

// 로그인한 회원의 Q&A만 조회
myQNA.addEventListener("change", ()=>{
    if(loginMemberNo=="") {
        alert("로그인 후 이용해 주세요");
        myQNA.checked=false;
        return;
    }
    loadList(myQNA.checked, notSecret.checked);
});

// 공개글 Q&A만 조회
notSecret.addEventListener("change", ()=>{
    loadList(myQNA.checked, notSecret.checked);
});

// 리뷰, Q&A 목록 동적 렌더링
const renderList=map=>{
    // console.log(map);
    // 리뷰, Q&A 건수 업데이트
    const reviewCounts = document.querySelectorAll('a[href="#review"] span');
    const replyCounts = document.querySelectorAll('a[href="#q&a"] span');
    reviewCounts.forEach(reviewCount=>{
        reviewCount.textContent = map.reviewPagination.listCount;
    });
    replyCounts.forEach(replyCount=>{
        replyCount.textContent = map.replyPagination.listCount;
    });

    // 리뷰 리스트 렌더링
    const reviewListArea = document.getElementById("reviewListArea");
    const reviewList = map.reviewList;
    reviewListArea.innerHTML = ""; // 영역 초기화

    // 리뷰가 없을 경우
    if(reviewList.length==0){
        const reviewRow = document.createElement("tr");
        const reviewCell = document.createElement("td");
        reviewCell.setAttribute("colspan", "5");
        reviewCell.innerText = "리뷰가 없습니다.";
        reviewRow.append(reviewCell);
        reviewListArea.append(reviewRow);
    }

    // 리뷰가 있을 경우 렌더링
    for(let review of reviewList){
        const reviewRow = document.createElement("tr");
        const reviewNo = document.createElement("td");
        const reviewImg = document.createElement("td");
        const reviewContent = document.createElement("td");
        const reviewNickName = document.createElement("td");
        const reviewDate = document.createElement("td");
    
        // 리뷰 번호
        reviewNo.innerText = review.reviewNo;
        
        // 이미지 처리(썸네일)
        const reviewThumbnail = document.createElement("img");
        if(review.imageList.length>0){
            reviewThumbnail.src = review.imageList[0].imagePath+review.imageList[0].imageReName;
        } else {
            reviewThumbnail.src = review.businessThumbnail;
        }
        reviewImg.append(reviewThumbnail);

        // 특수 문자 디코딩 및 내용 삽입
        review.reviewContent = review.reviewContent.replaceAll("&amp;", "&");
        review.reviewContent = review.reviewContent.replaceAll("&lt;", "<");
        review.reviewContent = review.reviewContent.replaceAll("&gt;", ">");
        review.reviewContent = review.reviewContent.replaceAll("&quot;", "\"");

        const textBox = document.createElement("div");
        textBox.innerText = review.reviewContent;
        textBox.classList.add("text-box");
        reviewContent.append(textBox);
        // 내용 클릭 시 모달창 오픈
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

    // 리뷰 페이지네이션
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

    // Q&A 리스트 렌더링
    const replyListArea = document.getElementById("replyListArea");
    const replyList = map.replyList;
    replyListArea.innerHTML = "";

    // Q&A가 없을 경우
    if(replyList.length==0){
        const replyRow = document.createElement("tr");
        const replyCell = document.createElement("td");
        replyCell.setAttribute("colspan", "5");
        replyCell.innerText = "Q&A가 없습니다.";
        replyRow.append(replyCell);
        replyListArea.append(replyRow);
    }

    // Q&A가 있을 경우 렌더링
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
        
        // 비밀글 여부 판단
        if(reply.secretReplyStatus=='N'||reply.memberNo==loginMemberNo||loginMemberNo==boardMemberNo){
            reply.replyContent = reply.replyContent.replaceAll("&amp;", "&");
            reply.replyContent = reply.replyContent.replaceAll("&lt;", "<");
            reply.replyContent = reply.replyContent.replaceAll("&gt;", ">");
            reply.replyContent = reply.replyContent.replaceAll("&quot;", "\"");
            const textBox = document.createElement("div");
            if(reply.secretReplyStatus=='Y'){
                textBox.innerText="🔒";
            }
            textBox.innerText += reply.replyContent;
            textBox.classList.add("text-box");
            replyContent.append(textBox);
            replyContent.addEventListener("click", ()=>currentQNA(replyRow));
        } else {
            const textBox = document.createElement("div");
            textBox.innerText = "🔒비밀글 입니다.";
            textBox.classList.add("text-box");
            replyContent.append(textBox);
            replyContent.addEventListener("click", ()=>alert("비밀글 입니다."));
        }

        replyNickName.innerText = reply.memberNickname;
        replyDate.innerText = formatDate(reply.replyCreatedDate);

        replyRow.append(replyNo, replyImg, replyContent, replyNickName, replyDate);
        replyListArea.append(replyRow);

        // Q&A 상세보기 영역
        const currentCommentArea = document.createElement("tr");
        const currentReplyArea = document.createElement("tr");
        currentCommentArea.classList.add("current-detail");
        currentReplyArea.classList.add("current-detail");

        const currentCommentContentArea = document.createElement("td");
        currentCommentContentArea.setAttribute("colspan", "4");
        const currentCommentContent = document.createElement("span");
        currentCommentContent.classList.add("current-comment");
        currentCommentContent.innerText = reply.replyContent;
        currentCommentContentArea.append(currentCommentContent);

        // 로그인한 회원의 따라 수정/삭제 or 신고 버튼
        const btnArea = document.createElement("td");
        if(loginMemberNo==reply.memberNo){
            const updateBtn = document.createElement("span");
            updateBtn.classList.add("clickBtn");
            updateBtn.addEventListener("click", ()=>updateReply(reply, currentCommentArea));
            updateBtn.innerText = "수정";
    
            const deleteBtn = document.createElement("span");
            deleteBtn.classList.add("clickBtn");
            deleteBtn.addEventListener("click", ()=>deleteReply(reply));
            deleteBtn.innerHTML = "삭제";
    
            btnArea.append(updateBtn, " | ", deleteBtn);
        } else {
            const reportBtn = document.createElement("span");
            reportBtn.classList.add("clickBtn")
            reportBtn.addEventListener("click", ()=>reportReviewReply(reply));
            reportBtn.innerText = "신고";
            btnArea.append(reportBtn);
        }
        
        // 리뷰 댓글 렌더링
        currentCommentArea.append(currentCommentContentArea, btnArea);
        replyListArea.append(currentCommentArea);

        const childReply = reply.commentList[0];
        if(childReply!=null){
            const currentReplyContentArea = document.createElement("td");
            currentReplyContentArea.setAttribute("colspan", "3");
            const currentReplyContent = document.createElement("span");
            currentReplyContent.classList.add("current-reply");
            currentReplyContent.innerText = childReply.replyContent;
            currentReplyContentArea.append(currentReplyContent);

            // 로그인한 회원의 따라 수정/삭제 or 신고 버튼
            if(loginMemberNo==childReply.memberNo){
                const updateBtn = document.createElement("span");
                updateBtn.classList.add("clickBtn");
                updateBtn.addEventListener("click", ()=>updateReply(childReply, currentReplyArea));
                updateBtn.innerText = "수정";
        
                const deleteBtn = document.createElement("span");
                deleteBtn.classList.add("clickBtn");
                deleteBtn.addEventListener("click", ()=>deleteReply(childReply));
                deleteBtn.innerHTML = "삭제";
        
                currentReplyContentArea.append(" | ", updateBtn, " | ", deleteBtn);
            } else {
                const reportBtn = document.createElement("span");
                reportBtn.classList.add("clickBtn")
                reportBtn.addEventListener("click", ()=>reportReviewReply(childReply));
                reportBtn.innerText = "신고";
                currentReplyContentArea.append(" | ", reportBtn);
            }
            
            const currentReplyNickname = document.createElement("td");
            currentReplyNickname.innerText = childReply.memberNickname;
            const currentReplyDate = document.createElement("td");
            currentReplyDate.innerText = formatDate(childReply.replyCreatedDate);
            currentReplyArea.append(currentReplyContentArea, currentReplyNickname, currentReplyDate);
            replyListArea.append(currentReplyArea);
        } else {
            // 리뷰 댓글이 없는 경우(판매자가 답글 등록 가능)
            if(loginMemberNo==boardMemberNo){
                const currentReplyContentArea = document.createElement("td");
                currentReplyContentArea.setAttribute("colspan", "4");
                
                const currentReplyContent = document.createElement("textarea");
                currentReplyContent.style.width = "100%";
                currentReplyContent.style.height = "100px";
                currentReplyContent.style.resize = "none";
                currentReplyContentArea.append(currentReplyContent);

                const btnArea = document.createElement("td");
                btnArea.innerText = "등록";
                btnArea.classList.add("clickBtn");
                btnArea.addEventListener("click", ()=>insertChildReply(reply, currentReplyContent));
                
                currentReplyArea.append(currentReplyContentArea, btnArea);
                replyListArea.append(currentReplyArea);
            }
        }
    }

    // Q&A 페이지네이션
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

// 리뷰 내용 클릭 시 모달창을 보여주는 함수
const modalShow = review=>{
    // 모달 보이기
    modal.style.display = "flex";
    // 에니메이션 효과를 위한 딜레이 함수
    setTimeout(() => {
        modal.classList.remove("hide");
        modal.classList.add("show");
    }, 10);
    
    const modalImgArea = document.getElementsByClassName("modal-img-area")[0];
    const ratingArea = document.getElementsByClassName("rating-area")[0];
    const userArea = document.getElementsByClassName("user-area")[0];
    const reviewOptionArea = document.getElementsByClassName("review-option-area")[0];
    const reviewContent = document.getElementsByClassName("review-content")[0];
    const replyMemberArea = document.getElementById("replyMemberArea");
    const replyContentArea = document.getElementById("replyContentArea");
    
    modalImgArea.innerHTML = ""; // 이미지 영역 초기화
    const imageList = review.imageList;

    // 이미지가 없으면 상품 썸네일 이미지 출력
    if(imageList.length===0){
        const img = document.createElement("img");
        img.src = review.businessThumbnail;
        modalImgArea.append(img);
    }

    // 이미지가 있을 경우 모두 렌더링
    imageList.forEach(image=>{
        const img = document.createElement("img");
        img.src = image.imagePath + image.imageReName;
        modalImgArea.append(img);
    });
    
    ratingArea.innerHTML = ""; // 별점 영역 초기화
    // 별점 개수만큼 별 아이콘 추가
    for(let i=1;i<6;i++){
        const star = document.createElement("i");
        star.classList.add("fa-star");
        // 선택된 별점은 solid, 아닌 것은 regular로 처리
        if(i<=review.reviewStar){
            star.classList.add("fa-solid");
        } else {
            star.classList.add("fa-regular");
        }
        ratingArea.append(star);
    }
    
    // 별점 숫자 추가
    const span = document.createElement("span");
    span.innerText = review.reviewStar;
    ratingArea.append(span);

    // 유저 정보 영역
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

    // 로그인한 회원이 작성자일 경우 수정/삭제 버튼 제공
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
        // 다른 회원일 경우 신고 버튼 제공
        const reportBtn = document.createElement("span");
        reportBtn.classList.add("clickBtn")
        reportBtn.addEventListener("click", ()=>reportReview(review));
        reportBtn.innerText = "신고";
        userArea.append(reportBtn);
    }

    // 옵션명 및 구매 수량 표시
    reviewOptionArea.innerHTML = "";
    const reviewOption = document.createElement("span");
    reviewOption.innerText = review.optionName+" - "+review.quantity;
    reviewOptionArea.append(reviewOption);

    // 리뷰 내용 출력
    reviewContent.innerText = review.reviewContent;

    // 리뷰 답글이 존재하는 경우
    if(review.replyList.length!=0){
        replyMemberArea.innerHTML = "";
        replyContentArea.innerHTML = "";
        const replyMember = document.createElement("span");
        replyMember.innerText = review.replyList[0].memberNickname + " | " +
                                formatDate(review.replyList[0].replyCreatedDate);
    
        replyMemberArea.append(replyMember, " | ");
        // 로그인한 회원이 댓글 작성자일 경우 수정/삭제 버튼 제공
        if(loginMemberNo==review.replyList[0].memberNo){
            const editBtn = document.createElement("span");
            editBtn.classList.add("clickBtn");
            editBtn.addEventListener("click", ()=>updateReviewReply(review.replyList[0]));
            editBtn.innerText = "수정";
    
            const deleteBtn = document.createElement("span");
            deleteBtn.classList.add("clickBtn");
            deleteBtn.addEventListener("click", ()=>deleteReviewReply(review.replyList[0]));
            deleteBtn.innerText = "삭제";
    
            replyMemberArea.append(editBtn, " | ", deleteBtn);
        } else {
            // 다른 회원일 경우 신고 버튼 제공
            const replyReport = document.createElement("span");
            replyReport.classList.add("clickBtn");
            replyReport.addEventListener("click", ()=>reportReviewReply(review.replyList[0]));
            replyReport.innerText = "신고";
            replyMemberArea.append(replyReport);
        }
    
        // 답글 내용 출력
        const replyContent = document.createElement("div");
        replyContent.innerText = review.replyList[0].replyContent;
    
        replyContentArea.append(replyContent);
    } else {
        // 댓글이 없고 로그인한 회원이 판매자일 경우 댓글 입력창 제공
        if(boardMemberNo===loginMemberNo){
            replyMemberArea.innerHTML = "";
            replyContentArea.innerHTML = "";
            const replyContent = document.createElement("textarea");
            replyContent.style.width = "100%";
            replyContent.style.height = "200px";
            replyContent.style.resize = "none";

            const replyBtn = document.createElement("span");
            replyBtn.classList.add("clickBtn", "reply-btn");
            replyBtn.addEventListener("click", ()=>insertReviewReply(review.reviewNo, replyContent));
            replyBtn.innerText = "댓글 등록";
            replyContentArea.append(replyContent, replyBtn);
        }
    }
};

// 모달창 클릭 시
modal.addEventListener("click", e=>closeModal(e));

// 모달창 닫기 함수
const closeModal = e=>{
    // 이벤트 발생 대상이 모달창 자체 또는 닫기 버튼이 아닐 경우 함수 종료
    if(e.target!==modal&&e.target!==closeModalBtn) return;

    // 모달 닫힘 애니메이션 클래스 적용
    modal.classList.add("hide");
    modal.classList.remove("show");

    // 애니메이션이 끝난 후 display를 none으로 바꿔 시각적으로 완전히 숨김
    modal.addEventListener("transitionend", function hideModal() {
        modal.style.display = "none";
        // transitionend 이벤트가 중복으로 발생하지 않도록 이벤트 리스너 제거
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
//   console.log(reviewNo);
  if (reviewNo == 0) {
    setTimeout(()=>{
    openPopup('view');
    }, 800);
  }
} , 150);

// Q&A 상세 내역 열기 함수
const currentQNA = replyRow=>{
    // 현재 클릭된 Q&A 행(replyRow)의 다음 요소(상세 내역)
    const existingComment = replyRow.nextElementSibling;
    const tdList = existingComment.querySelectorAll("td");
    // 현재 큭릭된 Q&A 행(replyRow)의 다음 요소(Q&A 답변)
    const nextSibling = existingComment.nextElementSibling;
    const tds = nextSibling?.querySelectorAll("td") || []

    // 이미 열력 있다면 닫기 처리
    if(existingComment.classList.contains("show")){
        // 열려있는 상태 해제
        existingComment.classList.remove("show");
        tdList.forEach(td => td.style.display = "none");
        if(existingComment.nextElementSibling?.classList.contains("current-detail")){
            existingComment.nextElementSibling.classList.remove("show");
            tds.forEach(td => td.style.display = "none");
        }
        // 현재 선택된 Q&A 행의 강조 표시 제거
        replyRow.classList.remove("qna-current");
    } else {
        // 닫혀있는 행 열기
        tdList.forEach(td => td.style.display = "table-cell");
        existingComment.classList.add("show");
        if(existingComment.nextElementSibling?.classList.contains("current-detail")){
            tds.forEach(td => {
                td.style.display = "table-cell"
                td.style.borderTop = "2px solid #999999"; // 구분선 추가
            });
            existingComment.nextElementSibling.classList.add("show");
        }
        // 현재 선택된 Q&A 행에 강조 표시 추가
        replyRow.classList.add("qna-current");
    }
};

// 팝업창 열기 함수
const openPopup=async(key, item)=>{
    let popupUrl = location.pathname + "/insertRe" + key;
    let fetchUrl = `${location.pathname}/selectOrder`;

    if (key === "view") {
        if(item){
            fetchUrl+=`?reviewNo=${item.reviewNo}`;
            popupUrl += "&reviewNo="+item.reviewNo;
        }
        try {
            const resp = await fetch(fetchUrl);
            
            // 응답이 비어있는 경우 대비 (예: 서버에서 빈 응답을 보낸 경우)
            const text = await resp.text();
            if (!text.trim() || text === "null") {
                throw new Error("작성하지 않은 주문 내역의 리뷰가 없습니다..");
            }
        
            // JSON 변환 시도
            let order;
            try {
                order = JSON.parse(text);
            } catch (parseError) {
                throw new Error("JSON 파싱 오류: 서버에서 올바른 데이터를 보내지 않았습니다.");
            }
        
            if (order && order.orderNo) {
                popupUrl += "?orderNo=" + order.orderNo;
            } else {
                alert("주문 전이거나 작성한 리뷰는 다시 작성할 수 없습니다.");
                return;
            }
        } catch (err) {
            console.error("주문 정보 조회 실패:", err);
            alert(err.message);
            return;
        }
    }

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
        popupUrl, 
        "PopupWindow", 
        `width=${popupWidth},height=${popupHeight},left=${left},top=${top}`
    );
};

// 리뷰 댓글 등록
const insertReviewReply=(reviewNo, replyContent)=>{
    if(replyContent.value.trim().length==0){
        alert("댓글 내용을 작성해주세요.");
        replyContent.focus();
        return;
    }

    // 리뷰 댓글 등록 요청(비동기)
    fetch(`${location.pathname}/reviewReply`,{
        method: "post",
        headers:{"Content-Type":"application/json"},
        body:JSON.stringify({
            "replyTypeNo":reviewNo,
            "replyContent":replyContent.value,
            "memberNo":loginMemberNo
        })
    })
    .then(resp=>resp.json())
    .then(review=>{
        if(review!=null) {
            alert("댓글 등록 성공");
            // 모달창 업데이트
            modalShow(review);
        } else {
            alert("댓글 등록 실패");
        }
    })
    .catch(err=>console.log(err));
};

// 리뷰 신고 보내기
const reportReview = review=>{
    const reviewNo = review.reviewNo;            
    const reportedUserNo = review.memberNo;    
    const reporterName = loginMember.memberNick; 

    // 신고용 모달창 열기
    openReportModal(5, reviewNo, reportedUserNo, reporterName);
};

// 리뷰 댓글 신고 보내기
const reportReviewReply = reply=>{
    const replyNo = reply.replyNo;            
    const reportedUserNo = reply.memberNo;    
    const reporterName = loginMember.memberNick; 
  
    // type = 3: 댓글 신고
    openReportModal(3, replyNo, reportedUserNo, reporterName);
};

// 리뷰 수정
const updateReview = review=>{
    // 리뷰 수정 팝업창 열기
    openPopup("view", review);
};

// 댓글 수정
const updateReviewReply = reply=>{
    const replyContentArea = document.getElementById("replyContentArea");
    
    replyContentArea.innerHTML = "";
    const replyContent = document.createElement("textarea");
    replyContent.style.width = "100%";
    replyContent.style.height = "200px";
    replyContent.style.resize = "none";
    replyContent.value = reply.replyContent;

    const replyBtn = document.createElement("span");
    replyBtn.classList.add("clickBtn", "reply-btn");
    replyBtn.addEventListener("click", ()=>{
        // 리뷰 댓글 수정 요청(비동기)
        fetch(`${location.pathname}/reviewReply`,{
            method: "PUT",
            headers:{"Content-Type":"application/json"},
            body:JSON.stringify({
                "replyNo":reply.replyNo,
                "replyTypeNo":reply.replyTypeNo,
                "replyContent":replyContent.value
            })
        })
        .then(resp=>resp.json())
        .then(review=>{
            if(review!=null) {
                alert("댓글 수정 성공");
                modalShow(review);
            } else {
                alert("댓글 수정 실패");
            }
        })
        .catch(err=>console.log(err));
    });
    replyBtn.innerText = "댓글 수정";
    replyContentArea.append(replyContent, replyBtn);
};

// 리뷰 삭제
const deleteReview = review=>{
    if(confirm("정말로 삭제 하시겠습니까?")){
        location.href=`${location.pathname}/deleteReview?reviewNo=${review.reviewNo}`;
    }
};

// 댓글 삭제
const deleteReviewReply = reply=>{
    if(!confirm("정말로 삭제 하시겠습니까?")) return;

    // 댓글 삭제 요청(비동기)
    fetch(`${location.pathname}/reviewReply`,{
        method: "DELETE",
        headers:{"Content-Type":"application/json"},
        body:JSON.stringify({
            "replyNo":reply.replyNo,
            "replyTypeNo":reply.replyTypeNo,
        })
    })
    .then(resp=>resp.json())
    .then(review=>{
        if(review!=null) {
            alert("댓글 삭제 성공");
            // 모달창 업데이트
            modalShow(review);
        } else {
            alert("댓글 삭제 실패");
        }
    })
    .catch(err=>console.log(err));
};

// Q&A 수정
const updateReply=(reply, contentArea)=>{
    contentArea.innerHTML = ""; // 수정 영역 초기화
    
    // 댓글 입력 영역(td) 생성
    const replyContentArea = document.createElement("td");
    replyContentArea.style.display = "table-cell";
    replyContentArea.setAttribute("colspan", "5");
    
    // 수정용 textarea 생성
    const replyContent = document.createElement("textarea");
    replyContent.style.width = "100%";
    replyContent.style.height = "100px";
    replyContent.style.resize = "none";
    replyContent.value = reply.replyContent;

    // 버튼 영역 생성
    const btnArea = document.createElement("div");
    btnArea.classList.add("reply-btn-area");

    // 수정 버튼 생성 및 이벤트 추가
    const replyBtn = document.createElement("span");
    replyBtn.classList.add("clickBtn");
    replyBtn.innerText = "수정";
    replyBtn.addEventListener("click", ()=>{
        // 비밀글 여부
        const secretReply = secretReplyStatus.checked?"Y":"N";

        // 댓글 수정 요청(비동기)
        fetch(`${location.pathname}/reply`,{
            method: "PUT",
            headers:{"Content-Type":"application/json"},
            body:JSON.stringify({
                "replyNo":reply.replyNo,
                "replyContent":replyContent.value,
                parentNo:reply.parentNo,
                secretReplyStatus:secretReply
            })
        })
        .then(resp=>resp.json())
        .then(result=>{
            console.log(result)
            if(result!=0) {
                alert("Q&A 수정 성공");
                contentArea.innerHTML = ""; // 기존 영역 초기화
                const currentCommentContentArea = document.createElement("td");
                currentCommentContentArea.style.display = "table-cell";
                const currentCommentContent = document.createElement("span");
                currentCommentContent.classList.add("current-comment");
                currentCommentContent.innerText = replyContent.value;
                currentCommentContentArea.append(currentCommentContent);

                // 수정 버튼
                const updateBtn = document.createElement("span");
                updateBtn.classList.add("clickBtn");
                updateBtn.addEventListener("click", ()=>updateReply(reply, contentArea));
                updateBtn.innerText = "수정";
        
                // 삭제 버튼
                const deleteBtn = document.createElement("span");
                deleteBtn.classList.add("clickBtn");
                deleteBtn.addEventListener("click", ()=>deleteReply(reply));
                deleteBtn.innerHTML = "삭제";
                if(result.parentNo==0){
                    // Q&A일 경우
                    currentCommentContentArea.setAttribute("colspan", "4");
    
                    const btnArea = document.createElement("td");
                    btnArea.style.display="table-cell";
                    btnArea.append(updateBtn, " | ", deleteBtn);
                    contentArea.append(currentCommentContentArea, btnArea);
                } else {
                    // Q&A 댓글일 경우
                    currentCommentContentArea.setAttribute("colspan", "3");
                    currentCommentContentArea.style.borderTop="2px solid rgb(153, 153, 153)";
                    currentCommentContentArea.append(" | ", updateBtn, " | ", deleteBtn);

                    const currentReplyNickname = document.createElement("td");
                    currentReplyNickname.style.display="table-cell";
                    currentReplyNickname.style.borderTop="2px solid rgb(153, 153, 153)";
                    currentReplyNickname.innerText=result.memberNickname;
                    
                    const currentReplyDate = document.createElement("td");
                    currentReplyDate.style.display="table-cell";
                    currentReplyDate.style.borderTop="2px solid rgb(153, 153, 153)";
                    currentReplyDate.innerText=formatDate(result.replyCreatedDate);

                    contentArea.append(currentCommentContentArea, currentReplyNickname, currentReplyDate);
                }
            } else {
                alert("Q&A 수정 실패");
            }
        })
        .catch(err=>console.log(err));
    });

    // 비밀글 체크박스 생성
    const label = document.createElement("label");
    label.classList.add("clickBtn");
    const secretReplyStatus = document.createElement("input");
    secretReplyStatus.type = "checkbox";

    // Q&A 댓글일 경우 비밀글 옵션 숨김
    if(reply.parentNo!=0){
        secretReplyStatus.style.display="none";
    } else {
        label.innerText = "비밀글";
    }
    
    label.append(secretReplyStatus);
    btnArea.append(label, replyBtn);
    replyContentArea.append(replyContent, btnArea);
    contentArea.append(replyContentArea);
};

// Q&A 삭제
const deleteReply=reply=>{
    if(!confirm("정말로 삭제하시겠습니까?")) return;

    // Q&A 삭제 요청(비동기)
    fetch(`${location.pathname}/reply`,{
        method: "DELETE",
        headers:{"Content-Type":"application/json"},
        body:JSON.stringify({
            "replyNo":reply.replyNo,
        })
    })
    .then(resp=>resp.json())
    .then(result=>{
        if(result!=0) {
            alert("댓글 삭제 성공");
            // 화면 새로고침
            location.reload();
        } else {
            alert("댓글 삭제 실패");
        }
    })
    .catch(err=>console.log(err));
};

// Q&A 답글 등록
const insertChildReply=(reply, replyContent)=>{
    // Q&A 답글 동록 요청(비동기)
    fetch(`${location.pathname}/reply`,{
        method: "post",
        headers:{"Content-Type":"application/json"},
        body:JSON.stringify({
            "replyContent":replyContent.value,
            secretReplyStatus:"N",
            "memberNo":loginMemberNo,
            replyType:1,
            replyTypeNo:reply.replyTypeNo,
            "parentNo":reply.replyNo
        })
    })
    .then(resp=>resp.json())
    .then(childReply=>{
        if(childReply!=null) {
            alert("답글 등록 성공");
            const currentReplyArea = replyContent.parentElement.parentElement;
            currentReplyArea.innerHTML = ""; // 기존 답글 작성 영역 초기화

            // 답글 내용 영역(td) 생성
            const currentReplyContentArea = document.createElement("td");
            currentReplyContentArea.style.display = "table-cell";
            currentReplyContentArea.style.borderTop = "2px solid rgb(153, 153, 153)";
            currentReplyContentArea.setAttribute("colspan", "3");
            const currentReplyContent = document.createElement("span");
            currentReplyContent.classList.add("current-reply");
            currentReplyContent.innerText = childReply.replyContent;
            currentReplyContentArea.append(currentReplyContent);

            // 수정 버튼 생성
            const updateBtn = document.createElement("span");
            updateBtn.classList.add("clickBtn");
            updateBtn.addEventListener("click", ()=>updateReply(childReply, currentReplyArea));
            updateBtn.innerText = "수정";
    
            // 삭제 버튼 생성
            const deleteBtn = document.createElement("span");
            deleteBtn.classList.add("clickBtn");
            deleteBtn.addEventListener("click", ()=>deleteReply(childReply));
            deleteBtn.innerHTML = "삭제";
    
            currentReplyContentArea.append(" | ", updateBtn, " | ", deleteBtn);
            
            const currentReplyNickname = document.createElement("td");
            currentReplyNickname.style.display="table-cell";
            currentReplyNickname.style.borderTop = "2px solid rgb(153, 153, 153)";
            currentReplyNickname.innerText = childReply.memberNickname;
            const currentReplyDate = document.createElement("td");
            currentReplyDate.style.display="table-cell";
            currentReplyDate.style.borderTop = "2px solid rgb(153, 153, 153)";
            currentReplyDate.innerText = formatDate(childReply.replyCreatedDate);
            currentReplyArea.append(currentReplyContentArea, currentReplyNickname, currentReplyDate);
        } else {
            alert("답글 등록 실패");
        }
    })
    .catch(err=>console.log(err));
};

// 상품 옵션
let totalPrice = 0;
let totalCount = 0;
// 상품 옵션에 이벤트 추가
productOptions.forEach(select => {
    select.addEventListener("change", e=>changeOption(e));
});

// 상품 옵션 동기화 함수
const changeOption = e=>{
    let selectOption = e.target.value;
    if (selectOption === "default") return;
    
    // 모든 select 요소를 찾아서 동기화
    productOptions.forEach(select => {
        select.value = selectOption;
    });

    selectOption = selectOption.split("-")[1];
    const choiceLists = document.querySelectorAll(".choice-option-area");

    // 기존 옵션이 있는 경우 삭제 후 추가
    if (document.querySelector(".choice-option-area tr")) {
        const confirmDelete = confirm("이미 선택된 옵션이 있습니다. 새로운 옵션을 선택하면 기존 옵션이 삭제됩니다. 계속하시겠습니까?");
        if (!confirmDelete) {
            e.target.value = "default"; // 선택 취소
            return;
        }
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
        list.innerHTML = "";
        list.append(clonedRow);

        const clonedInput = clonedRow.querySelector("input");
        const clonedSpan = clonedRow.querySelector("span");
        const clonedPrice = clonedRow.querySelector("td:last-child");

        // 수량 변경 이벤트 추가
        clonedInput.addEventListener("change", () => updateOptionPrice(clonedInput, clonedPrice));

        // 삭제 이벤트 추가
        clonedSpan.addEventListener("click", removeAllOptions);
    });

    // 총 금액 업데이트 함수 호출
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
    
    // 총 금액 업데이트 함수 호출
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
    
    // 총 금액, 수량 동기화
    totalPriceAreas.forEach(totalPriceArea=>{totalPriceArea.innerText = totalPrice});
    totalCountAreas.forEach(totalCountArea=>totalCountArea.innerText = totalCount);
};

// 옵션바 클릭 시 옵션 영역 표시/숨김 토글 함수
const changeOptionBar=changeOptionBar=>{
    const optionArea = document.getElementsByClassName("fixed-option-area")[0];
    // 옵션 영역이 보이지 않는 경우(초기 상태 또는 숨김 상태)
    if(!optionArea.classList.contains("show")){
        changeOptionBar.innerText = "옵션보기<";
        optionArea.classList.add("show");
        return;
    }

    // 옵션 영역이 보이는 경우(토글 off)
    changeOptionBar.innerText = "옵션보기>";
    optionArea.classList.remove("show");
};

// 상품 구매
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

        // 주문/결제 페이지로 요청
        window.location.href = `${location.pathname}/order?option=${productOptions[0].value}&quantity=${input.value}`;
    });
});

// 상품 삭제
document.getElementById("deleteBusiness")?.addEventListener("click", ()=>{
    if(confirm("상품을 삭제하시겠습니까?")){
        // 상품 삭제 요청
        location.href = `${location.pathname}/delete`;
    }
});

// 상품 수정
document.getElementById("updateBusiness")?.addEventListener("click", ()=>{
    if(confirm("상품을 수정하시겠습니까?")){
        // 상품 수정 페이지로 요청
        location.href = `${location.pathname}/update`;
    }
});

// 신고 모달 열기
function openReportModal(type, typeNo, reportedUserNo, reporterName) {
    window.reportType = type;
    window.reportTypeNo = typeNo;
    window.reportedUserNo = reportedUserNo;
    // 신고자 이름 채우기
    document.getElementById("reporterName").innerText = reporterName;

    // 제목/내용 초기화
    document.getElementById("reportTitle").value = "";
    document.getElementById("reportReason").innerText = "";
  
    // 모달 보이기
    const modal = document.getElementById("reportModal");
    if (modal) {
      modal.classList.remove("hidden");
      modal.classList.add("show"); // 선택사항: transition 효과 줄 거면
    } else {
      console.warn("❗ 모달을 찾을 수 없습니다: #reportModal");
    }
}
  
// 신고 모달 닫기
function closeReportModal() {
    const modal = document.getElementById("reportModal");
    if (modal) {
        modal.classList.add("hidden");
        modal.classList.remove("show");
    }
}
  
//신고 제출
function submitReport() {
    const title = document.getElementById("reportTitle").value.trim();
    const detail = document.getElementById("reportReason").innerText.trim();
  
    if (!title || !detail) {
      alert("제목과 내용을 모두 입력해주세요.");
      return;
    }
  
    const data = {
      reportType: window.reportType,
      reportTypeNo: window.reportTypeNo,
      reportedUserNo: window.reportedUserNo,
      reportTitle: title,
      reportDetail: detail
    };
  
    fetch("/report/submit", {
      method: "POST",
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify(data)
    })
    .then(res => res.json())
    .then(result => {
    if (result.success) {
        alert("신고가 접수되었습니다.");
        closeReportModal();
    } else {
        alert("신고 실패: " + result.message);
    }
    })
    .catch(err => {
    console.error("❌ 신고 중 오류 발생", err);
    alert("오류가 발생했습니다.");
    });
}

// 관심 상품 처리
const pickProduct = document.getElementById("pickProduct");
pickProduct?.addEventListener("click", e=>{
    if(loginMemberNo==""){
        alert("로그인 후 이용해주세요.");
        return;
    }
    let check;
    // ♡가 채워져 있을 경우
    if(e.target.classList.contains("fa-regular")) {
        check=0;
    } else {
        check=1;
    }
    const data={boardNo:boardNo, memberNo:loginMemberNo, check:check};
    // 관심 상품 처리 요청(비동기)
    fetch(`/board/${boardCode}/pick`, {
        method:"post",
        headers:{"Content-Type":"application/json"},
        body:JSON.stringify(data)
    })
    .then(resp=>resp.text())
    .then(count=>{
        if(count==-1) {
            alert("찜하기 처리 실패");
            return;
        }
        e.target.classList.toggle("fa-regular");
        e.target.classList.toggle("fa-solid");
    })
    .catch(err=>console.log(err));
});