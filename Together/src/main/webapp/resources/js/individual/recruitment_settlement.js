document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");
    const paymentBtn = document.querySelector(".payment-btn");

    paymentBtn.addEventListener("click", function (e) {
        const currentPoint = parseInt(document.getElementById("currentPoint").value);
        const paymentAmount = parseInt(document.getElementById("paymentAmount").value);

        if (currentPoint < paymentAmount) {
            alert("보유 포인트가 부족합니다. 참여할 수 없습니다.");
            e.preventDefault();
        }
    });
});

//-------------------------------------------------------------------------//
// 닉네임 클릭 시 메뉴 띄우기 (위임)
document.addEventListener("click", function (e) {
    const target = e.target;
  
    // 닉네임 클릭했을 경우
    if (target.classList.contains("clickable-nickname")) {
      // 로그인 안 했을 경우 경고 후 종료
      if (!loginMember || !loginMember.memberNo) {
        alert("로그인이 필요한 기능입니다.");
        return;
      }
  
      const menu = document.getElementById("nicknameMenu");
      const rect = target.getBoundingClientRect();
  
      // 메뉴 위치 조정
      menu.style.top = `${rect.bottom + window.scrollY + 5}px`;
      menu.style.left = `${rect.left}px`;
      menu.classList.remove("hidden");
  
      // 메뉴에 대상 정보 저장
      menu.dataset.targetNo = target.dataset.memberNo;
      menu.dataset.targetNick = target.dataset.memberNick;
      menu.dataset.recruitmentNo = target.dataset.recruitmentNo || "";

      menu.dataset.messageNo = target.dataset.messageNo || "";
      menu.dataset.replyNo = target.dataset.replyNo || "";
      menu.dataset.recruitmentNo = target.dataset.recruitmentNo || "";
    }
  
    // 메뉴 외부 클릭 시 숨기기
    else if (!e.target.closest("#nicknameMenu")) {
      document.getElementById("nicknameMenu")?.classList.add("hidden");
    }
  });

// '1대1 채팅' 클릭 시
document.getElementById("startPrivateChat")?.addEventListener("click", () => {
    const menu = document.getElementById("nicknameMenu");
  
    const targetNo = menu.dataset.targetNo;
    const targetNick = menu.dataset.targetNick;

    if (Number(loginMember.memberNo) === Number(targetNo)) {
        alert("자기 자신과는 1대1 채팅을 시작할 수 없습니다.");
        return;
      }

  
  
    fetch("/chatting/private/start", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        targetMemberNo: targetNo,
        targetNick: targetNick
      })
    })
      .then(res => res.json())
      .then(result => {
        if (result.success) {
          alert("1대1 채팅방이 만들어졌습니다.");
          if (!sideBar.classList.contains("active")) {
            sideBarClose?.click(); 
          }
          const roomNo = result.roomNo; 
          menu.classList.add("hidden");
  
          // 채팅방 열기 (사이드바 전용)
          fetch(`/sidebar/chatOpen?chattingNo=${roomNo}`)
            .then(res => res.text())
            .then(html => {
              const contentBox = document.querySelectorAll("#CHAT .content")[0];
              contentBox.innerHTML = html;
  
              // 필수 바인딩 함수들 호출
              bindChatRoomHeaderButtons?.();
              bindSendMessageEvent?.();
              bindImageUploadEvent?.();
              bindEmojiEvent?.();
  
              connectChatWebSocket?.(roomNo);
              loadMessageList?.();
              loadChatRoomDetail?.(roomNo);
  
              // 탭 상태 업데이트
              const talkMenus = document.querySelectorAll(".talkMenu");
              talkMenus.forEach(menu => {
                menu.classList.remove("select", "unselect");
                menu.classList.add("unselect");
              });
  
              const chatTab = document.querySelector(".talkMenu a[data-url*='/sidebar/chatOpen']")?.closest(".talkMenu");
              chatTab?.classList.remove("unselect");
              chatTab?.classList.add("select");
            });
        } else {
          alert("채팅방이 이미 존재하거나 오류가 발생했습니다.");
        }
      })
      .catch(err => {
        console.error("❌ 1대1 채팅 오류", err);
      });
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


// --- 신고하기 클릭 ---
document.getElementById("reportUser")?.addEventListener("click", () => {
    const menu = document.getElementById("nicknameMenu");
    const targetNo = menu.dataset.targetNo;
    console.log(targetNo)
    console.log(loginMember.memberNo)
    if (Number(loginMember.memberNo) === Number(targetNo)) {
        alert("자기 자신은 신고할 수 없습니다.");
        return;
    }

    const payload = {
      targetNo: menu.dataset.targetNo,
      targetNick: menu.dataset.targetNick,
      productName: menu.dataset.productName,
      typeKey: menu.dataset.messageNo ? "messageNo" :
               menu.dataset.replyNo ? "replyNo" :
               "recruitmentNo",
      typeValue: menu.dataset.messageNo || menu.dataset.replyNo || menu.dataset.recruitmentNo,
      loginMemberNickname
    };

    openReportModal(payload);
    menu.classList.add("hidden");
  });

  function openReportModal({ targetNo, targetNick, productName, typeKey, typeValue }) {
    const modal = document.getElementById("modal");
    modal.classList.add("show");

    modal.dataset.targetNo = targetNo;
    modal.dataset[typeKey] = typeValue;
    modal.dataset.reportType = typeKey;

    document.getElementById("reportTitle").value = ""; // 사용자가 직접 입력하도록 초기화
    document.getElementById("reporterName").innerText = loginMemberNickname;
    document.getElementById("reportReason").innerText = "";
  }

  function closeReportModal() {
    const modal = document.getElementById("modal");
    modal.classList.remove("show");
  }

  function submitReport() {
    const modal = document.getElementById("modal");
    const reportDetail = document.getElementById("reportReason").innerText;
    const reportTitle = document.getElementById("reportTitle").value;
    const payload = {
      reportTitle: reportTitle,
      reportDetail: reportDetail,
      reportedUserNo: modal.dataset.targetNo,
      reportDate: new Date().toISOString(),
      mReply: "",
    };
    
    if (modal.dataset.recruitmentNo) {
        payload.reportType = 2;
        payload.reportTypeNo = Number(modal.dataset.recruitmentNo);
      } else if (modal.dataset.replyNo) {
        payload.reportType = 3;
        payload.reportTypeNo = Number(modal.dataset.replyNo);
      } else if (modal.dataset.messageNo) {
        payload.reportType = 4;
        payload.reportTypeNo = Number(modal.dataset.messageNo);
      } else {
        alert("신고할 대상을 찾을 수 없습니다.");
        return;
      }

    fetch("/report/submit", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload)
    })
    .then(res => res.json())
    .then(result => {
      if (result.success) {
        alert("신고가 접수되었습니다.");
        closeReportModal();
      } else {
        alert("신고에 실패했습니다.");
      }
    })
    .catch(err => {
      console.error("❌ 신고 처리 실패", err);
      alert("오류가 발생했습니다.");
    });
  }