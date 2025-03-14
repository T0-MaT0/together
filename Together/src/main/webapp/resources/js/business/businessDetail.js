console.log("businessDetail.js");

document.addEventListener("DOMContentLoaded", ()=>{
    loadReviewList();
    loadReplyList();
});

const loadReviewList = ()=>{
    fetch(location.pathname+"/reviewList")
    .then(resp=>resp.json())
    .then(list=>renderList(list))
    .catch(err=>console.log(err));
};

const loadReplyList = ()=>{
    fetch(location.pathname+"/replyList")
    .then(resp=>resp.json())
    .then(list=>renderList(list))
    .catch(err=>console.log(err));
};

const renderList=list=>{
    console.log(list);
}