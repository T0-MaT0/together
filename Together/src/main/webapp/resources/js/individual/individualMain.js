document.addEventListener("DOMContentLoaded", function () {
    loadRecruitmentList();           // 최신 등록순 불러오기
    loadExtraRecruitmentList();     // 조회수 높은 순으로 상품 로딩
});

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

// 최신 상품
function loadRecruitmentList() {
    fetch("/api/recruitment")
        .then(response => response.json())
        .then(data => renderRecruitmentList(data))
        .catch(err => console.error(err));
}

// 조회수 높은 순
let extraRecruitments = []; 
let currentIndex = 0; 
const ITEMS_PER_LOAD = 8; 

// 추가 공동 구매 리스트 불러오기 (한 번만 실행)
function loadExtraRecruitmentList() {
    fetch("/api/recruitment/popular")
        .then(response => response.json())
        .then(data => {
            extraRecruitments = data; 
            currentIndex = 0; 
            renderExtraRecruitmentList(); 
        })
        .catch(err => console.error("추가 공동구매 목록 불러오기 실패:", err));
}

// 추가 공동 구매 목록 렌더링
function renderExtraRecruitmentList() {
    const grid = document.querySelector(".extra-products .product-grid");

    // 추가로 보여줄 데이터 범위 설정
    const endIndex = Math.min(currentIndex + ITEMS_PER_LOAD, extraRecruitments.length);

    for (let i = currentIndex; i < endIndex; i++) {
        const recruitment = extraRecruitments[i];
        const progress = (recruitment.currentParticipants / recruitment.maxParticipants) * 100;
        const isClosed = recruitment.currentParticipants >= recruitment.maxParticipants;

        const productHTML = `
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
        grid.innerHTML += productHTML;
    }

    currentIndex = endIndex;

}

// More 버튼 클릭 시 추가 로드
document.querySelector(".more-btn").addEventListener("click", renderExtraRecruitmentList);

// 최신 상품 목록 렌더링
function renderRecruitmentList(recruitments) {
    const grid = document.querySelector(".product-grid");
    grid.innerHTML = "";

    recruitments.forEach(recruitment => {
        const progress = (recruitment.currentParticipants / recruitment.maxParticipants) * 100;
        const isClosed = recruitment.currentParticipants >= recruitment.maxParticipants;

        const productHTML = `
            <div class="product">
                <img src="/resources/images/individual/main/water2.png" alt="제품 이미지">
                <p class="seller-info">${recruitment.hostName} (등급: ${recruitment.hostGrade})</p>
                <p class="product-name">${recruitment.productName}</p>
                <p class="discount-price">${recruitment.productCount}원</p>
                <p class="original-price">${recruitment.productPrice}원 (원가)</p>
                <p class="participants">📅 생성일: ${formatDate(recruitment.recCreatedDate)} ~</p> 
                <p class="participants">⏳ 마감일: ${formatDate(recruitment.recEndDate)}</p>
                <p class="participants">참가 모집 : ${recruitment.currentParticipants} / ${recruitment.maxParticipants}명</p>
                <div class="progress-button-container">
                    <div class="progress-container">
                        <span class="progress-label">${progress.toFixed(0)}%</span>
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

        grid.innerHTML += productHTML;
    });
}