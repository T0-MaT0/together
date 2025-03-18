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

    // 체크박스 설정
    const topCheckbox = document.getElementById("topcheckbox");
    const checkboxes = document.querySelectorAll(".recruit-card .checkbox"); 
    
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


    // 마감 버튼 ajax
    const closeBtn = document.querySelector(".close-btn");

    closeBtn.addEventListener("click", function () {
        // 체크된 모집글 개수 확인
        const checkedBoxes = document.querySelectorAll(".recruit-card input[type='checkbox']:checked");

        if (checkedBoxes.length === 0) {
            alert("마감할 모집글을 선택해주세요.");
            return;
        }

        if (checkedBoxes.length > 1) {
            alert("하나만 선택해주세요.");
            return;
        }

        const checkedBox = checkedBoxes[0]; // 유일한 체크된 요소 가져오기
        const boardNo = parseInt(checkedBox.dataset.boardno, 10); // boardNo를 int 변환
        const loginMemberNo = parseInt(document.querySelector("#loginMemberNo").value, 10); // memberNo를 int 변환

        fetch("/updateRecruitmentStatus", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ boardNo, loginMemberNo }) // JSON으로 int 값 전달
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert("모집글이 마감되었습니다.");
                location.reload();
            } else {
                alert(data.message || "마감 실패: 권한이 없습니다.");
            }
        })
        .catch(error => console.error("Error:", error));
    });
});

document.addEventListener("DOMContentLoaded", function () {
    const searchParams = new URLSearchParams(window.location.search);
    const key = searchParams.get("key") || "myRecruitment"; // 기본값 설정

    const deleteBtnContainer = document.querySelector(".delete-btn-container");

    if (deleteBtnContainer) {
        if (key === "myRecruitment") {
            deleteBtnContainer.style.visibility = "visible"; // 버튼 보이기
        } else {
            deleteBtnContainer.style.visibility = "hidden"; // 버튼 숨기기 (자리 유지)
        }
    }
});