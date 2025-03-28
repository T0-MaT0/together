document.addEventListener("DOMContentLoaded", function () {
    const productGrid = document.getElementById("product-grid");
    let startIndex = 6; 
    const itemsPerPage = 6;
    let allProducts = [...document.querySelectorAll(".product-grid .product")];

    // 초기 9개만 표시하고 나머지는 숨김 처리
    allProducts.forEach((product, index) => {
        if (index >= startIndex) {
            product.style.display = "none";
        }
    });

    function loadMoreProducts() {
        const nextProducts = allProducts.slice(startIndex, startIndex + itemsPerPage);
        nextProducts.forEach(product => product.style.display = "block");
        startIndex += itemsPerPage;
    }

    // 스크롤 시 자동 로드
    window.addEventListener("scroll", function () {
        if (window.innerHeight + window.scrollY >= document.body.offsetHeight - 200) {
            loadMoreProducts();
        }
    });
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
            menu.classList.add("hidden");
        } else {
            alert("채팅방이 이미 존재합니다.");
        }
    })
    .catch(err => {
        console.error("1대1 채팅 오류", err);
    });
}); 