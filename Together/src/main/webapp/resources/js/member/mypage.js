console.log("mypage.js");





// 비동기 


// 구매 이력
const purchaseHistory = document.getElementById("purchase-history");

let getPurchaseHistory;

console.log(memberNo);
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
            categoryBtn.addEventListener("click", () => {
              const categoryBtns = document.querySelectorAll(".category-btn");
              categoryBtns.forEach(btn => {
                btn.classList.remove("selected");
              });
              categoryBtn.classList.add("selected");
              let cateNo = categoryBtn.getAttribute("data-category");
              console.log(cateNo);
              fetch("/mypage/categoryPick", {
                method: "post",
                headers: { "Content-Type": "application/json" },
                body: cateNo
              })
              .then(response => response.json())
              .then(data => {
                console.log(data);
                const carousel = document.getElementById("carousel");
                carousel.innerHTML = "";
                data.forEach(
                  item => {
                    const carouselItem = document.createElement("div");
                    carouselItem.classList.add("carousel-item");

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

                    carouselItem.appendChild(a);
                    carousel.appendChild(carouselItem);
                  }
                );

                if (data.length === 0) {
                  const noItem = document.createElement("p");
                  noItem.textContent = "추천 상품이 없습니다.";
                  carousel.appendChild(noItem);
                }

              });

            });
            const firstCategoryBtn = document.getElementsByClassName("category-btn")[0];
            firstCategoryBtn.classList.add("selected");

          })

        }
      });
  }
}




// 문서 로드 시
document.addEventListener("DOMContentLoaded", function () {
  getPurchaseHistory();
});