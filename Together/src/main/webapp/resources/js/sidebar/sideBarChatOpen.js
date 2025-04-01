console.log("sideBarChatOpen.js");

document.addEventListener("DOMContentLoaded", () => {

  // 채팅방 삭제 버튼 (minus) 이벤트 등록
  document.querySelector(".title-menu .minus").closest("a").addEventListener("click", function(e) {
    e.preventDefault();

    if(confirm("채팅방을 삭제하시겠습니까?")) {
      const roomNo = document.getElementById("chatRoom").dataset.roomNo;

      fetch(`/chatting/deleteRoom?roomNo=${roomNo}`, { method: "POST" })
        .then(res => res.json())
        .then(result => {
          if(result.success) {
            alert("채팅방이 삭제되었습니다.");
            document.querySelector('.title-menu .plus').closest('a').click(); // 삭제 후 목록으로 이동
          } else {
            alert("채팅방 삭제에 실패했습니다.");
          }
        })
        .catch(err => {
          console.error(err);
          alert("오류가 발생했습니다.");
        });
    }
  });

  // 채팅방 목록으로 돌아가는 버튼 (plus) 이벤트 등록
  document.querySelector(".title-menu .plus").closest("a").addEventListener("click", function(e) {
    e.preventDefault();

    const talkMenus = document.querySelectorAll("#CHAT .talkMenu");
    const contents = document.querySelectorAll("#CHAT .content");

    // 기존 선택 초기화
    talkMenus.forEach(menu => {
      menu.classList.remove("select");
      menu.classList.add("unselect");
    });

    contents.forEach(content => content.classList.add("hidden"));

    // data-url이 "/sidebar/chat"인 메뉴를 찾기
    const targetMenu = document.querySelector(`#CHAT .talkMenu > a[data-url="/sidebar/chat"]`);

    if (targetMenu) {
      const parentMenu = targetMenu.parentElement;
      parentMenu.classList.add("select");
      parentMenu.classList.remove("unselect");

      const menus = document.querySelectorAll("#CHAT .talkMenu > a");
      const menuIndex = Array.from(menus).indexOf(targetMenu);

      if(menuIndex !== -1 && contents[menuIndex]) {
        contents[menuIndex].classList.remove("hidden");

        fetch("/sidebar/chat")
          .then(res => res.text())
          .then(html => {
            contents[menuIndex].innerHTML = html;
            loadChatRoomList(); 
          })
          .catch(err => console.error("AJAX Load Error:", err));
      }
    } else {
      console.error("해당 메뉴를 찾을 수 없습니다.");
    }
  });

});