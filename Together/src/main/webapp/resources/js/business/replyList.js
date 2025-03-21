console.log("replyList.js");

const myQNA = document.getElementById("myQNA");
const notSecret = document.getElementById("notSecret");

const dateAreas = document.querySelectorAll(".date-area");
const commentAreas = document.querySelectorAll(".comment-area");
document.addEventListener("DOMContentLoaded", ()=>{
    dateAreas.forEach(dateArea=>{
        dateArea.innerText = formatDate(dateArea.getAttribute("data-date"));
    });
    commentAreas.forEach(commentArea=>{
        commentArea.innerText = formatDate(commentArea.getAttribute("data-comment"));
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

const showCommentAreas = document.querySelectorAll(".show-comment-area");
showCommentAreas.forEach(showCommentArea=>{
    showCommentArea.addEventListener("click", ()=>{
        const replyNo = showCommentArea.getAttribute("reply-no");
        const  replyRows = document.querySelectorAll(".replyRow");
        replyRows.forEach(replyRow=>{
            if(replyRow.getAttribute("reply-no")==replyNo){
                currentQNA(replyRow);
            }
        });
    });
});

const loadList = (myQNA, notSecret)=>{
    fetch(`updateList?myQNA=${myQNA}&notSecret=${notSecret}`)
    .then(resp=>resp.json())
    .then(map=>renderList(map))
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
    console.log(map);
    const replyCounts = document.querySelectorAll('a[href="#q&a"] span');
    replyCounts.forEach(replyCount=>{
        let replyListCount=0;
        for(let reply of map.replyList){
            if(reply.parentNo==0){
                replyListCount++;
            }
        }
        replyCount.textContent = replyListCount;
    });

    const replyListArea = document.getElementById("replyListArea");
    const replyList = map.replyList;
    replyListArea.innerHTML = "";

    if(replyList.length==0){
        const replyRow = document.createElement("tr");
        const replyCell = document.createElement("td");
        replyCell.setAttribute("colspan", "5");
        replyCell.innerText = "Q&A가 없습니다.";
        if(myQNA.checked) {
            replyCell.innerText = "내가 작성한 Q&A가 없습니다.";
        }
        if(notSecret.checked) {
            replyCell.innerText = "비밀글을 제외한 Q&A가 없습니다.";
        }
        if(myQNA.checked&&notSecret.checked) {
            replyCell.innerText = "내가 작성한 비밀글을 제외한 Q&A가 없습니다.";
        }
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
    if(replyPagination.maxPage>1){
        replyPaginationArea.innerHTML = "";
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

// 댓글 신고 보내기
const reportReply = reply=>{

};

// 댓글 수정
const editReply = review=>{

};

// 댓글 삭제
const deleteReply = review=>{

};