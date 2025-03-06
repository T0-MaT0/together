console.log("sideBarMain.js");

/* a태그 방지 */
const aTags = document.getElementsByTagName("a");
for (i = 0; i < aTags.length; i++) {
  aTags[i].addEventListener("click", e => {
    e.preventDefault();
  });
}


document.getElementById("sidebar-menu-box").addEventListener("click", function() {
  document.getElementById("sideBar").classList.add("active");
  /* 밑의 이벤트 발생 전까지 본 이벤트 차단 */
});


document.getElementById("sideBar-close").addEventListener("click", function() {
  document.getElementById("sideBar").classList.remove("active");
  event.stopPropagation();
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
    document.getElementById("title").innerText = '내가 찜한 목록';
    flag = 0;
  }

  for (body of classBody) {
    body.classList.toggle("hidden");
  }
});