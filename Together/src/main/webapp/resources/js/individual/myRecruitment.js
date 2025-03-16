ocument.addEventListener("DOMContentLoaded", function () {
    const buttons = document.querySelectorAll("#nav-buttons button");

    // 현재 URL에서 key 값 가져오기
    const searchParams = new URLSearchParams(window.location.search);
    const key = searchParams.get("key");

    // 버튼별 key 값 매핑
    const keyMap = {
        "completed": 0, // 모집 완료
        "myRecruitment": 1 // 내 모집현황
    };

    // 선택된 버튼 스타일 적용
    if (key && keyMap.hasOwnProperty(key)) {
        buttons[keyMap[key]].style.backgroundColor = "#6700CF";
        buttons[keyMap[key]].style.color = "white";
    }

    // 버튼 클릭 시 이벤트 처리
    buttons.forEach((button, index) => {
        button.addEventListener("click", () => {
            // 모든 버튼 스타일 초기화
            buttons.forEach(btn => {
                btn.style.backgroundColor = "";
                btn.style.color = "";
            });

            // 클릭된 버튼 스타일 적용
            button.style.backgroundColor = "#6700CF";
            button.style.color = "white";

            // URL 변경 (필터 적용)
            let newKey = index === 0 ? "completed" : "myRecruitment";
            window.location.href = "/myRecruitment?key=" + newKey;
        });
    });
});