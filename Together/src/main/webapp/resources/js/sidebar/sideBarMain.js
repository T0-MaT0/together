console.log("sideBarMain.js");

document.addEventListener("DOMContentLoaded", () => {
  updateSidebarTotalNoti();
});

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
const sideBarBox = document.getElementById("sidebar-menu-box");
const sideBarClose = document.getElementById("sideBar-close");


sideBarBox.addEventListener("click", function (e) {
  if (sideBar.classList.contains("active") || !sideBarClose.classList.contains("activate")) {
    return;
  }
  sideBar.classList.add("active");
  sideBarClose.classList.remove("activate");

});

sideBarClose.addEventListener("click", function (e) {
  e.stopPropagation();
  sideBar.classList.toggle("active");
  sideBarClose.classList.toggle("activate");
});




let fullChatList = [];

// 채팅방 목록 비동기 로딩
function loadChatRoomList() {
  fetch("/chatting/roomList")
    .then(response => response.json())
    .then(chatList => {
      fullChatList = chatList; // 전체 목록 저장
      renderChatRoomList(fullChatList); // 화면 출력
      bindChatRoomSearchEvent(); // 검색 필터 이벤트 연결

      if (!chatSse) connectChatSSE(); // SSE 연결 (한 번만)
      if (!chattingSock || chattingSock.readyState !== 1) {
        // 가장 최근 채팅방 번호로 WebSocket 연결
        const latestRoom = chatList[0];
        if (latestRoom) connectChatWebSocket(latestRoom.roomNo);
      }
    })
    .catch(err => {
      console.error("채팅방 목록 불러오기 실패", err);
    });
}

