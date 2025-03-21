
// wishlist-page
const wishlistSection = document.getElementById("wishlist-section");

if (wishlistSection) {

  const wishlistTabs = document.getElementById("wishlist-tabs");
  const wishlistSummary = document.getElementById("wishlist-summary");
  const wishlistItems = document.getElementById("wishlist-items");

  fetch("/mypage/getPickProduct", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: memberNo
  })
    .then(response => response.json())
    .then(data => {
      const categorySet = new Set();
      data.forEach(item => {
        categorySet.add(item.categoryNo + ":" + item.category);
      });

      const categoryArr = Array.from(categorySet);

      const tabAll = document.createElement("span");
      tabAll.className = "tab active";
      tabAll.innerText = "전체";
      wishlistTabs.appendChild(tabAll);

      categoryArr.forEach(category => {
        const tab = document.createElement("span");
        tab.className = "tab";
        tab.innerText = category.split(":")[1];
        wishlistTabs.appendChild(tab);
      });

      const tabs = wishlistTabs.querySelectorAll(".tab");

      /* 클릭시 items와 summary 반응 */
      tabs.forEach(tab => {
        tab.addEventListener("click", e => {
          tabs.forEach(tab => tab.classList.remove("active"));
          e.target.classList.add("active");

          wishlistItems.innerHTML = "";
          console.log(data);
          let items = [];

          if (e.target.innerText === "전체") {
            items = data;
          } else {
            items = data.filter(item => item.category === e.target.innerText);
          }

          if (items.length === 0) {
            const wishlistItem = document.createElement("div");
            wishlistItem.className = "wishlist-item";
            wishlistItems.appendChild(wishlistItem);

            const wishlistInfo = document.createElement("div");
            wishlistInfo.className = "wishlist-info";
            wishlistItem.appendChild(wishlistInfo);

            const wishlistTitle = document.createElement("p");
            wishlistTitle.className = "wishlist-title";
            wishlistTitle.innerText = "찜한 상품이 없습니다.";
            wishlistInfo.appendChild(wishlistTitle);
          }

          makeItem(items, wishlistItems);

          wishlistSummary.innerText = e.target.innerText + " " + items.length;

        });
      });

      tabAll.click();

    });

};


function makeItem(list = [], wishlistItems) {
  list.forEach(item => {
    const wishlistItem = document.createElement("div");
    wishlistItem.className = "wishlist-item";
    wishlistItems.appendChild(wishlistItem);

    const wishlistLink = document.createElement("a");
    wishlistLink.href = `/board/${item.boardCode}/${item.boardNo}`;
    wishlistLink.className = "wishlist-link";
    wishlistItem.appendChild(wishlistLink);

    const wishlistImg = document.createElement("img");
    wishlistImg.src = item.imgPath
    wishlistImg.alt = item.boardTitle;
    wishlistImg.className = "wishlist-img";
    wishlistLink.appendChild(wishlistImg);

    const wishlistInfo = document.createElement("div");
    wishlistInfo.className = "wishlist-info";
    wishlistItem.appendChild(wishlistInfo);

    const wishlistTitle = document.createElement("p");
    wishlistTitle.className = "wishlist-title";
    wishlistTitle.innerText = item.boardTitle;
    wishlistInfo.appendChild(wishlistTitle);

    const wishlistDiscount = document.createElement("p");
    wishlistDiscount.className = "wishlist-discount";
    wishlistDiscount.innerText = "조회수" + item.readCount;
    wishlistInfo.appendChild(wishlistDiscount);

    const wishlistPrice = document.createElement("p");
    wishlistPrice.className = "wishlist-price";
    wishlistPrice.innerText = item.price + "원";
    wishlistInfo.appendChild(wishlistPrice);

    const wishlistCategory = document.createElement("p");
    wishlistCategory.className = "wishlist-category";
    wishlistCategory.innerText = item.category;
    wishlistInfo.appendChild(wishlistCategory);

    const removeBtn = document.createElement("button");
    removeBtn.className = "remove-btn";
    removeBtn.innerText = "×";
    wishlistItem.appendChild(removeBtn);

    wishlistItems.appendChild(wishlistItem);
  });

  /* 삭제 구현하기 */

}

// recentPurchase-page
const recentPurchasesSection = document.getElementById("recent-purchases-section");

