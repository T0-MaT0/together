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
        div.dataset.roomNo = chat.roomNo;

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
  e.preventDefault();

  const isChat = flag === 0;

  e.target.setAttribute("src", isChat
    ? "/resources/images/sidebar/images/talk.svg"
    : "/resources/images/sidebar/images/favorite-cart.svg");

  toggleTitle.innerText = isChat ? "채팅" : "장바구니";
  flag = isChat ? 1 : 0;

  Array.from(toggleBodies).forEach(body => body.classList.toggle("hidden"));

  if (isChat) {
    initializeChatTabs(); 

    const firstTab = document.querySelector('#CHAT .talkMenu > a.no-link[data-url]');
    if (firstTab) firstTab.click(); 
  }
});


// 탭 이벤트 등록 함수
function initializeChatTabs() {
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

            if (url.includes("chat")) loadChatRoomList();
            if (url.includes("chatOpen")) {
              connectChatWebSocket?.();
              loadMessageList?.();
              const roomNo = document.getElementById("chatRoom")?.dataset.roomNo;
              if (roomNo) loadChatTargetInfo(roomNo);
            }
          })
          .catch(err => console.error("sidebar load error:", err));
      }
    });
  });
}






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
fetch(`/chatting/selectMessageList?chattingNo=${roomNo}&memberNo=${loginMemberNo}`)
    .then(res => res.json())
    .then(list => {
    ul.innerHTML = "";
    console.log(list)

    list.forEach(msg => {
      const li = document.createElement("li");
    
      console.log(typeof msg.senderNo, msg.senderNo);
      console.log(typeof loginMemberNo, loginMemberNo);
      // 나인지 상대방인지 판단
      const isMine = Number(msg.senderNo) === Number(loginMemberNo);
    
      // 루트 div (own / other)
      const rootDiv = document.createElement("div");
      rootDiv.classList.add(isMine ? "own" : "other");
    
      // 닉네임
      const nicknameDiv = document.createElement("div");
      nicknameDiv.classList.add("nickname");
      nicknameDiv.innerText = msg.senderNickname || (isMine ? loginMemberNickname : "알 수 없음");
    
      // 프로필 이미지
      const profileBox = document.createElement("div");
      profileBox.classList.add("profile-box");
    
      const profile = document.createElement("div");
      profile.classList.add("profile", "profile-inChat");
    
      const img = document.createElement("img");
      img.src = msg.senderProfile || "/resources/images/user.png";
    
      profile.appendChild(img);
      profileBox.appendChild(profile);
    
      // 메시지 박스
      const chatBoxes = document.createElement("div");
      chatBoxes.classList.add("chat-boxes");
    
      const chatBox = document.createElement("div");
      chatBox.classList.add("chat-box");
    
      const span = document.createElement("span");
      span.innerHTML = msg.messageContent;
    
      chatBox.appendChild(span);
      chatBoxes.appendChild(chatBox);
    
      // 전송 시간 
      const time = document.createElement("div");
      time.classList.add("chatDate");
      time.innerText = msg.sendTime;
      chatBoxes.appendChild(time);
    
      // 조립
      rootDiv.appendChild(nicknameDiv);
      rootDiv.appendChild(profileBox);
      rootDiv.appendChild(chatBoxes);
    
      // <li>에 붙이기
      li.appendChild(rootDiv);
      ul.appendChild(li);
    });

    ul.scrollTop = ul.scrollHeight; 
    scrollToBottom();  // 메시지 목록 불러온 후 맨 아래로 스크롤
    })
    .catch(err => console.error("메시지 목록 불러오기 실패", err));
}


// 메시지 목록 불러온 후 맨 아래로 스크롤
function scrollToBottom() {
  const chatArea = document.querySelector('.chat-area');
  if (chatArea) {
    chatArea.scrollTop = chatArea.scrollHeight;
  }
}


// 상대 프로필 확인용
function loadChatTargetInfo(roomNo) {
  fetch(`/chatting/targetInfo?roomNo=${roomNo}&memberNo=${loginMemberNo}`)
    .then(res => res.json())
    .then(target => {
      console.log("상대방 정보:", target);

      // 닉네임 출력
      const nicknameEl = document.querySelector(".chat-title span");
      if (nicknameEl) nicknameEl.innerText = target.memberNick || "알 수 없음";

      // 프로필 이미지
      const profileImg = document.querySelector(".title-profile-box img");
      if (profileImg && target.profileImg) {
        profileImg.src = target.profileImg;
      }

    })
    .catch(err => {
      console.error("채팅 상대 정보 불러오기 실패", err);
    });
}