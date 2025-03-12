document.addEventListener("DOMContentLoaded", function () {
    loadRecruitmentList();           // 최신 등록순 불러오기
    loadPopularRecruitmentList();    // 조회수 높은 순으로 상품 로딩
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
function loadPopularRecruitmentList() {
    fetch("/api/recruitment/popular")
        .then(response => response.json())
        .then(data => {
            renderPopularRecruitmentList(data);
        })
        .catch(error => console.error("인기 공동구매 목록 불러오기 실패:", error));
}

// 최신 상품 순 목록 렌더링
function renderRecruitmentList(recruitments) {
    const grid = document.querySelector(".product-grid");
    gridHTML = "";
    recruitments.forEach(recruitment => {
        const progress = (recruitment.currentParticipants / recruitment.maxParticipants) * 100;
        const isClosed = recruitment.currentParticipants >= recruitment.maxParticipants;

        const productHTML = `
            <div class="product">
                <img src="/resources/images/individual/main/water2.png" alt="제품 이미지">
                <p class="seller-info">${recruitment.sellerName} (등급: ${recruitment.sellerGrade})</p>
                <p class="product-name">${recruitment.productName}</p>
                <p class="discount-price">${recruitment.productPrice}원</p>
                <p class="original-price">${recruitment.productCount}원 (원가)</p>
                <p class="participants">📅 생성일: ${formatDate(recruitment.recCreatedDate)} ~</p> 
                <p class="participants">⏳ 마감일: ${formatDate(recruitment.recEndDate)}</p>
                <p class="participants">참가 모집 : ${recruitment.currentParticipants || 0} / ${recruitment.maxParticipants}명</p>
                <div class="progress-button-container">
                    <div class="progress-container">
                        <span class="progress-label">${((recruitment.currentParticipants / recruitment.maxParticipants) * 100).toFixed(0)}%</span>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: ${(recruitment.currentParticipants / recruitment.maxParticipants) * 100}%;"></div>
                        </div>
                    </div>
                    <button class="join-btn ${isClosed ? 'closed' : ''}">
                        ${isClosed ? '마감' : '참가'}
                    </button>
                </div>
            </div>
        `;

        document.querySelector(".product-grid").innerHTML += productHTML;
    });
}

// 인기 상품 렌더링 (광고 포함 패턴으로)
function renderPopularRecruitmentList(recruitments) {
    const container = document.getElementById("popular-products");
    container.innerHTML = "";

    let i = 0;
    let groupCount = 0;

    while (i < recruitments.length) {
        if (groupCount % 2 === 0) {
            // 광고 + 상품 2개 그룹
            container.innerHTML += `
                <div class="new2-grid ad-group">
                    <div class="new-banner">
                        <img src="/resources/images/individual/main/main2 광고.gif" alt="광고배너">
                    </div>
                    ${recruitments.slice(i, i + 2).map(r => recruitmentHTML(r)).join('')}
                </div>
            `;
            i += 2;
        } else {
            // 상품 4개 그룹
            container.innerHTML += `
                <div class="product-group">
                    ${recruitments.slice(i, i + 4).map(r => recruitmentHTML(r)).join('')}
                </div>
            `;
            i += 4;
        }
        groupCount++;
    }
}

// 상품 HTML 생성 함수
function recruitmentHTML(recruitment) {
    const progress = (recruitment.currentParticipants / recruitment.maxParticipants) * 100;
    const isClosed = recruitment.currentParticipants >= recruitment.maxParticipants;

    return `
        <div class="product">
            <img src="/resources/images/individual/main/water2.png" alt="제품 이미지">
            <p class="seller-info">${recruitment.sellerName} (등급: ${recruitment.sellerGrade})</p>
            <p class="product-name">${recruitment.productName}</p>
            <p class="discount-price">${recruitment.productPrice}원</p>
            <p class="original-price">${recruitment.productCount}원 (원가)</p>
            <p class="participants">📅 생성일: ${formatDate(recruitment.recCreatedDate)} ~</p> 
            <p class="participants">⏳ 마감일: ${formatDate(recruitment.recEndDate)}</p>
            <p class="participants">참가 모집 : ${recruitment.currentParticipants || 0} / ${recruitment.maxParticipants}명</p>
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
}

// 날짜 형식 변환 함수 추가
function formatDate(dateString) {
    if (!dateString) return "-";

    const date = new Date(dateString);
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');

    return `${month}/${day} ${hours}:${minutes}`;
}