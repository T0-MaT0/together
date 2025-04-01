console.log("businessList.js");

const boardLists = document.querySelectorAll(".boardList");
const bannerImg = document.getElementById("bannerImg");

// 배너 이미지 삽입
let index = 0;
document.addEventListener("DOMContentLoaded", () => {
    console.log(bannerList);

    // 초기 배너 설정
    updateBanner();

    // 3초마다 배너 변경
    setInterval(() => {
        index = (index + 1) % bannerList.length; // 마지막 배너 후 처음으로 순환
        updateBanner();
    }, 3000);
});

// 배너 업데이트 함수
function updateBanner() {
    let banner = bannerList[index].imagePath + bannerList[index].imageReName;
    bannerImg.setAttribute("src", banner);
};

boardLists.forEach(boardList=>{
    let listToggle = boardList.querySelector(".list-toggle");
    let productImgAreas = boardList.querySelectorAll(".product-img-area");
    
    listToggle.addEventListener("change", ()=>{
        productImgAreas.forEach(productImgArea=>{
            let productInfo=productImgArea.nextElementSibling;
            let productImg=productImgArea.querySelector("img");
            
            if(listToggle.checked){
                productInfo.classList.add("product-detail-area");
                setTimeout(()=>{
                    productInfo.classList.add("show");
                }, 1);
                productInfo.classList.remove("product-info");

                productImg.addEventListener("mouseover", imgScaleUp);
                productImg.addEventListener("mouseleave", imgScaleDown);

                productInfo.removeEventListener("mouseover", infoHover);
                productInfo.removeEventListener("mouseleave", infoLeave);
            } else {
                productInfo.classList.remove("show");
                setTimeout(()=>{
                    productInfo.classList.remove("product-detail-area");
                    productInfo.classList.add("product-info");
                }, 500)

                productInfo.addEventListener("click", productInfoClick);
                productInfo.addEventListener("mouseover", infoHover);
                productInfo.addEventListener("mouseleave", infoLeave);
            }
        });
    });

    function productInfoClick(e){
        window.location.href=e.target.getAttribute("url");
    }

    function imgScaleUp(event){
        const productImg = event.currentTarget;
        productImg.style.transform = "scale(1.2)";
    }

    function imgScaleDown(event){
        const productImg = event.currentTarget;
        productImg.style.transform = "scale(1)";
    }

    function infoHover(event) {
        const productImg = event.currentTarget.previousElementSibling.querySelector("img"); 
        productImg.style.transform = "scale(1.2)";
    }

    function infoLeave(event) {
        const productImg = event.currentTarget.previousElementSibling.querySelector("img"); 
        productImg.style.transform = "scale(1)";
    }

    productImgAreas.forEach(productImgArea=>{
        const productInfo=productImgArea.nextElementSibling;
        
        productInfo.addEventListener("click", productInfoClick);
        productInfo.addEventListener("mouseover", infoHover);
        productInfo.addEventListener("mouseleave", infoLeave);
    });
});