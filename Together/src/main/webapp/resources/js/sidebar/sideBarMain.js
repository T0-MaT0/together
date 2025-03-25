console.log("sideBarMain.js");

// a 태그 기본 동작 제거 
document.querySelectorAll("a.no-link").forEach(a => {
  a.addEventListener("click", e => e.preventDefault());
});

// 사이드바 열고 닫기
const sideBar = document.getElementById("sideBar");
const sideBarClose = document.getElementById("sideBar-close");

sideBarClose.addEventListener("click", e => {
  e.preventDefault();
  e.stopPropagation();
  sideBar.classList.toggle("active");
  sideBarClose.classList.toggle("activate");
});



// 채팅방 목록 비동기 로딩
function loadChatRoomList() {
  fetch("/chatting/roomList")
    .then(response => response.json())
    .then(chatList => {
      const container = document.querySelector(".chat-room-box");
      if (!container) return;

      container.innerHTML = "";

      if (chatList.length === 0) {
        container.innerHTML = "<p class='no-chat'>채팅방이 없습니다.</p>";
        return;
      }

      chatList.forEach(chat => {
        const div = document.createElement("div");
        div.classList.add("chat-room");

        // 채팅방 번호를 dataset에 담아둠
        div.dataset.roomNo = chat.chattingNo;

        // HTML 구성
        div.innerHTML = `
          <div class="profile-box">
            <div class="profile profile-inBox">
              <img src="${chat.targetProfile || '/resources/images/mypage/관리자 프로필.webp'}" alt="">
            </div>
          </div>
          <div class="chat">
            <div class="chat-name">${chat.targetNickname || chat.roomName}</div>
            <div class="chat-content">${chat.lastMessage || '대화를 시작해보세요!'}</div>
          </div>
          <div class="chat-info">
            <div class="noti noti-chat"><span>${chat.unreadCount || 0}</span></div>
            <div class="chat-time">${chat.lastSendTime || ''}</div>
          </div>
        `;

        div.addEventListener("click", () => {
          const chattingNo = div.dataset.roomNo;
          const targetUrl = `/sidebar/chatOpen?chattingNo=${chattingNo}`;

          fetch(targetUrl)
            .then(res => res.text())
            .then(html => {
              const contentBox = document.querySelectorAll("#CHAT .content")[0];
              contentBox.innerHTML = html;

              connectChatWebSocket?.();
              loadMessageList?.();

            });
        });

        container.appendChild(div);
      });
    })
    .catch(err => {
      console.error("채팅방 목록 불러오기 실패", err);
    });
}






// 채팅 + 장바구니 토글
let flag = 0;
const toggleIcon = document.getElementById("togglePage");
const toggleBodies = document.getElementsByClassName("body");
const toggleTitle = document.getElementById("title");

toggleIcon.addEventListener("click", e => {
  const isChat = flag === 0;

  e.target.setAttribute("src", isChat
    ? "/resources/images/sidebar/images/talk.svg"
    : "/resources/images/sidebar/images/favorite-cart.svg");

  toggleTitle.innerText = isChat ? "채팅" : "장바구니";
  flag = isChat ? 1 : 0;

  Array.from(toggleBodies).forEach(body => body.classList.toggle("hidden"));
});

// 메인 페이지 전체 스크롤 이동
document.getElementById("scrollUp").addEventListener("click", e => {
  e.preventDefault();
  window.scrollBy({ top: -document.body.scrollHeight, behavior: 'smooth' });
});

document.getElementById("scrollDown").addEventListener("click", e => {
  e.preventDefault();
  window.scrollBy({ top: document.body.scrollHeight, behavior: 'smooth' });
});


// WebSocket 소켓 전역
let chattingSock;

// 채팅방 열릴 때 호출 WebSocket 연결
function connectChatWebSocket() {
  if (!chattingSock || chattingSock.readyState !== 1) {
    chattingSock = new SockJS("/chattingSock");
  }

  chattingSock.onmessage = e => {
    const msg = JSON.parse(e.data);
    displayMessage(msg);
  };
}


// 채팅 메시지 목록 불러오기
function loadMessageList() {
  const roomNo = document.getElementById("chatRoom").dataset.roomNo;
  const ul = document.getElementById("chatMessageList");
  console.log('loadMessageList실행')
  fetch(`/chatting/selectMessageList?chattingNo=${roomNo}&memberNo=${loginMemberNo}`)
      .then(res => res.json())
      .then(list => {
      ul.innerHTML = "";
      console.log(list)
  
      list.forEach(msg => {
  
          const li = document.createElement("li");
          const span = document.createElement("span");
          span.classList.add("chatDate");
          span.innerText = msg.sendTime;
  
          const p = document.createElement("p");
          p.classList.add("chat");
          p.innerHTML = msg.messageContent;
  
          if (msg.senderNo === loginMemberNo) {
          li.classList.add("my-chat");
          li.append(span, p);
          } else {
          li.classList.add("target-chat");
  
          const img = document.createElement("img");
          img.src = msg.senderProfile || "/resources/images/user.png";
  
          const div = document.createElement("div");
          const b = document.createElement("b");
          b.innerText = msg.senderNickname;
          const br = document.createElement("br");
  
          div.append(b, br, p, span);
          li.append(img, div);
          }
  
          ul.appendChild(li);
      });
  
      ul.scrollTop = ul.scrollHeight; 
      })
      .catch(err => console.error("메시지 목록 불러오기 실패", err));
  }


  // 탭 클릭 시 영역 전환 + 비동기 콘텐츠 로딩
const menus = document.querySelectorAll("#CHAT .talkMenu > a");
const contents = document.querySelectorAll("#CHAT .content");
const talkMenus = document.querySelectorAll("#CHAT .talkMenu");

menus.forEach((menu, i) => {
  menu.addEventListener("click", function (e) {
    e.preventDefault();

    if (talkMenus[i].classList.contains("select")) return;

    // UI 전환
    talkMenus.forEach((tm, j) => {
      tm.classList.toggle("select", i === j);
      tm.classList.toggle("unselect", i !== j);
      contents[j].classList.toggle("hidden", i !== j);
    });

    // AJAX 로드
    const url = this.dataset.url;
    if (url && contents[i]) {
      fetch(url)
        .then(res => res.text())
        .then(html => {
          contents[i].innerHTML = html;

          // 로딩된 탭에 따라 처리
          if (url.includes("chat")) {
            loadChatRoomList();
          }

          if (url.includes("chatOpen")) {
            connectChatWebSocket?.(); 
            loadMessageList?.();
            const roomNo = document.querySelector(".content[data-room-no]")?.dataset.roomNo
            || document.getElementById("chatRoom")?.dataset.roomNo;

            if (roomNo) loadChatTargetInfo(roomNo);
          }
        })
        .catch(err => {
          console.error("sidebar load error:", err);
        });
    }
  });
});