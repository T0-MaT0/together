console.log("sideBarMain.js");

// a 태그 기본 동작 제거 
document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll("a.no-link").forEach(a => {
    a.addEventListener("click", e => {
      const url = a.getAttribute("data-url");
      if (!url) {
        e.preventDefault(); // data-url 없는 경우만 기본 동작 막기
      }
    });
  });
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
        div.dataset.roomName = chat.roomName;
        div.dataset.ownerProfile = chat.ownerProfile;


        let lastMessage = chat.lastMessage;
        if (lastMessage && lastMessage.includes('/resources/images/')) {
          lastMessage = '이미지';
        } else if (!lastMessage || lastMessage.trim() === '') {
          lastMessage = '대화를 시작해보세요!';
        }
        // HTML 구성
        div.innerHTML = `
          <div class="profile-box">
            <div class="profile profile-inBox">
              <img src="${chat.ownerProfile || '/resources/images/user.png'}" alt="">
            </div>
          </div>
          <div class="chat">
            <div class="chat-name">${chat.roomName}</div>
            <div class="chat-content">${lastMessage || '대화를 시작해보세요!'}</div>
          </div>
          <div class="chat-info">
            <div class="noti noti-chat"><span>${chat.unreadCount || 0}</span></div>
            <div class="chat-time">${chat.lastSendTime || ''}</div>
          </div>
        `;

        div.addEventListener("click", () => {
          const chattingNo = div.dataset.roomNo;
          const roomName = div.dataset.roomName;
          const ownerProfile = div.dataset.ownerProfile;
          const targetUrl = `/sidebar/chatOpen?chattingNo=${chattingNo}`;
        
          fetch(targetUrl)
            .then(res => res.text())
            .then(html => {
              const contentBox = document.querySelectorAll("#CHAT .content")[0];
              contentBox.innerHTML = html;

              document.querySelector("#roomTitle").innerText = roomName;
              const ownerImg = document.querySelector("#ownerProfileImg");
              ownerImg.src = ownerProfile && ownerProfile !== "null"
                ? ownerProfile : "/resources/images/user.png";

                
        
              bindChatRoomHeaderButtons();
              bindSendMessageEvent();
              bindImageUploadEvent();
              bindEmojiEvent();
              // initNicknameMenuEvents();
        
              connectChatWebSocket?.(chattingNo);
              loadMessageList?.();
        
              loadChatRoomDetail(chattingNo);
        
              // 탭 선택 처리
              const talkMenus = document.querySelectorAll(".talkMenu");
              talkMenus.forEach(menu => {
                menu.classList.remove("select", "unselect"); 
                menu.classList.add("unselect");              
              });
        
              const chatTab = document.querySelector(".talkMenu a[data-url*='/sidebar/chatOpen']")?.closest(".talkMenu");
              chatTab?.classList.remove("unselect");
              chatTab?.classList.add("select");
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
const toggleTitle = document.getElementById("sideBarTitle");

toggleIcon.addEventListener("click", e => {
  e.preventDefault();

  const isChat = flag === 0;

  e.target.setAttribute("src", isChat
    ? "/resources/images/sidebar/images/favorite-cart.svg"
    : "/resources/images/sidebar/images/talk.svg")

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
              const roomNo = document.getElementById("chatRoom")?.dataset.roomNo;
            
              if (roomNo) {
                connectChatWebSocket(roomNo);  
                loadMessageList?.();
                loadChatTargetInfo(roomNo);
              }
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
function connectChatWebSocket(roomNo) {
  if (!chattingSock || chattingSock.readyState !== 1) {
    chattingSock = new SockJS("/chattingSock?roomNo=" + roomNo);
    console.log("✅ SockJS 연결 성공 / roomNo =", roomNo);
  }

  chattingSock.onmessage = (e) => {
    console.log("📩 WebSocket 메시지 수신:", e.data);
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

      if (!isMine) {
        nicknameDiv.classList.add("clickable-nickname");
        nicknameDiv.dataset.memberNo = msg.senderNo;
        nicknameDiv.dataset.memberNick = msg.senderNickname;
        nicknameDiv.dataset.productName = msg.roomName || msg.productName || "1대1 채팅";
      }

      nicknameDiv.innerText = isMine ? loginMemberNickname : msg.senderNickname || "상대방";
    
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

      if (msg.messageType === "IMAGE" || msg.messageType === "EMOJI") {
        if (
          /\.(png|jpe?g|gif|webp)$/i.test(msg.messageContent)
        ) {
          const image = document.createElement("img");
          image.src = msg.messageContent;
          image.alt = "전송된 이미지/이모지";
          image.classList.add("chat-image");

          image.style.cursor = "pointer";
          image.addEventListener("click", () => window.open(image.src, "_blank"));

          chatBox.appendChild(image);
        } else {
          const span = document.createElement("span");
          span.innerText = msg.messageContent;
          span.classList.add("emoji-message");
          chatBox.appendChild(span);
        }
      } else {
        const span = document.createElement("span");
        span.innerHTML = msg.messageContent;
        chatBox.appendChild(span);
      }

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


// 상단 메뉴바
function bindChatRoomHeaderButtons() {
  const minusBtn = document.querySelector(".title-menu .minus")?.closest("a");
  const plusBtn = document.querySelector(".title-menu .plus")?.closest("a");

  if (minusBtn) {
    minusBtn.addEventListener("click", function(e) {
      e.preventDefault();

      if (confirm("채팅방을 삭제하시겠습니까?")) {
        const roomNo = document.getElementById("chatRoom")?.dataset.roomNo;

        fetch(`/chatting/deleteRoom?roomNo=${roomNo}`, { method: "POST" })
          .then(res => res.json())
          .then(result => {
            if (result.success) {
              alert("채팅방이 삭제되었습니다.");
              plusBtn?.click(); 
            } else {
              alert("채팅방 삭제에 실패했습니다.");
            }
          })
          .catch(err => {
            console.log(err);
            alert("오류가 발생했습니다.");
          });
      }
    });
  }

  if (plusBtn) {
    plusBtn.addEventListener("click", function(e) {
      e.preventDefault();

      const targetMenu = document.querySelector(`#CHAT .talkMenu > a[data-url="/sidebar/chat"]`);
      const talkMenus = document.querySelectorAll("#CHAT .talkMenu");
      const contents = document.querySelectorAll("#CHAT .content");

      talkMenus.forEach(menu => {
        menu.classList.remove("select");
        menu.classList.add("unselect");
      });

      contents.forEach(content => content.classList.add("hidden"));

      if (targetMenu) {
        const parentMenu = targetMenu.parentElement;
        parentMenu.classList.add("select");
        parentMenu.classList.remove("unselect");

        const menus = document.querySelectorAll("#CHAT .talkMenu > a");
        const index = Array.from(menus).indexOf(targetMenu);
        if (index !== -1 && contents[index]) {
          contents[index].classList.remove("hidden");
          fetch("/sidebar/chat")
            .then(res => res.text())
            .then(html => {
              contents[index].innerHTML = html;
              loadChatRoomList();
            });
        }
      }
    });
  }
}


// 메세지 입력
function bindSendMessageEvent() {
  const sendBtn = document.getElementById("sendMessageBtn");
  const input = document.getElementById("inputChatting");

  if (sendBtn && input) {
    sendBtn.addEventListener("click", function(e) {
      e.preventDefault();

      const message = input.value.trim();
      if (message.length === 0) return;

      const roomNo = document.getElementById("chatRoom")?.dataset.roomNo;
      if (!roomNo) return;

      const msgObj = {
        roomNo: roomNo,
        senderNo: loginMemberNo,
        messageContent: message,
        messageType: "TEXT"
      };

      chattingSock.send(JSON.stringify(msgObj));
      input.value = "";
    });
  }

  const textarea = document.getElementById("inputChatting");

  textarea.addEventListener("keydown", function(e) {
    if (e.key === "Enter") {
      if (e.shiftKey) {
        // Shift + Enter → 줄바꿈
        return; // 기본 동작 유지
      } else {
        // Enter → 전송
        e.preventDefault(); // 줄바꿈 막기
        sendBtn.click(); // 버튼 클릭 이벤트 호출
      }
    }
  });
}


// 메세지 동기화
function displayMessage(msg) {
  console.log("🧾 displayMessage 실행", msg);
  const ul = document.getElementById("chatMessageList");
  if (!ul) return;

  const li = document.createElement("li");

  const isMine = Number(msg.senderNo) === Number(loginMemberNo);

  // 메시지 wrapper
  const rootDiv = document.createElement("div");
  rootDiv.classList.add(isMine ? "own" : "other");

  // 닉네임
  const nicknameDiv = document.createElement("div");
  nicknameDiv.classList.add("nickname");

  if (!isMine) {
    nicknameDiv.classList.add("clickable-nickname");
    nicknameDiv.dataset.memberNo = msg.senderNo;
    nicknameDiv.dataset.memberNick = msg.senderNickname;
    nicknameDiv.dataset.productName = msg.roomName || msg.productName || "1대1 채팅";
  }

  nicknameDiv.innerText = isMine ? loginMemberNickname : msg.senderNickname || "상대방";

  // 프로필
  const profileBox = document.createElement("div");
  profileBox.classList.add("profile-box");
  const profile = document.createElement("div");
  profile.classList.add("profile", "profile-inChat");
  const img = document.createElement("img");
  img.src = msg.senderProfile || "/resources/images/user.png";
  profile.appendChild(img);
  profileBox.appendChild(profile);

  // 메시지
  const chatBoxes = document.createElement("div");
  chatBoxes.classList.add("chat-boxes");

  const chatBox = document.createElement("div");
  chatBox.classList.add("chat-box");

  if (msg.messageType === "IMAGE" || msg.messageType === "EMOJI") {

    if (
      msg.messageContent.endsWith(".png") ||
      msg.messageContent.endsWith(".gif") ||
      msg.messageContent.endsWith(".jpg") ||
      msg.messageContent.endsWith(".jpeg") ||
      msg.messageContent.endsWith(".webp")
    ) {
      const image = document.createElement("img");
      image.src = msg.messageContent;
      image.alt = "전송된 이미지/이모지";
      image.classList.add("chat-image");

      image.style.cursor = "pointer";
      image.addEventListener("click", () => window.open(image.src, "_blank"));

      chatBox.appendChild(image);
    } else {
      const span = document.createElement("span");
      span.innerText = msg.messageContent;
      span.classList.add("emoji-message");
      chatBox.appendChild(span);
    }

  } else {
    const span = document.createElement("span");
    span.innerHTML = msg.messageContent;
    chatBox.appendChild(span);
  }

  chatBoxes.appendChild(chatBox);

  // 전송시간
  const time = document.createElement("div");
  time.classList.add("chatDate");
  time.innerText = msg.sendTime || "";

  chatBoxes.appendChild(time);

  // 조립
  rootDiv.appendChild(nicknameDiv);
  rootDiv.appendChild(profileBox);
  rootDiv.appendChild(chatBoxes);
  li.appendChild(rootDiv);
  ul.appendChild(li);

  // 자동 스크롤
  setTimeout(() => {
    ul.scrollTop = ul.scrollHeight;
  }, 0);

 
}

// 이미지 업로드
function bindImageUploadEvent() {
  const input = document.getElementById("chatImageInput");

  input?.addEventListener("change", function () {
    const file = this.files[0];
    if (!file) return;

    const formData = new FormData();
    formData.append("image", file);
    formData.append("roomNo", document.getElementById("chatRoom").dataset.roomNo);
    formData.append("senderNo", loginMemberNo);

    fetch("/chatting/image", {
      method: "POST",
      body: formData
    })
    .then(res => res.json())
    .then(msg => {
      chattingSock?.send(JSON.stringify(msg)); 

    })
    .catch(err => console.error("이미지 전송 실패", err));
  });

  const btn = document.getElementById("imageUploadBtn");
  btn?.addEventListener("click", e => {
    e.preventDefault();
    input?.click();
  });
}


// 이모지 업로드
function bindEmojiEvent() {

  // 미니 이모지 삽입 함수
  window.insertEmojiToInput = function(emoji) {
    const input = document.getElementById("inputChatting");
    const cursorPos = input.selectionStart;
    input.value = input.value.substring(0, cursorPos) + emoji + input.value.substring(cursorPos);
    input.focus();
  };

  // 큰 이모지 전송 함수
  window.sendBigEmoji = function(emojiPath) {
    const roomNo = document.getElementById("chatRoom")?.dataset.roomNo;
    if (!roomNo) return;

    const msg = {
      senderNo: loginMemberNo,
      roomNo: roomNo,
      messageType: "EMOJI",
      messageContent: emojiPath  
    };

    chattingSock?.send(JSON.stringify(msg));
  };

  // 이모지 토글 버튼
  const toggleBtn = document.getElementById("emojiToggleBtn");
  toggleBtn?.addEventListener("click", function(e) {
    e.preventDefault();
    const picker = document.getElementById("emojiPicker");
    picker?.classList.toggle("hidden");

    if (!picker.classList.contains("loaded")) {
      loadBigEmojis(); 
      picker.classList.add("loaded");
    }
  });

  // 큰 이모지 Ajax로 불러오기
  function loadBigEmojis() {
    fetch("/chatting/bigEmojis")
      .then(res => res.json())
      .then(emojis => {
        const container = document.getElementById("bigEmojiContainer");
        container.innerHTML = "";
  
        emojis.forEach(e => {
          const img = document.createElement("img");
          img.src = e.emojiCode; // 이미지 경로
          img.classList.add("big-emoji");
          img.addEventListener("click", () => sendBigEmoji(e.emojiCode));
          container.appendChild(img);
        });
      })
      .catch(err => console.error("큰 이모지 로드 실패", err));
  }
}


// 채팅방 상세 정보 및 멤버 목록 로딩
function loadChatRoomDetail(roomNo) {
  fetch(`/chatting/memberList?roomNo=${roomNo}`)
    .then(res => res.json())
    .then(data => {
      
      if (!data || !data.roomName || !Array.isArray(data.members)) {
        console.error("📛 불완전한 채팅방 정보:", data);
        return;
      }
      const memberList = data.members;

      // 인원 수
      const countEl = document.querySelector("#memberCount");
      if (countEl) countEl.innerText = memberList.length;

      // 참가자 목록
      const listBox = document.querySelector("#memberList");
      if (listBox) {
        listBox.innerHTML = "";

        memberList.forEach(member => {
          // 로그인한 본인은 목록에서 제외
          if (Number(member.memberNo) !== Number(loginMemberNo)) {
            const li = document.createElement("li");
            li.classList.add("member-list-item");

            li.innerHTML = `
              <div class="profile profile-inList">
                <img src="${member.profileImg || '/resources/images/user.png'}" alt="프로필">
              </div>
              <span class="member-nickname">${member.memberNick}</span>
            `;

            // 방장이라면 해당 멤버 클릭 시 추방 처리
            if (Number(loginMemberNo) === Number(data.ownerMemberNo)) {
              li.style.cursor = "pointer";
              li.title = "클릭 시 추방";

              li.addEventListener("click", () => {
                const confirmKick = confirm(`${member.memberNick}님을 추방하시겠습니까?`);
                if (confirmKick) {
                  fetch(`/chatting/kickMember`, {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({
                      roomNo: roomNo,
                      targetMemberNo: member.memberNo
                    })
                  })
                    .then(res => res.json())
                    .then(result => {
                      if (result.success) {
                        alert("추방되었습니다.");
                        loadChatRoomDetail(roomNo); // 다시 로딩해서 목록 갱신
                      } else {
                        alert("추방에 실패했습니다.");
                      }
                    })
                    .catch(err => {
                      console.error("❌ 추방 실패", err);
                      alert("오류가 발생했습니다.");
                    });
                }
              });
            }

            listBox.appendChild(li);
          }
        });
      }

      // 토글 버튼 이벤트 (처음만 등록)
      const toggleBtn = document.getElementById("memberListBtn");
      toggleBtn?.addEventListener("click", e => {
        e.preventDefault(); // a 태그니까 기본 동작 제거
        document.getElementById("memberListBox")?.classList.toggle("hidden");
      });

      // 토글 버튼 이벤트는 항상 다시 등록
      const memberBox = document.getElementById("memberListBox");

      if (toggleBtn && memberBox) {
        // 기존 이벤트 제거 후 재등록 (보장용)
        toggleBtn.replaceWith(toggleBtn.cloneNode(true));
        const newToggleBtn = document.getElementById("memberListBtn");

        newToggleBtn.addEventListener("click", e => {
          e.preventDefault(); // a 태그니까 기본 동작 제거
          memberBox.classList.toggle("hidden");
        });
      }

      // 방 이름 설정
      const titleEl = document.getElementById("roomTitle");
      if (titleEl) titleEl.innerText = data.roomName;

    })
    .catch(err => console.error("🔴 채팅방 상세 로딩 실패", err));
}






























































































































































































































































/* -------------------------------------------------------------------------------- */

