console.log("businessDetail.js");

document.addEventListener("DOMContentLoaded", ()=>{
    loadList();
});

const loadList = ()=>{
    fetch(location.pathname+"/list")
    .then(resp=>resp.json())
    .then(list=>renderList(list))
    .catch(err=>console.log(err));
};

const renderList=map=>{
    console.log(map);
    const reviewCounts = document.querySelectorAll('.content-nav a[href="#review"] span');
    const replyCounts = document.querySelectorAll('.content-nav a[href="#q&a"] span');
    reviewCounts.forEach(reviewCount=>{
        reviewCount.textContent = map.reviewPagination.listCount;
    });
    replyCounts.forEach(replyCount=>{
        replyCount.textContent = map.replyPagination.listCount;
    });
}