// 채팅방 목록 출력 함수
function renderChatRoomList(chatList) {
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

    div.dataset.roomNo = chat.roomNo;
    div.dataset.roomName = chat.roomName;
    div.dataset.ownerProfile = chat.ownerProfile;

    let lastMessage = chat.lastMessage;
    if (lastMessage?.includes('/resources/images/')) {
      lastMessage = '이미지';
    } else if (!lastMessage || lastMessage.trim() === '') {
      lastMessage = '대화를 시작해보세요!';
    }

    const profileImgSrc = chat.groupFl === 'N'
      ? (chat.targetProfile || '/resources/images/user.png')
      : (chat.ownerProfile || '/resources/images/user.png');

    const roomLabel = chat.groupFl === 'Y'
      ? `[그룹] ${chat.roomName}`
      : chat.targetNickname || chat.roomName;

    div.innerHTML = `
      <div class="profile-box">
        <div class="profile profile-inBox">
          <img src="${profileImgSrc}" alt="">
        </div>
      </div>
      <div class="chat">
        <div class="chat-name">${roomLabel}</div>
        <div class="chat-content">${lastMessage}</div>
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
      const targetNickname = chat.targetNickname;
      const targetProfile = chat.targetProfile;
      const targetUrl = `/sidebar/chatOpen?chattingNo=${chattingNo}`;

      fetch(targetUrl)
        .then(res => res.text())
        .then(html => {
          const contentBox = document.querySelectorAll("#CHAT .content")[0];
          contentBox.innerHTML = html;

          const roomTitleElem = document.querySelector("#roomTitle");
          roomTitleElem.innerText = chat.groupFl === 'Y' ? roomName : targetNickname;

          const ownerImg = document.querySelector("#ownerProfileImg");
          ownerImg.src = chat.groupFl === 'Y'
            ? (ownerProfile && ownerProfile !== "null" ? ownerProfile : "/resources/images/user.png")
            : (targetProfile && targetProfile !== "null" ? targetProfile : "/resources/images/user.png");


          bindChatRoomHeaderButtons();
          bindSendMessageEvent();
          bindImageUploadEvent();
          bindEmojiEvent();

          connectChatWebSocket?.(chattingNo);
          loadMessageList?.();
          loadChatRoomDetail(chattingNo);

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
}

// 검색 이벤트 바인딩
function bindChatRoomSearchEvent() {
  const input = document.getElementById("sideBar-input");
  if (!input) return;

  input.addEventListener("input", function () {
    const keyword = this.value.trim().toLowerCase();

    const filtered = fullChatList.filter(chat =>
      chat.roomName?.toLowerCase().includes(keyword)
    );

    renderChatRoomList(filtered);
  });
}









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

// SSE 전역
let chatSse;

// 채팅방 열릴 때 호출 WebSocket + SSE 연결
function connectChatWebSocket(roomNo) {
  // 기존 WebSocket 종료
  if (chattingSock && chattingSock.readyState === 1) {
    chattingSock.close();
    chattingSock = null;
  }

  // 새 WebSocket 연결
  chattingSock = new SockJS("/chattingSock?roomNo=" + roomNo);
  console.log("✅ SockJS 연결 시도 / roomNo =", roomNo);

  chattingSock.onopen = () => {
    console.log("🟢 SockJS 연결됨 / roomNo =", roomNo);
  };

  chattingSock.onmessage = (e) => {
    const msg = JSON.parse(e.data);
    displayMessage(msg);
    loadChatRoomList?.();
  };

  chattingSock.onclose = () => {
    console.log("🔴 SockJS 연결 종료");
  };

  chattingSock.onerror = (err) => {
    console.error("❌ SockJS 오류 발생:", err);
  };

  // SSE 연결 갱신
  reconnectChatSSE();
}

// 연결 종료
function disconnectChatSSE() {
  if (chatSse) {
    console.log("🛑 기존 SSE 연결 종료");
    chatSse.close();
    chatSse = null;
  }
}

// 연결 시작
function connectChatSSE() {
  if (chatSse) return; // 이미 연결되어 있으면 무시

  chatSse = new EventSource("/chat/notification/connect");

  chatSse.addEventListener("connect", (e) => {
    console.log("✅ Chat SSE 연결됨");
  });

  chatSse.addEventListener("chat", (e) => {
    console.log("💬 알림 수신:", e.data);
    const notification = JSON.parse(e.data);
    showChatNotification(notification);
    loadChatRoomList?.();
  });

  chatSse.onerror = (e) => {
    console.error("❌ SSE 오류:", e);
    disconnectChatSSE();
    // 필요시 재연결 로직 추가
  };
}

// 연결 재시작
function reconnectChatSSE() {
  disconnectChatSSE();
  connectChatSSE();
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
          nicknameDiv.dataset.messageNo = msg.messageNo;
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
    minusBtn.addEventListener("click", function (e) {
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
    plusBtn.addEventListener("click", function (e) {
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
    sendBtn.addEventListener("click", function (e) {
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

      // WebSocket으로 메시지 전송
      chattingSock.send(JSON.stringify(msgObj));
      input.value = "";

      // 🔔 SSE 알림용 알림 전송
      fetch("/chat/notification/send", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ roomNo: roomNo })
      })
        .then(res => {
          if (!res.ok) throw new Error("알림 전송 실패");
          return res.text();
        })
        .then(() => {
          console.log("🔔 채팅 알림 전송 완료");
        })
        .catch(err => {
          console.error("❌ 알림 전송 오류:", err);
        });
    });
  }

  const textarea = document.getElementById("inputChatting");

  textarea.addEventListener("keydown", function (e) {
    if (e.key === "Enter") {
      if (e.shiftKey) {
        return; // Shift + Enter → 줄바꿈
      } else {
        e.preventDefault(); // 줄바꿈 막기
        sendBtn.click(); // 버튼 클릭
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
  window.insertEmojiToInput = function (emoji) {
    const input = document.getElementById("inputChatting");
    const cursorPos = input.selectionStart;
    input.value = input.value.substring(0, cursorPos) + emoji + input.value.substring(cursorPos);
    input.focus();
  };

  // 큰 이모지 전송 함수
  window.sendBigEmoji = function (emojiPath) {
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
  toggleBtn?.addEventListener("click", function (e) {
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

      fetch("/chat/notification/read", {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ roomNo: roomNo })
      });

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


// 상담톡 설정
document.querySelector("#consultMenu a")?.addEventListener("click", e => {
  e.preventDefault();

  if (!confirm("상담톡을 연결하시겠습니까?")) return;


  fetch("/chatting/private/start", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      targetMemberNo: 1,
      targetNick: "To-mato 상담사"
    })
  })
    .then(res => res.json())
    .then(result => {
      if (result.success) {
        const chattingNo = result.roomNo;
        const targetUrl = `/sidebar/chatOpen?chattingNo=${chattingNo}`;

        fetch(targetUrl)
          .then(res => res.text())
          .then(html => {
            const contentBox = document.querySelectorAll("#CHAT .content")[0];
            contentBox.innerHTML = html;

            document.querySelector("#roomTitle").innerText = "To-mato 상담사";
            document.querySelector("#ownerProfileImg").src = "/resources/images/user.png";

            // 필수 기능 바인딩
            bindChatRoomHeaderButtons();
            bindSendMessageEvent();
            bindImageUploadEvent();
            bindEmojiEvent();

            connectChatWebSocket?.(chattingNo);
            loadMessageList?.();
            showFAQIfCounselingRoom()
            initFAQEvent();
            loadChatRoomDetail(chattingNo);


            // 사이드바 메뉴 버튼 UI 처리
            const talkMenus = document.querySelectorAll(".talkMenu");
            talkMenus.forEach(menu => {
              menu.classList.remove("select", "unselect");
              menu.classList.add("unselect");
            });

            // 여기서 현재 클릭한 메뉴에 select 적용
            document.querySelector("#consultMenu")?.classList.remove("unselect");
            document.querySelector("#consultMenu")?.classList.add("select");
          });
      } else {
        alert("상담톡 연결에 실패했습니다.");
      }
    })
    .catch(err => {
      console.error("❌ 상담톡 생성 실패", err);
    });
});


function initFAQEvent() {
  document.querySelectorAll("#faqList li").forEach(item => {
    item.addEventListener("click", () => {
      const answer = item.dataset.answer;

      // 상담사 메시지처럼 DOM에 출력
      const messageList = document.getElementById("chatMessageList");

      const li = document.createElement("li");
      li.classList.add("chat-left"); // 왼쪽 채팅 스타일 (상담사)

      li.innerHTML = `
        <div class="chat-profile">
          <img src="/resources/images/mypage/관리자 프로필.webp" alt="상담사">
        </div>
        <div class="chat-bubble">
          ${answer}
        </div>
      `;

      messageList.appendChild(li);
      messageList.scrollTop = messageList.scrollHeight;
    });
  });

  document.getElementById("faqToggleBtn")?.addEventListener("click", function () {
    const list = document.getElementById("faqList");
    const isOpen = list.classList.contains("show");

    if (isOpen) {
      list.classList.remove("show");
      this.innerText = "자주 묻는 질문 메뉴 ▼";
    } else {
      list.classList.add("show");
      this.innerText = "자주 묻는 질문 메뉴 ▲";
    }
  });
}

function showFAQIfCounselingRoom() {
  const roomTitle = document.getElementById("roomTitle")?.innerText;
  const box = document.getElementById("faqToggleBox");

  if (roomTitle && roomTitle.includes("상담사")) {
    box?.classList.remove("hidden");
  } else {
    box?.classList.add("hidden");
  }
}

document.getElementById("faqToggleBtn")?.addEventListener("click", toggleFAQ);

function increaseChatRoomNotification(roomNo) {
  const chatRoom = document.querySelector(`.chat-room[data-room-no="${roomNo}"]`);
  if (!chatRoom) return;

  const badge = chatRoom.querySelector(".noti-chat span");

  if (badge) {
    let count = Number(badge.innerText) || 0;
    count += 1;
    badge.innerText = count;
    badge.parentElement.style.display = "flex";
  }
}


let eventSource = null;

function connectChatSSE() {
  if (eventSource) return; // 중복 연결 방지

  eventSource = new EventSource("/chat/notification/connect");

  eventSource.onopen = () => {
    console.log("✅ Chat SSE 연결됨");
  };

  eventSource.addEventListener("chat", e => {
    console.log("📩 채팅 알림 수신:", e.data);
    const notification = JSON.parse(e.data);
    showChatNotification(notification);
    loadChatRoomList();
    updateSidebarTotalNoti();
  });

  eventSource.onerror = e => {
    console.error("❌ SSE 오류:", e);
    eventSource.close();
    eventSource = null;
    // 재연결 로직 넣을 수 있음
  };
}

function showChatNotification(notification) {
  const notiBadge = document.querySelector("#chatNotiBadge");

  if (!notiBadge) return;

  const count = parseInt(notiBadge.innerText || 0) + 1;
  notiBadge.innerText = count;
  notiBadge.style.display = "inline-block";

  console.log("🔔 채팅 알림: ", notification);
}

function updateSidebarTotalNoti() {
  fetch("/chat/notification/count")
    .then(res => res.text())
    .then(count => {
      const badge = document.querySelector("#chatNotiBadge");
      if (badge) {
        badge.innerText = count;
        badge.style.display = count > 0 ? "inline-block" : "none";
      }
    });
}


/* 
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

  toggleTitle.innerText = isChat ? "장바구니" : "채팅";
  flag = isChat ? 1 : 0;

  Array.from(toggleBodies).forEach(body => body.classList.toggle("hidden"));

  if (isChat) {
    initializeChatTabs();

    const firstTab = document.querySelector('#CHAT .talkMenu > a.no-link[data-url]');
    if (firstTab) firstTab.click();
  }
});

 */


const togglePageBtn = document.getElementById("togglePage");
const togglePageIcon = document.getElementById("togglePageIcon");
const searchPageBtn = document.getElementById("searchPage");


const sidebarWrapper = document.getElementsByClassName("sidebar-wrapper")
// 0. 채팅
// 1. 장바구니
// 2. 통합검색


let currentPage = 0; // 현재 페이지 상태 (0: 채팅, 1: 장바구니, 2, 3: 통합검색)
// 2 : 채팅 -> 통합검색
// 3 : 장바구니 -> 통합검색


togglePageBtn.addEventListener("click", () => {

  currentPage = (currentPage + 1) % 2;



  if (currentPage === 0) {
    sidebarWrapper[0].classList.remove("hidden");
    sidebarWrapper[1].classList.add("hidden");
    sidebarWrapper[2].classList.add("hidden");

    togglePageIcon.setAttribute("src", "/resources/images/sidebar/images/favorite-cart.svg");

    initializeChatTabs();
    const firstTab = document.querySelector('#CHAT .talkMenu > a.no-link[data-url]');
    if (firstTab) firstTab.click();
  }


  if (currentPage === 1) {
    sidebarWrapper[0].classList.add("hidden");
    sidebarWrapper[1].classList.remove("hidden");
    sidebarWrapper[2].classList.add("hidden");


    togglePageIcon.setAttribute("src", "/resources/images/sidebar/images/talk.svg");

    // 비동기 로딩
    
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
        
  
        data.forEach(item => {
          
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
          digit.appendChild(priceDiv);
          
          const companyDiv = document.createElement("div");
          companyDiv.innerHTML = `<span>${item.price}원(원가)</span>`;
          digit.appendChild(companyDiv);
          const companyDiv2 = document.createElement("div");
          digit.appendChild(companyDiv2);
  
          const quantityDiv = document.createElement("div");
          quantityDiv.innerHTML = `<div>조회수 : <span>${item.readCount}</span></div>`;
          digit.appendChild(quantityDiv);
          
          const deleteBtnArea = document.createElement("div");
          deleteBtnArea.className = "deleteBtn-area";
          
          const deleteLink = document.createElement("a");
          deleteLink.href = `/board/${item.boardCode}/${item.boardNo}`; 
          deleteLink.innerText = "보러가기"
          
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


  }
});

searchPageBtn.addEventListener("click", () => {
  if (currentPage < 2) {
    currentPage = currentPage + 2
  } else {
    return;
  }

  sidebarWrapper[0].classList.add("hidden");
  sidebarWrapper[1].classList.add("hidden");
  sidebarWrapper[2].classList.remove("hidden");

});




const minValue = document.getElementById("minValue");
const maxValue = document.getElementById("maxValue");

// 숫자 -> 금액 문자열로 변환
function transferValue( value) {
  if (value == 10) return '0';
  if (value == 20) return '10000';
  if (value == 30) return '100000';
  if (value == 40) return '999999~';
  
  
  

  let numString = value.toString();  
  let n = +numString[0];
  let a = +numString[1];

  console.log(n, a);
  return a*100*(10**(n));
}

// 범위 슬라이더 
class RangeSlider {
  constructor() {
    this.constants = {
      MAX_VALUE: this.getGlobalCssValue('--max-value'),
      MIN_VALUE: this.getGlobalCssValue('--min-value'),
      RANGE_STEP: this.getGlobalCssValue('--range-step'),
      HANDLE_SIZE: this.getGlobalCssValue('--handle-size'),
      get RANGE() {
        return this.MAX_VALUE - this.MIN_VALUE;
      }
    };

    this.elements = {
      progressBar: document.querySelector('.progressBar'), // 변경된 클래스 이름
      minRange: document.querySelector('.min-range'),
      maxRange: document.querySelector('.max-range'),
      handles: document.querySelectorAll('.handle')
    };

    this.elements.minRange.addEventListener("input", (e) => {
      let value = transferValue(+e.target.value);
      if (value == '999999~') {
        value = '990000';
      }

      if (value > +maxValue.innerText) {
        value = +maxValue.innerText;
      }

      minValue.innerText = value;
      this.setStartValue(+e.target.value);
    });

    this.elements.maxRange.addEventListener("input", (e) => {
      let value = transferValue(+e.target.value);
      if (value == 0) {
        value = 1000;
      }

      if (value < +minValue.innerText) {
        value = +minValue.innerText;
      }
      
      maxValue.innerText = value;
      this.setEndValue(+e.target.value);
    });
  }

  getGlobalCssValue(key) {
    const property = getComputedStyle(document.documentElement).getPropertyValue(key);
    return property ? parseFloat(property) : 0;
  }

  init({ min, max }) {
    const { MIN_VALUE, MAX_VALUE, RANGE_STEP } = this.constants;
    const { minRange, maxRange } = this.elements;

    minRange.min = maxRange.min = MIN_VALUE;
    minRange.max = maxRange.max = MAX_VALUE;
    minRange.step = maxRange.step = RANGE_STEP;
    
    // Initialize values
    minRange.value = min; 
    maxRange.value = max;
    
    this.setStartValue(min);
    this.setEndValue(max);
  }

  setHandlePos(range, handle) {
    const { MIN_VALUE, RANGE, HANDLE_SIZE } = this.constants;
    const percentage = (range.value - MIN_VALUE) / RANGE;
    const offset = HANDLE_SIZE / 2 - HANDLE_SIZE * percentage;
    const left = `calc(${percentage * 100}% + ${offset}px)`;
    handle.style.left = left;
  }

  setStartValue(v) {
    const { minRange, maxRange, progressBar, handles } = this.elements;
    if (v >= +maxRange.value) {
      v = +maxRange.value - this.constants.RANGE_STEP;
      minRange.value = v;
    }
    const value = this.getCurrStep(v) * this.constants.RANGE_STEP;
    progressBar.style.left = `${(value / this.constants.RANGE) * 100}%`;
    this.setHandlePos(minRange, handles[0]);
  }

  setEndValue(v) {
    const { minRange, maxRange, progressBar, handles } = this.elements;
    if (v <= +minRange.value) {
      v = +minRange.value + this.constants.RANGE_STEP;
      maxRange.value = v;
    }
    const value = this.getCurrStep(v) * this.constants.RANGE_STEP;
    progressBar.style.right = `${100 - (value / this.constants.RANGE) * 100}%`;
    this.setHandlePos(maxRange, handles[1]);
  }

  getCurrStep(v) {
    return (v - this.constants.MIN_VALUE) / this.constants.RANGE_STEP;
  }
}


// 범위 슬라이더 초기화
const slider = new RangeSlider();
slider.init({ min: 10, max: 40 });






// 검색 버튼 클릭 시
const sideBarSearchBtn = document.getElementById("sideBarSearchBtn");
const sideBarSearchInput = document.getElementById("sideBarSearchInput");


/* <div class="body" id="SEARCH">
        <div class="sideBox search">
          <div class="category" data-categoryNo="0">ALL</div>
          <div class="category" data-categoryNo="1">패션</div>
          <div class="category" data-categoryNo="2">뷰티</div>
          <div class="category" data-categoryNo="3">생활</div>
          <div class="category" data-categoryNo="4">식품</div>
          <div class="category" data-categoryNo="5">전자제품</div>
          <div class="category" data-categoryNo="6">공구</div>
          <div class="category" data-categoryNo="7">자동차</div>
          <div class="category" data-categoryNo="8">스포츠 레저</div>
          <div class="category" data-categoryNo="9">유아  아동</div>
          <div class="category" data-categoryNo="10">도서  문구</div>
          <div class="category" data-categoryNo="11">반려동물</div>
        </div>




        <div class="content search">
          <div class="member-bar" id="memberBar">
            <div class="under-line company-line" id="underLine"></div>
            <a class="member-type bold" data-type="personal">브랜드 상품</a>
            <a class="member-type" data-type="company">공구 모집</a>
            <div id="bottomLine"></div>
          </div>
          <div class="item" id = "locationList">
            <div class="itemName">지역 <span>Location</span></div>

            <div class="itemContents">
              <div class="itemContent BTN selected">GPS 검색</div>
              <div class="itemContent BTN">직접 선택</div>
            </div>
              

          </div>
          <div class="item" id = "priceRange">
            <div class="itemName">가격 <span>Price</span></div>

            <div class="itemRange">
              <div class="range-slider-container">

                <div class="slider-track"> 
                  <div class="progressBar"></div>
                </div>
              
                <label>
                  <span class="handle min"><span id="minValue">0</span></span>
                  <input type="range" class="min-range range-input">
                </label>
              
                <label>
                  <span class="handle max"><span id="maxValue">990000~</span></span>
                  <input type="range" class="max-range range-input">
                </label>

              </div>
            </div>
              

          </div>
          <div class="item" id = "categoryList">
            <div class="itemName" >카테고리 <span>Category</span></div>

            <div class="itemContents" id="categoryListItems">
              <div class="itemContent BTN selected" data-subCategoryNo="12">여성 의류</div>
              <div class="itemContent BTN ">남성 의류</div>
              <div class="itemContent BTN selected">아동 의류</div>
              <div class="itemContent BTN ">신발</div>
              <div class="itemContent BTN selected"> 가방 & 액서서리</div>
              <div class="itemContent BTN ">스포츠웨어</div>
              <div class="itemContent BTN ">스포츠웨어</div>
            </div>
              

          </div>
            




          </div>
        </div> */

// 카테고리 선택

const categories = document.querySelectorAll(".category");

categories.forEach(category => {
  category.addEventListener("click", function () {
    categories.forEach(c => c.classList.remove("selected"));
    this.classList.add("selected");

    const categoryNo = parseInt(this.getAttribute("data-categoryNo"), 10);
    const categoryList = document.getElementById("categoryListItems");
    if (categoryNo === 0) {
      categoryList.innerHTML = "카테고리가 너무 많습니다. <br>원하는 분류를 선택해주세요."; 
      return;
    }
    
    fetch("/ajax/getCategory", {
      method: "post",
      headers: { "Content-Type": "application/json" },
      body: categoryNo
    })
    .then(response => response.json())
    .then(data => {
      console.log(data);
      
      categoryList.innerHTML = ""; // 기존 내용 초기화

      data.forEach(item => {
        const itemDiv = document.createElement("div");
        itemDiv.className = "itemContent BTN";
        itemDiv.setAttribute("data-subCategoryNo", item.categoryNo);
        itemDiv.innerText = item.categoryName;
        
        // 클릭 시 선택 효과
        itemDiv.addEventListener("click", function () {
          this.classList.toggle("selected");
        });
        
        categoryList.appendChild(itemDiv);
      });
    })
    .catch(error => console.error("Error:", error));
  });
})



const memberBar = document.getElementById("memberBar");
const memberTypes = memberBar.querySelectorAll(".member-type");

memberTypes.forEach(type => {
  type.addEventListener("click", function () {
    memberTypes.forEach(t => t.classList.remove("bold"));
    this.classList.add("bold");

    const typeValue = this.getAttribute("data-type");
    const underLine = document.getElementById("underLine");
    const bottomLine = document.getElementById("bottomLine");

    if (typeValue === "personal") {
      underLine.classList.remove("personal-line");
      underLine.classList.add("company-line");
    } else {
      underLine.classList.remove("company-line");
      underLine.classList.add("personal-line");
    }
      


  });
});



























function openAddressSearch() {
  window.open("/address/search", "주소검색", "width=500,height=600");
}
function sample4_execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
            // 지번 주소가 있으면 우선 사용
            if (data.jibunAddress && data.jibunAddress !== "") {
              const parts = data.jibunAddress.split(" ");
              selectedAddress = parts.slice(0, 2).join(" ");
            }
            // 도로명 주소로 대체
            else if (data.roadAddress && data.roadAddress !== "") {
              const parts = data.roadAddress.split(" ");
              selectedAddress = parts.slice(0, 2).join(" ");
            }
      
      
      document.getElementById("sample4_jibunAddress").value = selectedAddress;
    }
  }).open();
}




























































































































































































/* -------------------------------------------------------------------------------- */