if (recentPurchasesSection) {
  fetch("/mypage/purchaseHistory", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: memberNo
  })
    .then(response => response.json())
    .then(data => {
      console.log(data);
      const recentPurchaseContainer = document.getElementById("recent-purchase-container");

      data.forEach(purchase => {
        const recentPurchaseItem = document.createElement("div");
        recentPurchaseItem.className = "recent-purchase-item";
        recentPurchaseContainer.appendChild(recentPurchaseItem);

        const purchaseLink = document.createElement("a");
        purchaseLink.href = `/board/${purchase.boardCode}/${purchase.boardNo}`;
        purchaseLink.className = "purchase-link";
        recentPurchaseItem.appendChild(purchaseLink);

        const purchaseImg = document.createElement("img");
        purchaseImg.src = purchase.imgPath;
        purchaseImg.alt = purchase.boardTitle;
        purchaseImg.className = "purchase-img";
        purchaseLink.appendChild(purchaseImg);

        const purchaseInfo = document.createElement("div");
        purchaseInfo.className = "purchase-info";
        recentPurchaseItem.appendChild(purchaseInfo);

        const purchaseTitle = document.createElement("p");
        purchaseTitle.className = "purchase-title";
        purchaseTitle.innerHTML = `<a href="/board/${purchase.boardCode}/${purchase.boardNo}">${purchase.boardTitle}</a>`;
        purchaseInfo.appendChild(purchaseTitle);

        const purchasePrice = document.createElement("p");
        purchasePrice.className = "purchase-price";
        purchasePrice.innerText = purchase.price + "원";
        purchaseInfo.appendChild(purchasePrice);

        const purchaseCategory = document.createElement("p");
        purchaseCategory.className = "purchase-category";
        purchaseCategory.innerText = purchase.category;
        purchaseInfo.appendChild(purchaseCategory);

      });

      if (data.length === 0) {
        const recentPurchaseItem = document.createElement("div");
        recentPurchaseItem.className = "recent-purchase-item";
        recentPurchaseContainer.appendChild(recentPurchaseItem);

        const purchaseInfo = document.createElement("div");
        purchaseInfo.className = "purchase-info";
        recentPurchaseItem.appendChild(purchaseInfo);

        const purchaseTitle = document.createElement("p");
        purchaseTitle.className = "purchase-title";
        purchaseTitle.innerText = "구매 내역이 없습니다.";
        purchaseInfo.appendChild(purchaseTitle);
      }

    });
    /* 모집시 정보 추가하기 */
}


// favoriteStore-page
const favoriteStoresSection = document.getElementById("favorite-stores-section");

if (favoriteStoresSection) {
  fetch("/mypage/pickBrand", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: memberNo
  })
    .then(response => response.json())
    .then(data => {
      console.log(data);
      const storeContainer = document.getElementById("store-container");

        data.forEach(store => {
        const storeItem = document.createElement("div");
        storeItem.className = "store-item";
        storeContainer.appendChild(storeItem);

        const storeImg = document.createElement("img");
        storeImg.src = store.profileImage;
        storeImg.alt = store.memberNick;
        storeImg.className = "store-img";
        storeItem.appendChild(storeImg);

        const storeInfo = document.createElement("div");
        storeInfo.className = "store-info";
        storeItem.appendChild(storeInfo);

        const storeName = document.createElement("p");
        storeName.className = "store-name";
        storeName.innerText = store.memberNick;
        storeInfo.appendChild(storeName);

        const storeDesc = document.createElement("p");
        storeDesc.className = "store-desc";
        storeDesc.innerText = "대표 " + store.memberName + "\n" + "사업자등록번호 - " + store.businessNo;
        storeInfo.appendChild(storeDesc);

        const storeCustomers = document.createElement("p");
        storeCustomers.className = "store-customers";
        storeCustomers.innerText = "조회고객수 " + store.sumReadCount;
        storeInfo.appendChild(storeCustomers);

        const removeBtn = document.createElement("button");
        removeBtn.className = "remove-btn";
        removeBtn.innerText = "×";
        storeItem.appendChild(removeBtn);

      });

      if (data.length === 0) {
        const storeItem = document.createElement("div");
        storeItem.className = "store-item";
        storeContainer.appendChild(storeItem);

        const storeInfo = document.createElement("div");
        storeInfo.className = "store-info";
        storeItem.appendChild(storeInfo);

        const storeName = document.createElement("p");
        storeName.className = "store-name";
        storeName.innerText = "관심 스토어가 없습니다.";
        storeInfo.appendChild(storeName);
      }



    });

}

// orders-page + recruitment-page
const ordersSection = document.getElementById("orders-section");

if (ordersSection) {
  fetch("/mypage/purchaseHistoryOrders", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: memberNo
  })
  .then(response => response.json())
  .then(data => {
    console.log(data);
  });
}


const recruitmentSection = document.getElementById("recruitment-section");

if (recruitmentSection) {
  fetch("/mypage/purchaseHistoryRecruitment", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: memberNo
  })
  .then(response => response.json())
  .then(data => {
    console.log(data);
  });
}


/*

/* 내 질문 */
SELECT * 
FROM REPLY 
WHERE REPLY_TYPE = 1
AND MEMBER_NO = 9;

/* 내 답변 */
SELECT R.*
FROM (
	SELECT PARENT_REPLY_NO 
	FROM REPLY 
	WHERE REPLY_TYPE = 1
	AND PARENT_REPLY_NO IS NOT NULL
) P JOIN REPLY R ON P.PARENT_REPLY_NO = R.REPLY_NO 
WHERE MEMBER_NO = 11;

/* 나에게 온 질문 */

SELECT *
FROM (
	SELECT BOARD_NO 
	FROM BOARD 
	WHERE MEMBER_NO = 4
	AND BOARD_CD = 2
) 
JOIN REPLY ON BOARD_NO = REPLY_TYPE_NO ;


 */