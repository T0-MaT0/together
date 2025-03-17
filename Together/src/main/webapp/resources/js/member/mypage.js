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
        console.log(data);
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

      })
  }
}




// 문서 로드 시
document.addEventListener("DOMContentLoaded", function () {
  getPurchaseHistory();
});