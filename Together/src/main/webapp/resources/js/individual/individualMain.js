document.addEventListener("DOMContentLoaded", function () {
    loadRecruitmentList(); // 최신 등록순 불러오기
    loadExtraRecruitmentList(); // 추가 공동구매 목록 불러오기
});

let recruitmentData = []; // 최신 상품 데이터 저장 배열
let extraRecruitments = []; // 추가 공동구매 데이터 저장 배열
let currentRecruitmentIndex = 0; // 최신 상품 현재 인덱스
let currentExtraIndex = 0; // 추가 공동구매 현재 인덱스

const ITEMS_PER_LOAD = 8; // 최신 상품 한 번에 불러올 개수
const EXTRA_ITEMS_PER_LOAD = 8; // 추가 상품 한 번에 불러올 개수 (MORE 버튼 클릭 시)

// 날짜 포맷 함수
function formatDate(dateString) {
    if (!dateString) return "-";
    const date = new Date(dateString);
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    return `${month}/${day} ${hours}:${minutes}`;
}

// 최신 상품 불러오기 (최초 8개 표시)
function loadRecruitmentList() {
    fetch("/api/recruitment")
        .then(response => response.json())
        .then(data => {
            recruitmentData = data;
            currentRecruitmentIndex = 0;
            renderRecruitmentList();
        })
        .catch(err => console.error(err));
}

// 추가 공동 구매 불러오기 (최초 4개 표시)
function loadExtraRecruitmentList() {
    fetch("/api/recruitment/popular")
        .then(response => response.json())
        .then(data => {
            extraRecruitments = data;
            currentExtraIndex = 0;
            renderExtraRecruitmentList();
        })
        .catch(err => console.error("추가 공동구매 목록 불러오기 실패:", err));
}

// 최신 상품 목록 렌더링
function renderRecruitmentList() {
    const grid = document.querySelector(".product-grid");
    grid.innerHTML = "";

    let endIndex = Math.min(currentRecruitmentIndex + ITEMS_PER_LOAD, recruitmentData.length);

    for (let i = currentRecruitmentIndex; i < endIndex; i++) {
        const recruitment = recruitmentData[i];
        const progress = (recruitment.currentParticipants / recruitment.maxParticipants) * 100;
        const discount = Math.ceil(recruitment.productPrice / recruitment.maxParticipants);

        grid.innerHTML += `
            <div class="product">
                <img src="${recruitment.thumbnail != null ? recruitment.thumbnail : '/resources/images/mypage/관리자 프로필.webp'}" 
                alt="제품 이미지">
                ${recruitment.recruitmentNo}
                ${recruitment.boardNo}
                <p class="seller-info">
                    <span class="clickable-nickname"
                            data-member-no="${recruitment.hostNo}"
                            data-member-nick="${recruitment.hostName}">
                        ${recruitment.hostName}
                    </span>
                    (등급: ${recruitment.hostGrade})
                </p>
                <p class="product-name">${recruitment.productName}</p>
                <p class="discount-price">${discount}원</p>
                <p class="original-price">${recruitment.productPrice}원 (원가)</p>
                <p class="participants">📅 생성일: ${formatDate(recruitment.recCreatedDate)} ~</p> 
                <p class="participants">⏳ 마감일: ${formatDate(recruitment.recEndDate)}</p>
                <p class="participants">참가 모집 : ${recruitment.currentParticipants} / ${recruitment.maxParticipants}명</p>
                <div class="progress-button-container">
                    <div class="progress-container">
                        <span class="progress-label">${progress.toFixed(1)}%</span>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: ${progress}%;"></div>
                        </div>
                    </div>
                    <button class="join-btn ${recruitment.recruitmentStatus == '마감' ? 'closed-btn' : 'active-btn'}"
                            data-recruitment-no="${recruitment.recruitmentNo}"
                            data-board-no="${recruitment.boardNo}">
                        ${recruitment.recruitmentStatus == '진행' ? '참가' : recruitment.recruitmentStatus}
                    </button>
                </div>
            </div>
        `;
    }

    currentRecruitmentIndex = endIndex;
}

