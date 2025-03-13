console.log("businessList.js");

const boardLists = document.querySelectorAll(".boardList");

boardLists.forEach(boardList=>{
    const listToggle = boardList.querySelector(".list-toggle");
    const productImgAreas = boardList.querySelectorAll(".product-img-area");
    
    listToggle.addEventListener("change", ()=>{
        let classChange = "product-info";
        if(listToggle.checked){
            classChange = "product-detail-area";
        } else {
            classChange = "product-info";
        }
        
        productImgAreas.forEach(productImgArea=>{
            const productInfo=productImgArea.nextElementSibling;
            const productImg=productImgArea.firstElementChild.firstElementChild;
            productInfo.classList=classChange;

            if(classChange=="product-detail-area"){
                productInfo.replaceWith(productInfo.cloneNode(true));
                productImg.addEventListener("mouseover", ()=>
                    productImgScaleUp(productImg));
                productImg.addEventListener("mouseleave", ()=>
                    productImgScaleDown(productImg));
            } else {
                productInfo.addEventListener("click", productInfoClick);
                productInfo.addEventListener("mouseover", ()=>
                    productImgScaleUp(productImg));
                productInfo.addEventListener("mouseleave", ()=>
                    productImgScaleDown(productImg));
            }
        });
    });

    function productInfoClick(){
        window.location.href="#"
    }

    function productImgScaleUp(productImg){
        productImg.style.transform="scale(1.2)";
    }

    function productImgScaleDown(productImg){
        productImg.style.transform="scale(1)";
    }

    productImgAreas.forEach(productImgArea=>{
        const productInfo=productImgArea.nextElementSibling;
        const productImg=productImgArea.firstElementChild.firstElementChild;
        productInfo.addEventListener("click", productInfoClick);
        productInfo.addEventListener("mouseover", ()=>productImgScaleUp(productImg));
        productInfo.addEventListener("mouseleave", ()=>productImgScaleDown(productImg));
    });
});