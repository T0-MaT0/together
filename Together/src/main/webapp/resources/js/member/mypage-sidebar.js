console.log("mypage-sidebar.js");

const mainItems = document.getElementsByClassName("main-item");
const subItems = document.getElementsByClassName("sub-item");


for (let i = 0; i < mainItems.length; i++) {
  mainItems[i].addEventListener("mouseover", e => {
    mainItems[i].classList.add("hover");

    setTimeout(() => {
    for (let j = 0; j < mainItems.length; j++) {
      mainItems[j].classList.remove("hover");
    }
    mainItems[i].classList.add("hover");
  }, 200);
  });
}

let url = location.href
let page = url.split("/").pop();

const items = [...mainItems, ...subItems];
for (let i = 0; i < items.length; i++) {
  if (items[i].classList.contains(page)) {
    console.log(i);
    items[i].classList.add("selected");
  }
}