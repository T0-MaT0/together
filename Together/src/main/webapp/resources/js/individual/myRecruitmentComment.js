document.addEventListener("DOMContentLoaded", function () {
    const buttons = document.querySelectorAll("#nav-buttons button");

    // 현재 URL에서 key 값 가져오기
    const searchParams = new URLSearchParams(window.location.search);
    const key = searchParams.get("key");

    // 버튼 key 값과 index 매핑
    const keyMap = {
        "completed": 0,   // 모집 완료
        "myRecruitment": 1, // 내 모집현황
        "comments": 2,   // 댓글
        "reviews": 3    // 리뷰
    };

    // 기존 버튼 스타일 (기본 핑크색)
    const defaultColor = "#FF66B2"; // 핑크색
    const selectedColor = "#6700CF"; // 보라색

    // 현재 선택된 버튼 스타일 적용
    if (key && keyMap.hasOwnProperty(key)) {
        buttons[keyMap[key]].style.backgroundColor = selectedColor;
        buttons[keyMap[key]].style.color = "white";
    }

    // 버튼 클릭 시 이벤트 처리
    buttons.forEach((button) => {
        button.addEventListener("click", () => {
            // 모든 버튼을 기본 색상(핑크색)으로 초기화
            buttons.forEach(btn => {
                btn.style.backgroundColor = defaultColor;
                btn.style.color = "white";
            });

            // 클릭된 버튼 스타일 적용 (보라색)
            button.style.backgroundColor = selectedColor;
            button.style.color = "white";

            // URL 변경 (필터 적용)
            let newKey = button.getAttribute("data-key");
            if (newKey === "comments") {
                window.location.href = "/myRecruitment/comments";  
            } else if (newKey === "reviews") {
                window.location.href = "/myRecruitment/reviews";  // ✅ 리뷰 페이지로 이동 추가
            } else {
                window.location.href = "/myRecruitment?key=" + newKey;
            }
        });
    });
});