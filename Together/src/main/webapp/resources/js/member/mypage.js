console.log("mypage.js");





// 비동기 


// 구매 이력
const purchaseHistory = document.getElementById("purchase-history");

let getPurchaseHistory;

if (purchaseHistory) {
  getPurchaseHistory = () => {
    fetch("/mypage/purchaseHistory", {
      method: "post",
      headers: { "Content-Type": "application/json" },
      body: memberNo
    })
      .then(response => response.json())
      .then(data => {
        const purchaseItem = document.getElementById("purchase-item");
        purchaseItem.innerHTML = "";
        data.forEach(item => {
          const itemContainer = document.createElement("a");
          itemContainer.href = '/board/' + parseInt(item.boardCode) + '/' + item.boardNo;
          itemContainer.classList.add("item-container");

          const itemBox = document.createElement("div");
          itemBox.classList.add("item-box");

          const itemImg = document.createElement("img");
          itemImg.setAttribute("src", item.imgPath);

          itemBox.appendChild(itemImg);
          const itemTitle = document.createElement("p");
          itemTitle.classList.add("item-title");
          itemTitle.textContent = item.boardTitle;

          itemContainer.appendChild(itemBox);
          itemContainer.appendChild(itemTitle);

          purchaseItem.appendChild(itemContainer);
        });

        if (data.length === 0) {
          const noItem = document.createElement("p");
          noItem.textContent = "구매 이력이 없습니다.";
          purchaseItem.appendChild(noItem);
          
          const noRecommend = document.createElement("p");
          noRecommend.textContent = "추천 상품이 없습니다.";
          document.getElementById("carousel").appendChild(noRecommend);

        } else {
          /* 구매 기록의  카테고리 set */
          /* 유사 상품 추천 */
          const purchaseCategory = new Set();
          data.forEach(item => {
            purchaseCategory.add(item.categoryNo + ":" + item.category);
          });

          const categoryFilter = document.getElementById("category-filter");
          categoryFilter.innerHTML = "";

          purchaseCategory.forEach(category => {
            let categoryNo = category.split(":")[0];
            let categoryName = category.split(":")[1];

            let categoryBtn = document.createElement("button");
            categoryBtn.classList.add("category-btn");
            categoryBtn.innerText = categoryName;
            categoryBtn.setAttribute("data-category", categoryNo);
            categoryFilter.appendChild(categoryBtn);
            categoryBtn.addEventListener("click", e => getCategoryRecommend(e.target));
            
            const firstCategoryBtn = document.getElementsByClassName("category-btn")[0];
            firstCategoryBtn.classList.add("selected");
            
          })

          // 초기화용 1번 실행
          getCategoryRecommend(document.getElementsByClassName("category-btn")[0]);

        }
      });
  }
}

function getCategoryRecommend(categoryBtn) {
  
  const categoryBtns = document.querySelectorAll(".category-btn");
  categoryBtns.forEach(btn => {
    btn.classList.remove("selected");
  });
  categoryBtn.classList.add("selected");


  let cateNo = categoryBtn.getAttribute("data-category");
  fetch("/mypage/categoryPick", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: cateNo
  })
  .then(response => response.json())
  .then(data => {
    const carousel = document.getElementById("carousel");
    carousel.innerHTML = "";
    data.forEach(
      item => {
        const carouselItem = document.createElement("div");
        carouselItem.classList.add("carousel-item");

        const a = document.createElement("a");
        a.href = '/board/' + parseInt(item.boardCode) + '/' + item.boardNo;
        /* ***************************** */
        
        /*  링크 수정 필요  */
        
        /* ***************************** */
        const img = document.createElement("img");
        img.src = item.imgPath;
        img.alt = item.boardTitle;

        const productName = document.createElement("p");
        productName.classList.add("product-name");
        productName.textContent = item.boardTitle;

        const productPrice = document.createElement("p");
        productPrice.classList.add("product-price");
        productPrice.textContent = item.price + "원";

        a.appendChild(img);
        a.appendChild(productName);
        a.appendChild(productPrice);

        carouselItem.appendChild(a);
        carousel.appendChild(carouselItem);
      }
    );



  });

}

