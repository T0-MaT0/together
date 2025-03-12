document.addEventListener("DOMContentLoaded", function () {
    loadRecruitmentList("/api/recruitment/latest", ".product-grid");
    loadRecruitmentList("/api/recruitment/popular", ".new2-grid");
});

function loadRecruitmentList(apiUrl, containerSelector) {
    fetch(apiUrl)  
        .then(response => response.json()) 
        .then(data => {
            console.log("받아온 데이터:", data);
            renderRecruitmentList(data, containerSelector);
        })
        .catch(error => console.error("공동구매 목록 불러오기 실패:", error));
}

function formatDate(dateString) {
    if (!dateString) return "-";
    
    const date = new Date(dateString);
    const month = String(date.getMonth() + 1).padStart(2, '0'); // 월 (01~12)
    const day = String(date.getDate()).padStart(2, '0'); // 일 (01~31)
    const hours = String(date.getHours()).padStart(2, '0'); // 시간 (00~23)
    const minutes = String(date.getMinutes()).padStart(2, '0'); // 분 (00~59)
    
    return `${month}/${day} ${hours}:${minutes}`;
}

function renderRecruitmentList(recruitments, containerSelector) {
    const container = document.querySelector(containerSelector);
    container.innerHTML = ""; 

    recruitments.forEach(recruitment => {
        const progress = (recruitment.currentParticipants / recruitment.maxParticipants) * 100;
        const isClosed = recruitment.currentParticipants >= recruitment.maxParticipants;

        const hostName = recruitment.hostName;  
        const hostGrade = `🎇${recruitment.hostGrade}`;

        const recCreatedDate = formatDate(recruitment.recCreatedDate);
        const recEndDate = formatDate(recruitment.recEndDate);
        const joinDate = formatDate(recruitment.joinDate);
        const cancelDate = formatDate(recruitment.cancelDate);

        const productHTML = `
            <div class="product">
                <img src="/resources/images/individual/main/water2.png" alt="제품 이미지">
                <p class="seller-info">${hostName} (등급: ${hostGrade})</p>
                <p class="product-name">${recruitment.productName}</p>
                <p class="discount-price">${recruitment.productPrice}원</p>
                <p class="original-price">${recruitment.productCount}원 (원가)</p>
                <p class="participants">📅 생성일: ${recCreatedDate} ~</p> 
                <p class="participants">⏳ 마감일: ${recEndDate}</p>
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

        productGrid.innerHTML += productHTML;
    });
}