// 추가 공동 구매 목록 렌더링 (최초 4개, 이후 8개씩 추가)
function renderExtraRecruitmentList() {
    const grid = document.querySelector(".extra-products .product-grid");

    let endIndex = Math.min(currentExtraIndex + EXTRA_ITEMS_PER_LOAD, extraRecruitments.length);

    for (let i = currentExtraIndex; i < endIndex; i++) {
        const recruitment = extraRecruitments[i];
        const progress = (recruitment.currentParticipants / recruitment.maxParticipants) * 100;
        const discount = Math.ceil(recruitment.productPrice / recruitment.maxParticipants);

        grid.innerHTML += `
            <div class="product">
                <img src="${recruitment.thumbnail != null ? recruitment.thumbnail : '/resources/images/mypage/관리자 프로필.webp'}" 
                alt="제품 이미지">
                <p class="seller-info">
                    <span class="clickable-nickname"
                            data-member-no="${recruitment.hostNo}"
                            data-member-nick="${recruitment.hostName}">
                        ${recruitment.hostName}
                    </span>
                    (등급: ${recruitment.hostGrade})
                </p>
                <p class="product-name">${recruitment.productName}</p>
                <p class="discount-price">${discount}원</p>
                <p class="original-price">${recruitment.productPrice}원 (원가)</p>
                <p class="participants">📅 생성일: ${formatDate(recruitment.recCreatedDate)} ~</p> 
                <p class="participants">⏳ 마감일: ${formatDate(recruitment.recEndDate)}</p>
                <p class="participants">참가 모집 : ${recruitment.currentParticipants} / ${recruitment.maxParticipants}명</p>
                <div class="progress-button-container">
                    <div class="progress-container">
                        <span class="progress-label">${progress.toFixed(1)}%</span>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: ${progress}%;"></div>
                        </div>
                    </div>
                  <button class="join-btn ${recruitment.recruitmentStatus == '마감' ? 'closed-btn' : 'active-btn'}"
                            data-recruitment-no="${recruitment.recruitmentNo}"
                            data-board-no="${recruitment.boardNo}">
                        ${recruitment.recruitmentStatus == '진행' ? '참가' : recruitment.recruitmentStatus}
                    </button>
                </div>
            </div>
        `;
    }

    currentExtraIndex = endIndex;
}

// "더 보기" 버튼 클릭 시 추가 8개 로드
document.querySelector(".more-btn").addEventListener("click", function () {
    renderExtraRecruitmentList();
});

document.addEventListener("DOMContentLoaded", function () {
    const images = document.querySelectorAll(".banner-image");
    let currentIndex = 0;

    function showNextImage() {
        images[currentIndex].classList.remove("active"); 
        currentIndex = (currentIndex + 1) % images.length; 
        images[currentIndex].classList.add("active"); 
    }

    setInterval(showNextImage, 5000); 
});

document.addEventListener("DOMContentLoaded", function () {
    const adImages = document.querySelectorAll(".ad-image");
    let adCurrentIndex = 0;

    function showNextAdImage() {
        adImages[adCurrentIndex].classList.remove("active");
        adCurrentIndex = (adCurrentIndex + 1) % adImages.length;
        adImages[adCurrentIndex].classList.add("active"); 
    }

    setInterval(showNextAdImage, 5000); 
});



document.addEventListener("click", function (event) {
    if (event.target.classList.contains("join-btn")) {
        if (event.target.classList.contains("closed-btn")) {
            alert("이미 마감된 공동구매입니다.");
            return;
        }

        // 버튼의 data-recruitment-no 값 가져오기
        const recruitmentNo = event.target.getAttribute("data-recruitment-no");
        const boardNo = event.target.getAttribute("data-board-no");

        if (recruitmentNo) {

        window.location.href = `/partyRecruitmentList/${recruitmentNo}/${boardNo}`;
        }
    }
});

// 닉네임 클릭 시 메뉴 띄우기 (위임)
document.addEventListener("click", function (e) {
    const target = e.target;

    // 닉네임 클릭했을 경우
    if (target.classList.contains("clickable-nickname")) {
        const menu = document.getElementById("nicknameMenu");
        const rect = target.getBoundingClientRect();

        // 메뉴 위치 조정
        menu.style.top = `${rect.bottom + window.scrollY + 5}px`;
        menu.style.left = `${rect.left}px`;
        menu.classList.remove("hidden");

        // 메뉴에 대상 정보 저장
        menu.dataset.targetNo = target.dataset.memberNo;
        menu.dataset.targetNick = target.dataset.memberNick;
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