function getRecommendBrand() {
  fetch("/mypage/recommendBrand", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: memberNo
  })
  .then(response => response.json())
  .then(data => {

    const interestStore = document.getElementById("interestStore");
    interestStore.innerHTML = "";
    const h3 = document.createElement("h3");
    h3.textContent = "관심 스토어";

    const storeList = document.createElement("div");
    storeList.classList.add("store-list");

    interestStore.appendChild(h3);
    interestStore.appendChild(storeList);

    data.forEach(item => {
      const storeCircle = document.createElement("div");
      storeCircle.classList.add("store-circle");

      const a = document.createElement("a");
      a.href = '/brand/' + item.memberNo;
      const img = document.createElement("img");
      if (item.profileImg === null) {
        item.profileImg = "/resources/images/mypage/common/Seller.png";
      }
      img.src = item.profileImg;
      img.alt = item.memberNick;

      const storeName = document.createElement("p");
      storeName.classList.add("store-name");
      storeName.textContent = item.memberNick;

      a.appendChild(img);
      a.appendChild(storeName);

      storeCircle.appendChild(a);
      storeList.appendChild(storeCircle);
    });

    if (data.length === 0) {
      const noItem = document.createElement("p");
      noItem.textContent = "관심 스토어가 없습니다.";
      storeList.appendChild(noItem);
    }



  });
    
}


function pickProduct() {
  fetch("/mypage/getPickProduct", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: memberNo
  })
  .then(response => response.json())
  .then(data => {

    const wishlistArea = document.getElementById("wishlist-area");
    wishlistArea.innerHTML = "";
    const h3 = document.createElement("h3");
    h3.textContent = "찜한 상품 ";

    const wishlistSection = document.createElement("div");
    wishlistSection.classList.add("wishlist-section");

    wishlistArea.appendChild(h3);
    wishlistArea.appendChild(wishlistSection);

    const hr = document.createElement("hr");
    wishlistSection.appendChild(hr);

    const allh4 = document.createElement("h4");
    allh4.textContent = "전체";
    wishlistSection.appendChild(allh4);

    const allProductList = document.createElement("div");
    allProductList.classList.add("product-list");

    if (data.length === 0) {
      const noItem = document.createElement("p");
      noItem.textContent = "찜한 상품이 없습니다.";
      allProductList.appendChild(noItem);
    }

    /* data의 boardTitle 길이 13자로 조절 */
    data.map (item => {
      if (item.boardTitle.length > 15) {
        item.boardTitle = item.boardTitle.substring(0, 13) + "...";
      }
    });


    [...data].forEach(item => {
      const productItem = document.createElement("div");
      productItem.classList.add("product-item");

      const a = document.createElement("a");
      a.href = '/board/' + parseInt(item.boardCode) + '/' + item.boardNo;
      const img = document.createElement("img");
      img.src = item.imgPath;
      img.alt = item.boardTitle;

      const productName = document.createElement("p");
      productName.classList.add("product-name");
      productName.textContent = item.boardTitle;

      const productPrice = document.createElement("p");
      productPrice.classList.add("product-price");
      productPrice.textContent = item.price + "원";

      a.appendChild(img);
      a.appendChild(productName);
      a.appendChild(productPrice);

      productItem.appendChild(a);
      allProductList.appendChild(productItem);
    });

    wishlistSection.appendChild(allProductList);


    const categorySet = new Set();
    data.forEach(item => {
      categorySet.add(item.categoryNo + ":" + item.category);
    });
    

    categorySet.forEach(category => {
      let categoryNo = category.split(":")[0];
      let categoryName = category.split(":")[1];

      const hr = document.createElement("hr");
      wishlistSection.appendChild(hr);

      const h4 = document.createElement("h4");
      h4.textContent = categoryName;
      wishlistSection.appendChild(h4);

      const productList = document.createElement("div");
      productList.classList.add("product-list");
      wishlistSection.appendChild(productList);

      data.forEach(item => {
        if (item.categoryNo == categoryNo) {
          const productItem = document.createElement("div");
          productItem.classList.add("product-item");

          const a = document.createElement("a");
          a.href = '/board/' + parseInt(item.boardCode) + '/' + item.boardNo;
          const img = document.createElement("img");
          img.src = item.imgPath;
          img.alt = item.boardTitle;

          const productName = document.createElement("p");
          productName.classList.add("product-name");
          productName.textContent = item.boardTitle;

          const productPrice = document.createElement("p");
          productPrice.classList.add("product-price");
          productPrice.textContent = item.price + "원";

          a.appendChild(img);
          a.appendChild(productName);
          a.appendChild(productPrice);

          productItem.appendChild(a);
          productList.appendChild(productItem);
        }
      });
    });


  });

}


