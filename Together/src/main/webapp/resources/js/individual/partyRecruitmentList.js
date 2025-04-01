document.addEventListener("DOMContentLoaded", function () {
    const badges = document.querySelectorAll(".badge");

    badges.forEach(badge => {
        const status = badge.getAttribute("data-status");

        switch (status) {
            case "진행":
                badge.style.backgroundColor = "#FFD700"; // 노랑
                badge.style.color = "black";
                break;
            case "마감":
                badge.style.backgroundColor = "#800080"; // 보라
                badge.style.color = "white";
                break;
            case "완료":
                badge.style.backgroundColor = "#ff66b2"; // 핑크
                badge.style.color = "white";
                break;
            default:
                badge.style.backgroundColor = "#A9A9A9"; // 기본 회색
                badge.style.color = "white";
                break;
        }
    });


});

// 상품 이미지 캐러셀
document.addEventListener("DOMContentLoaded", function () {
    const track = document.querySelector(".carousel-track");
    const items = document.querySelectorAll(".carousel-item");
    const totalSlides = items.length;
    let currentIndex = 1; // 첫 번째 실제 이미지에서 시작 (복제된 이미지 때문에 1부터 시작)
    
    // 첫 번째 & 마지막 이미지 복제하여 무한 루프 구현
    const firstClone = items[0].cloneNode(true);
    const lastClone = items[totalSlides - 1].cloneNode(true);
    
    track.appendChild(firstClone); // 마지막 뒤에 첫 번째 복제
    track.insertBefore(lastClone, items[0]); // 처음 앞에 마지막 복제
    
    const allSlides = document.querySelectorAll(".carousel-item"); // 복제 포함한 전체 리스트
    const totalSlidesWithClones = allSlides.length;
    
    // 초기 위치 설정 (첫 번째 실제 이미지가 중앙에 오도록)
    track.style.transform = `translateX(-${100}%)`;

    function moveSlide(direction) {
        currentIndex += direction;
        track.style.transition = "transform 0.5s ease-in-out";
        track.style.transform = `translateX(-${currentIndex * 100}%)`;

        // 마지막에서 첫 번째로 자연스럽게 이동
        if (currentIndex === totalSlidesWithClones - 1) {
            setTimeout(() => {
                track.style.transition = "none";
                currentIndex = 1;
                track.style.transform = `translateX(-${100}%)`;
            }, 500);
        }

        // 첫 번째에서 마지막으로 자연스럽게 이동
        if (currentIndex === 0) {
            setTimeout(() => {
                track.style.transition = "none";
                currentIndex = totalSlidesWithClones - 2;
                track.style.transform = `translateX(-${currentIndex * 100}%)`;
            }, 500);
        }
    }

    window.moveSlide = moveSlide;
});

// 댓글 ajax
document.addEventListener("DOMContentLoaded", function () {
    const commentBtn = document.querySelector(".comment-btn");
    const commentInput = document.querySelector(".comment-input");
    const hiddenBoardNo = document.getElementById("boardNo");

    commentBtn.addEventListener("click", function () {
        const replyContent = commentInput.value.trim();
        const boardNo = parseInt(hiddenBoardNo.value, 10); // 숫자로 변환

        if (!replyContent) {
            alert("댓글을 입력해주세요.");
            return;
        }

        fetch("/reply/add", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                replyContent: replyContent,
                boardNo: boardNo
            }),
        })
        .then(response => response.text())
        .then(result => {
            if (result === "success") {
                alert("댓글이 등록되었습니다.");
                location.reload();
            } else if (result === "fail") {
                alert("댓글 등록 실패");
            } else {
                alert(result); // "로그인이 필요합니다." 등
            }
        })
        .catch(error => console.error("Error:", error));
    });
});
    
    
// 댓글 삭제
function deleteReply(replyNo, btn) {
    if (!confirm("정말로 댓글을 삭제하시겠습니까?")) {
        return;
    }
    
    fetch("/reply/delete", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ replyNo: replyNo })
    })
    .then(response => response.text())
    .then(result => {
        if (result === "success") {
            alert("댓글이 삭제되었습니다.");
            const commentBox = btn.closest(".comment");
            commentBox?.remove();
        } else if (result === "loginNeeded") {
            alert("로그인이 필요합니다.");
        } else {
            alert("댓글 삭제 실패");
        }
    })
    .catch(error => console.error("Error:", error));
}

/* 수정 버튼 */
function openEditPopup(recruitmentNo, boardNo) {
    const width = 930;
    const height = 700;
    const left = (window.screen.width / 2) - (width / 2);
    const top = (window.screen.height / 2) - (height / 2);
    const options = `width=${width},height=${height},left=${left},top=${top},resizable=no,scrollbars=yes`;

    window.open(`/group/edit?recruitmentNo=${recruitmentNo}&boardNo=${boardNo}`, "groupEditPopup", options);
}

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
    modal.dataset.recruitmentNo = typeKey === "recruitmentNo" ? typeValue : "";
    modal.dataset.replyNo = typeKey === "replyNo" ? typeValue : "";
    modal.dataset.messageNo = typeKey === "messageNo" ? typeValue : "";
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







  // 관리자 게시글 삭제
  function deleteBoard(boardNo) {
    if (!confirm("정말 이 모집글을 삭제하시겠습니까?")) return;
  
    fetch("/board/delete", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ boardNo })
    })
      .then(res => res.text())
      .then(result => {
        if (result === "success") {
          alert("삭제되었습니다.");
          location.href = "/"; 
        } else {
          alert("삭제 실패");
        }
      })
      .catch(err => {
        console.error("❌ 삭제 오류", err);
        alert("오류가 발생했습니다.");
      });
  }