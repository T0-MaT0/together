console.log("reviewList.js");

const dateAreas = document.querySelectorAll(".date-area");
const commentAreas = document.querySelectorAll(".comment-area");
document.addEventListener("DOMContentLoaded", ()=>{
    dateAreas.forEach(dateArea=>{
        dateArea.innerText = formatDate(dateArea.getAttribute("data-date"));
    });
});

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

const showModalAreas = document.querySelectorAll(".show-modal-area");
const modal = document.getElementsByClassName("modal")[0];
const closeModalBtn = document.getElementById("closeModalBtn");

showModalAreas.forEach(showModalArea=>{
    showModalArea.addEventListener("click", ()=>{
        const reviewNo = parseInt(showModalArea.getAttribute("review-no"));
        const review = reviewList.find(review=>review.reviewNo===reviewNo);
        // console.log(review)

        modal.style.display = "flex";
        setTimeout(() => {
            modal.classList.remove("hide");
            modal.classList.add("show");
        }, 10);

        const modalImgArea = document.getElementsByClassName("modal-img-area")[0];
        const ratingArea = document.getElementsByClassName("rating-area")[0];
        const userArea = document.getElementsByClassName("user-area")[0];
        const reviewContent = document.getElementsByClassName("review-content")[0];
        const reviewOptionArea = document.getElementsByClassName("review-option-area")[0];
        const replyMemberArea = document.getElementById("replyMemberArea");
        const replyContentArea = document.getElementById("replyContentArea");
        const goToDetail = document.getElementById("goToDetail");

        modalImgArea.innerHTML = "";
        const imageList = review.imageList;

        if(imageList.length===0){
            const img = document.createElement("img");
            img.src = review.businessThumbnail;
            modalImgArea.append(img);
        }

        imageList.forEach(image => {
            const img = document.createElement("img");
            img.src = image.imagePath + image.imageReName;
            modalImgArea.append(img);
        });

        ratingArea.innerHTML = "";
        for (let i = 1; i < 6; i++) {
            const star = document.createElement("i");
            star.classList.add("fa-star");
            if (i <= review.reviewStar) {
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
        if (review.memberProfile == null) {
            profile.src = "/resources/images/mypage/관리자 프로필.webp";
        } else {
            profile.src = review.memberProfile;
        }

        const memberNickname = document.createElement("span");
        memberNickname.innerText = review.memberNickname;

        const reviewCreatedDate = document.createElement("span");
        reviewCreatedDate.innerText = formatDate(review.reviewCreatedDate);

        userArea.append(profile, memberNickname, reviewCreatedDate);

        if (loginMemberNo == review.memberNo) {
            const editBtn = document.createElement("span");
            editBtn.classList.add("clickBtn");
            editBtn.addEventListener("click", () => updateReview(review));
            editBtn.innerText = "수정";

            const deleteBtn = document.createElement("span");
            deleteBtn.classList.add("clickBtn");
            deleteBtn.addEventListener("click", () => deleteReview(review));
            deleteBtn.innerText = "삭제";

            userArea.append(editBtn, deleteBtn);
        } else {
            const reportBtn = document.createElement("span");
            reportBtn.classList.add("clickBtn")
            reportBtn.addEventListener("click", () => reportReview(review));
            reportBtn.innerText = "신고";
            userArea.append(reportBtn);
        }

        reviewOptionArea.innerHTML = "";
        const reviewOption = document.createElement("span");
        reviewOption.innerText = review.optionName+" - "+review.quantity;
        reviewOptionArea.append(reviewOption);

        reviewContent.innerHTML = review.reviewContent;
        if(review.replyList.length!=0){
            replyMemberArea.innerHTML = "";
            replyContentArea.innerHTML = "";
            const replyMember = document.createElement("span");
            replyMember.innerText = review.replyList[0].memberNickname + " | " +
                formatDate(review.replyList[0].replyCreatedDate);
    
            replyMemberArea.append(replyMember, " | ");
            if (loginMemberNo == review.replyList[0].memberNo) {
                const editBtn = document.createElement("span");
                editBtn.classList.add("clickBtn");
                editBtn.addEventListener("click", () => updateReviewReply(review.replyList[0]));
                editBtn.innerText = "수정";
    
                const deleteBtn = document.createElement("span");
                deleteBtn.classList.add("clickBtn");
                deleteBtn.addEventListener("click", () => deleteReviewReply(review.replyList[0]));
                deleteBtn.innerText = "삭제";
    
                replyMemberArea.append(editBtn, " | ", deleteBtn);
            } else {
                const replyReport = document.createElement("span");
                replyReport.classList.add("clickBtn");
                replyReport.addEventListener("click", () => reportReviewReply(review.replyList[0]));
                replyReport.innerText = "신고";
                replyMemberArea.append(replyReport);
            }
    
            const replyContent = document.createElement("div");
            replyContent.innerText = review.replyList[0].replyContent;
    
            replyContentArea.append(replyContent);
        }

        goToDetail.setAttribute("href", `/board/2/${review.reviewTypeNo}`);
    });
});

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

// 팝업창 열기
const openPopup=async(key, item)=>{
    let popupUrl = `/board/2/${item.reviewTypeNo}/insertRe${key}`;
    let fetchUrl = `/board/2/${item.reviewTypeNo}/selectOrder?reviewNo=${item.reviewNo}`;

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
    if(item){
        popupUrl += "&reviewNo="+item.reviewNo;
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

// 리뷰 신고 보내기
const reportReview = review=>{
    
};

// 리뷰 댓글 신고 보내기
const reportReviewReply = reply=>{

};

// 리뷰 수정
const updateReview = review=>{
    openPopup("view", review);
};

// 리뷰 댓글 수정
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
        fetch(`/board/2/${reply.reviewTypeNo}/reviewReply`,{
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
        location.href=`/board/2/${review.reviewTypeNo}/deleteReview?reviewNo=${review.reviewNo}`;
    }
};

// 댓글 삭제
const deleteReviewReply = reply=>{
    if(!confirm("정말로 삭제 하시겠습니까?")) return;

    fetch(`/board/2/${reply.reviewTypeNo}/reviewReply`,{
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
            modalShow(review);
        } else {
            alert("댓글 삭제 실패");
        }
    })
    .catch(err=>console.log(err));
};