const menuItems = document.getElementsByClassName("menu-item");



editProfile = document.getElementById("editProfile");
if (editProfile) {
  
}


// 문서 로드 시
document.addEventListener("DOMContentLoaded", function () {
  getPurchaseHistory();
  pickProduct();
  getRecommendBrand();

});


// 사업자일시 !!
const businessSection = document.getElementById("business-section");
if (businessSection){
  // 내 사업자정보
  fetch("/mypage/getBusinessInfo", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: memberNo
  })
  .then(response => response.json())
  .then(data => {
    console.log(data);
    const businessInfo = document.getElementById("business-info");
    businessInfo.innerHTML = "";
    /* data */
    /* bankName
: 
"국민은행"
bankNo
: 
"987654321"
businessNo
: 
"1234567890"
memberNo
: 
2
permissionFl
: 
"N" */
    const bankName = document.createElement("span");
    bankName.textContent = "은행명 : " + data.bankName;
    const bankNo = document.createElement("span");
    bankNo.textContent = "계좌번호 : " + data.bankNo;
    const businessNo = document.createElement("span");
    businessNo.textContent = "사업자등록번호 : " + data.businessNo;
    const permissionFl = document.createElement("span");
    permissionFl.textContent = "승인여부 : " + (data.permissionFl === "Y" ? "승인" : "미승인");

    businessInfo.appendChild(bankName);
    businessInfo.appendChild(bankNo);
    businessInfo.appendChild(businessNo);
    businessInfo.appendChild(permissionFl);



    if (data.length === 0) {
      const noItem = document.createElement("p");
      noItem.textContent = "현재 진행중인 사업이 없습니다.";
      businessInfo.appendChild(noItem);
    }
  });
}

const promotionSection = document.getElementById("promotion-section");
if (promotionSection) {
  // 내 광고 현황
  fetch("/mypage/getPromotionInfo", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: memberNo
  })
  .then(response => response.json())
  .then(data => {
    console.log(data);
    const promotionList = document.getElementById("promotion-list");
    
    data.forEach(item => {
      /* item */
      /* 
boardDelFl
: 
"대기"

boardTitle
: 
"투게더 광고 부탁드립니다."
brandName
: 
"관리자"
createDate
: 
"2025-03-28" */
      const promotionItem = document.createElement("div");
      promotionItem.classList.add("promotion-item");

      const promotionTitle = document.createElement("span");
      promotionTitle.classList.add("promotion-title");

      const strong = document.createElement("strong");
      strong.textContent = item.boardTitle;
      promotionTitle.appendChild(strong);

      const br = document.createElement("br");
      promotionTitle.appendChild(br);

      const dateText = document.createTextNode(item.createDate);
      promotionTitle.appendChild(dateText);



      const promotionStatus = document.createElement("div");
      promotionStatus.classList.add("promotion-status");
      promotionStatus.classList.add(item.boardDelFl === "승인" ? "approved" : "거부" === item.boardDelFl ? "rejected" : "waiting");
      
      promotionStatus.textContent = item.boardDelFl;

      promotionItem.appendChild(promotionTitle);
      promotionItem.appendChild(promotionStatus);

      promotionList.appendChild(promotionItem);
      
    });

    if (data.length === 0) {
      const noItem = document.createElement("p");
      noItem.textContent = "현재 진행중인 광고가 없습니다.";
      promotionList.appendChild(noItem);
    }
  });
}