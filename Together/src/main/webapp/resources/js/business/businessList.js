console.log("businessList.js");

const boardLists = document.querySelectorAll(".boardList");

boardLists.forEach(boardList=>{
    const listToggle = boardList.querySelector(".list-toggle");
    const productImgAreas = boardList.querySelectorAll(".product-img-area");
    listToggle.addEventListener("change", ()=>{
        let classChange;
        if(listToggle.checked){
            classChange = "product-detail-area";
        } else {
            classChange = "product-info";
        }

        productImgAreas.forEach(productImgArea=>{
            const productInfo=productImgArea.nextElementSibling;
            
            productInfo.classList=classChange;
        });
    });
});