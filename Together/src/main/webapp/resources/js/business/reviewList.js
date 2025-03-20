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
        console.log(review)

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
        const goToDetail = document.getElementById("goToDetail");

        modalImgArea.innerHTML = "";
        const imageList = review.imageList;
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

        // 옵션 내용 추가 예정

        reviewContent.innerText = review.reviewContent;

        replyMemberArea.innerHTML = "";
        replyContentArea.innerHTML = "";
        const replyMember = document.createElement("span");
        replyMember.innerText = review.replyList[0].memberNickname + " | " +
            formatDate(review.replyList[0].replyCreatedDate);

        replyMemberArea.append(replyMember, " | ");
        if (loginMemberNo == review.replyList[0].memberNo) {
            const editBtn = document.createElement("span");
            editBtn.classList.add("clickBtn");
            editBtn.addEventListener("click", () => editReply(review.replyList[0]));
            editBtn.innerText = "수정";

            const deleteBtn = document.createElement("span");
            deleteBtn.classList.add("clickBtn");
            deleteBtn.addEventListener("click", () => deleteReply(review.replyList[0]));
            deleteBtn.innerText = "삭제";

            replyMemberArea.append(editBtn, " | ", deleteBtn);
        } else {
            const replyReport = document.createElement("span");
            replyReport.classList.add("clickBtn");
            replyReport.addEventListener("click", () => reportReply(review.replyList[0]));
            replyReport.innerText = "신고";
            replyMemberArea.append(replyReport);
        }

        const replyContent = document.createElement("div");
        replyContent.innerText = review.replyList[0].replyContent;

        replyContentArea.append(replyContent);

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

// 리뷰 신고 보내기
const reportReview = review=>{
    
};

// 리뷰 수정
const updateReview = review=>{

};

// 리뷰 삭제
const deleteReview = review=>{

};