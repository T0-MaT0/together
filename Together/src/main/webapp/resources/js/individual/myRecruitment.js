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


    // 마감 버튼 ajax
    const closeBtn = document.querySelector(".close-btn");

    closeBtn.addEventListener("click", function () {
        const checkedBoxes = document.querySelectorAll(".recruit-card input[type='checkbox']:checked");

        if (checkedBoxes.length === 0) {
            alert("마감할 모집글을 선택해주세요.");
            return;
        }

        if (checkedBoxes.length > 1) {
            alert("하나만 선택해주세요.");
            return;
        }

        const checkedBox = checkedBoxes[0]; 
        const boardNo = parseInt(checkedBox.dataset.boardno, 10); 
        const loginMemberNo = parseInt(document.querySelector("#loginMemberNo").value, 10); // memberNo를 int 변환

        fetch("/updateRecruitmentStatus", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ boardNo, loginMemberNo }) 
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
    const key = searchParams.get("key") || "myRecruitment"; 

    // 체크박스 컨트롤
    const checkboxes = document.querySelectorAll(".recruit-card input[type='checkbox']");

    checkboxes.forEach(checkbox => {
        if (key === "myRecruitment") {
            checkbox.style.visibility = "visible"; 
        } else {
            checkbox.style.visibility = "hidden"; 
        }
    });

    // 삭제 버튼 컨트롤 (기존 코드 유지)
    const deleteBtnContainer = document.querySelector(".delete-btn-container");
    if (deleteBtnContainer) {
        if (key === "myRecruitment") {
            deleteBtnContainer.style.visibility = "visible"; 
        } else {
            deleteBtnContainer.style.visibility = "hidden"; 
        }
    }
});

const deleteBtn = document.querySelector(".delete-btn");

deleteBtn.addEventListener("click", function () {
    const checkedBoxes = document.querySelectorAll(".recruit-card input[type='checkbox']:checked");

    if (checkedBoxes.length === 0) {
        alert("마감할 모집글을 선택해주세요.");
        return;
    }

    if (checkedBoxes.length > 1) {
        alert("하나만 선택해주세요.");
        return;
    }

    const boardNo = parseInt(checkedBox.dataset.boardno, 10); 
    const loginMemberNo = parseInt(document.querySelector("#loginMemberNo").value, 10); // memberNo를 int 변환

    console.log("삭제 요청: ", { boardNo, loginMemberNo });

    fetch("/deleteRecruitment", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ boardNo, loginMemberNo })
    })
    .then(response => response.json())
    .then(data => {
        console.log("서버 응답: ", data);
        if (data.success) {
            alert("모집글이 삭제되었습니다.");
            location.reload();
        } else {
            alert(data.message || "삭제 실패: 권한이 없습니다.");
        }
    })
    .catch(error => console.error("Error:", error));
});