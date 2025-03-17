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

const renderList=list=>{
    console.log(list);
}