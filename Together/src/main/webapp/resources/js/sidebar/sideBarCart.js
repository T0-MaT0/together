console.log("sideBarCart.js loaded");

// 문서 로드 시 

document.addEventListener("DOMContentLoaded", function() {
  const pick = document.getElementById("PICK");

  if (pick) {
    fetch("/mypage/getPickProduct", {
      method: "post",
      headers: { "Content-Type": "application/json" },
      body: memberNo
    })
    .then(response => response.json())
    .then(data => {

      const pickListBox = document.getElementById("pickListBox");
      pickListBox.innerHTML = ""; // 기존 내용 초기화

      data.array.forEach(item => {
        
        const itemBox = document.createElement("div");
        itemBox.className = "itemBox";

        const thumb = document.createElement("div");
        thumb.className = "thumb";

        const img = document.createElement("img");
        img.src = item.imgPath;
        img.alt = item.boardTitle;

        thumb.appendChild(img);
        itemBox.appendChild(thumb);

        const digit = document.createElement("div");
        digit.className = "digit";

        const titleDiv = document.createElement("div");
        titleDiv.innerHTML = `<span>${item.boardTitle}</span>`;
        digit.appendChild(titleDiv);

        const priceDiv = document.createElement("div");
        priceDiv.innerHTML = `<span>${item.price}원(원가)</span>`;
        digit.appendChild(priceDiv);

        const companyDiv = document.createElement("div");
        companyDiv.innerHTML = `<div>${item.company}</div><div>${item.price}원</div>`;
        digit.appendChild(companyDiv);

        const quantityDiv = document.createElement("div");
        quantityDiv.innerHTML = `<div>수량 : <span>${item.quantity}</span></div>`;
        
        const deleteBtnArea = document.createElement("div");
        deleteBtnArea.className = "deleteBtn-area";
        
        const deleteLink = document.createElement("a");
        deleteLink.href = "#"; // 삭제 링크의 href 설정
        deleteLink.innerHTML = '<img src="images/X.svg" alt="">';
        
        deleteBtnArea.appendChild(deleteLink);
        
        itemBox.appendChild(digit);
        itemBox.appendChild(deleteBtnArea);
        
        pickListBox.appendChild(itemBox);

      });

      if (data.array.length === 0) {
        const emptyMessage = document.createElement("div");
        emptyMessage.className = "emptyMessage";
        emptyMessage.textContent = "장바구니에 상품이 없습니다.";
        pickListBox.appendChild(emptyMessage);
      }

    })
    .catch(error => console.error("Error:", error));
  }
});