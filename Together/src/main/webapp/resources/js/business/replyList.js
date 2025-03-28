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

    loadList(false, false);
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
            reportBtn.addEventListener("click", ()=>reportReply(reply));
            reportBtn.innerText = "신고";
            btnArea.append(reportBtn);
        }
        
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
                reportBtn.addEventListener("click", ()=>reportReply(childReply));
                reportBtn.innerText = "신고";
                currentReplyContentArea.append(" | ", reportBtn);
            }
            
            const currentReplyNickname = document.createElement("td");
            currentReplyNickname.innerText = childReply.memberNickname;
            const currentReplyDate = document.createElement("td");
            currentReplyDate.innerText = formatDate(childReply.replyCreatedDate);
            currentReplyArea.append(currentReplyContentArea, currentReplyNickname, currentReplyDate);
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

// Q&A 신고
const reportReply=reply=>{

};

// Q&A 수정
const updateReply=(reply, contentArea)=>{
    console.log(reply)
    contentArea.innerHTML = "";
    const replyContentArea = document.createElement("td");
    replyContentArea.style.display = "table-cell";
    replyContentArea.setAttribute("colspan", "5");
    const replyContent = document.createElement("textarea");
    replyContent.style.width = "100%";
    replyContent.style.height = "100px";
    replyContent.style.resize = "none";
    replyContent.value = reply.replyContent;

    const btnArea = document.createElement("div");
    btnArea.classList.add("reply-btn-area");
    const replyBtn = document.createElement("span");
    replyBtn.classList.add("clickBtn");
    replyBtn.innerText = "수정";
    replyBtn.addEventListener("click", ()=>{
        const secretReply = secretReplyStatus.checked?"Y":"N";
        fetch(`/board/2/${reply.replyTypeNo}/reply`,{
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
            if(result!=0) {
                alert("Q&A 수정 성공");
                contentArea.innerHTML = "";
                const currentCommentContentArea = document.createElement("td");
                currentCommentContentArea.style.display = "table-cell";
                const currentCommentContent = document.createElement("span");
                currentCommentContent.classList.add("current-comment");
                currentCommentContent.innerText = replyContent.value;
                currentCommentContentArea.append(currentCommentContent);

                const updateBtn = document.createElement("span");
                updateBtn.classList.add("clickBtn");
                updateBtn.addEventListener("click", ()=>updateReply(reply, contentArea));
                updateBtn.innerText = "수정";
        
                const deleteBtn = document.createElement("span");
                deleteBtn.classList.add("clickBtn");
                deleteBtn.addEventListener("click", ()=>deleteReply(reply));
                deleteBtn.innerHTML = "삭제";
                if(result.parentNo==0){
                    currentCommentContentArea.setAttribute("colspan", "4");
    
                    const btnArea = document.createElement("td");
                    btnArea.style.display="table-cell";
                    btnArea.append(updateBtn, " | ", deleteBtn);
                    contentArea.append(currentCommentContentArea, btnArea);
                } else {
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
    const label = document.createElement("label");
    label.classList.add("clickBtn");
    const secretReplyStatus = document.createElement("input");
    secretReplyStatus.type = "checkbox";
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

    fetch(`/board/2/${reply.replyTypeNo}/reply`,{
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
            location.reload();
        } else {
            alert("댓글 삭제 실패");
        }
    })
    .catch(err=>console.log(err));
};