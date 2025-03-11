console.log("businessList.js");

const boardLists = document.querySelectorAll(".boardList");

boardLists.forEach(boardList=>{
    const listToggle = boardList.querySelector(".list-toggle");
    const productImgAreas = boardList.querySelectorAll(".product-img-area");
    listToggle.addEventListener("change", ()=>{
        let classChange;
        let classHidden;
        if(listToggle.checked){
            classChange = "product-detail-area";
            classHidden = "";
        } else {
            classChange = "product-info";
            classHidden = "hidden";
        }

        productImgAreas.forEach(productImgArea=>{
            const productInfo=productImgArea.nextElementSibling;
            const firstChild = productInfo.firstElementChild;
            
            productInfo.classList=classChange;
            firstChild.classList = classHidden;
        });
    });
});