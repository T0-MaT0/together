console.log("sideBarMain.js");

/* a태그 방지 */
const aTags = document.getElementsByTagName("a");
for (i = 0; i < aTags.length; i++) {
  aTags[i].addEventListener("click", e => {
    e.preventDefault();
  });
}

const sideBar = document.getElementById("sideBar");
const sideBarBox = document.getElementById("sidebar-menu-box");
const sideBarClose = document.getElementById("sideBar-close");



sideBarBox.addEventListener("click", function(e) {
  if (sideBar.classList.contains("active") || !sideBarClose.classList.contains("activate")) {
    return;
  }
  sideBar.classList.add("active");
  sideBarClose.classList.remove("activate");
});

sideBarClose.addEventListener("click", function(e) {
  e.stopPropagation();
  sideBar.classList.toggle("active");
  console.log("remove active");
  sideBarClose.classList.toggle("activate");
});





const menus = document.querySelectorAll("#CHAT .talkMenu>a");
const content = document.querySelectorAll("#CHAT .content");
const talkMenu = document.querySelectorAll("#CHAT .talkMenu");


for (let i = 0; i < content.length; i++) {
  menus[i].addEventListener("click", () => {
    if (talkMenu[i].classList.contains("unselect")) {
      for (let j = 0; j < talkMenu.length; j++) {
        if (i === j) {
          talkMenu[j].classList.remove("unselect");
          talkMenu[j].classList.add("select");
          content[j].classList.remove("hidden");
        } else {
          talkMenu[j].classList.remove("select");
          talkMenu[j].classList.add("unselect");
          content[j].classList.add("hidden");
        }
      }
    }
  });
}

flag = 0;

const classBody = document.getElementsByClassName("body");

document.getElementById("togglePage").addEventListener("click", e => {
  if (flag === 0) {
    e.target.setAttribute("src", "images/talk.svg");
    document.getElementById("title").innerText = '채팅';
    flag = 1;
  } else {
    e.target.setAttribute("src", "images/favorite-cart.svg");
    document.getElementById("title").innerText = '장바구니';
    flag = 0;
  }

  for (body of classBody) {
    body.classList.toggle("hidden");
  }
});