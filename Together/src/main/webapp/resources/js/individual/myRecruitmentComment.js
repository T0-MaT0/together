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
                window.location.href = "/myRecruitment/reviews";  
            } else {
                window.location.href = "/myRecruitment?key=" + newKey;
            }
        });
    });

    function setupCheckboxSelection(containerId) {
        const topCheckbox = document.querySelector(`#${containerId} .title-checkbox input[type="checkbox"]`);
        const checkboxes = document.querySelectorAll(`#${containerId} .checkbox`);

        if (!topCheckbox || checkboxes.length === 0) return;

        // 전체 선택 체크박스 클릭 이벤트
        topCheckbox.addEventListener("change", function () {
            checkboxes.forEach(checkbox => {
                checkbox.checked = topCheckbox.checked;
            });
        });

        // 개별 체크박스 클릭 시 전체 선택 체크박스 상태 업데이트
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener("change", function () {
                topCheckbox.checked = [...checkboxes].every(cb => cb.checked);
            });
        });
    }

    // 댓글 체크박스 기능 적용
    setupCheckboxSelection("comment-list");

    // 리뷰 체크박스 기능 적용
    setupCheckboxSelection("review-list");
    
    

    
});


// 삭제 버튼 ajax
const deleteBtn = document.querySelector(".delete-selected");

deleteBtn.addEventListener("click", function () {
    // 체크된 체크박스 가져오기
    const checkedBoxes = document.querySelectorAll(".checkbox:checked");

    if (checkedBoxes.length === 0) {
        alert("삭제할 댓글을 선택해주세요.");
        return;
    }

    // 체크된 댓글들의 replyNo 수집
    const replyNos = Array.from(checkedBoxes).map(checkbox => {

        // data-replyno 값이 undefined라면 checkbox.getAttribute 사용
        return parseInt(checkbox.dataset.replyno || checkbox.getAttribute("data-replyno"), 10);
    });
    fetch("/reply/deleteComments", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ replyNos })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert("선택한 댓글이 삭제되었습니다.");
            location.reload();
        } else {
            alert(data.message || "삭제 실패: 오류 발생");
        }
    })
    .catch(error => console.error("Error:", error));
});

