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
        const isClosed = recruitment.currentParticipants >= recruitment.maxParticipants;

        grid.innerHTML += `
            <div class="product">
                <img src="/resources/images/individual/main/water2.png" alt="제품 이미지">
                <p class="seller-info">${recruitment.hostName} (등급: ${recruitment.hostGrade})</p>
                <p class="product-name">${recruitment.productName}</p>
                <p class="discount-price">${recruitment.productPrice}원</p>
                <p class="original-price">${recruitment.productCount}원 (원가)</p>
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
                    <button class="join-btn ${isClosed ? 'closed' : ''}">
                        ${isClosed ? '마감' : '참가'}
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
        const isClosed = recruitment.currentParticipants >= recruitment.maxParticipants;

        grid.innerHTML += `
            <div class="product">
                <img src="/resources/images/individual/main/water2.png" alt="제품 이미지">
                <p class="seller-info">${recruitment.hostName} (등급: ${recruitment.hostGrade})</p>
                <p class="product-name">${recruitment.productName}</p>
                <p class="discount-price">${recruitment.productPrice}원</p>
                <p class="original-price">${recruitment.productCount}원 (원가)</p>
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
                    <button class="join-btn ${isClosed ? 'closed' : ''}">
                        ${isClosed ? '마감' : '참가'}
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