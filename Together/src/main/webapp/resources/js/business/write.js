console.log("write.js");

// 팝업 닫기
const closePopup = () => {
    window.close();
};

const stars = document.querySelectorAll(".fa-star");
const starCount = document.getElementById("starCount");
const starResult = document.getElementById("starResult");

// 별점 선택 관련 변수
let selectStar = -1;

// 별점 호버 및 선택 기능
stars.forEach((star, index) => {
    star.addEventListener("mouseover", () => starChange(index));
    star.addEventListener("mouseout", () => {
        if (selectStar === -1) {
            resetStars();
        } else {
            starChange(selectStar - 1);
        }
    });
    star.addEventListener("click", () => {
        selectStar = index + 1;
        starCount.value = selectStar;
        starResult.innerText = `${selectStar}점을 선택하셨습니다.`;

        resetStars();
        starChange(index);
    });
});

// 별점 변경 함수
const starChange = (index) => {
    stars.forEach((star, i) => {
        if (i <= index) {
            star.classList.remove("fa-regular");
            star.classList.add("fa-solid");
        } else {
            star.classList.remove("fa-solid");
            star.classList.add("fa-regular");
        }
    });
};

// 별점 리셋 함수
const resetStars = () => {
    stars.forEach(star => {
        star.classList.remove("fa-solid");
        star.classList.add("fa-regular");
    });
};

// 리뷰 글자 수 제한 (1000자)
const popupContentArea = document.getElementById("popupContentArea");
const popupContentCount = document.getElementById("popupContentCount");

popupContentArea.addEventListener("input", () => {
    let content = popupContentArea.value;
    popupContentCount.innerText = `${content.length}/1000`;

    if (content.length > 1000) {
        popupContentArea.value = content.substring(0, 1000);
        popupContentCount.innerText = "1000/1000";
    }
});

// 이미지 미리보기 및 삭제 기능
const reviewImgArea = document.querySelector(".review-img-area");

// 새로운 이미지 미리보기 추가
const addImagePreview = () => {
    const imageCount = document.querySelectorAll(".input-image").length; // 현재 개수로 ID 지정
    const newDiv = document.createElement("div");
    newDiv.draggable = true; // 드래그 가능하도록 설정
    newDiv.classList.add("image-container");

    // label 생성
    const newLabel = document.createElement("label");
    newLabel.setAttribute("for", `img${imageCount}`);

    // 이미지 태그 생성
    const newImg = document.createElement("img");
    newImg.classList.add("preview");
    newLabel.appendChild(newImg);

    // 파일 선택 input 생성
    const newInput = document.createElement("input");
    newInput.type = "file";
    newInput.name = "images";
    newInput.classList.add("input-image");
    newInput.id = `img${imageCount}`;
    newInput.accept = "image/*";

    // 삭제 버튼 생성
    const newSpan = document.createElement("span");
    newSpan.classList.add("delete-image");
    newSpan.innerHTML = "&times;";
    newSpan.style.display = "none"; // 기본적으로 숨김

    // 요소 추가
    newDiv.appendChild(newLabel);
    newDiv.appendChild(newInput);
    newDiv.appendChild(newSpan);
    reviewImgArea.appendChild(newDiv);

    // 이벤트 리스너 추가
    newInput.addEventListener("change", (event) => handleImageChange(event, newSpan));
    newSpan.addEventListener("click", () => deleteImage(newDiv));

    // 드래그 이벤트 추가
    addDragAndDropEvents(newDiv);
};

// 이미지 삭제 후 ID 재정렬
const deleteImage = (imageDiv) => {
    const imgTag = imageDiv.querySelector(".preview");
    const inputTag = imageDiv.querySelector(".input-image");
    const deleteButton = imageDiv.querySelector(".delete-image");

    if (document.querySelectorAll(".review-img-area div").length === 1) {
        imgTag.removeAttribute("src");
        inputTag.value = "";
        deleteButton.style.display = "none"; // 버튼 숨김
    } else {
        reviewImgArea.removeChild(imageDiv);
        reorderImageIds(); // 삭제 후 ID 순서 다시 정렬
    }
};

// 삭제 후 ID 재정렬 함수
const reorderImageIds = () => {
    const imageDivs = document.querySelectorAll(".review-img-area div");

    imageDivs.forEach((div, index) => {
        const input = div.querySelector(".input-image");
        const label = div.querySelector("label");

        input.id = `img${index}`;
        label.setAttribute("for", `img${index}`);
    });
};

// 이미지 변경 핸들러
const handleImageChange = (event, deleteButton) => {
    const input = event.target;
    const file = input.files[0];

    if (!file) return;

    const maxSize = 2 * 1024 * 1024; // 2MB 제한
    if (file.size > maxSize) {
        alert("2MB 이하의 이미지를 선택해주세요.");
        input.value = "";
        return;
    }

    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = (e) => {
        const previewImg = input.previousElementSibling.querySelector(".preview");
        previewImg.setAttribute("src", e.target.result);

        // 삭제 버튼 표시
        deleteButton.style.display = "inline";

        // 새로운 미리보기 추가
        addImagePreview();
    };
};

// 초기 삭제 버튼 이벤트 추가 (첫 번째 이미지도 삭제 가능)
document.querySelector(".delete-image")?.addEventListener("click", () => {
    const firstDiv = document.querySelector(".review-img-area div");
    deleteImage(firstDiv);
});

// 초기 이벤트 바인딩
document.querySelectorAll(".input-image").forEach(input => {
    const deleteButton = input.parentElement.querySelector(".delete-image");
    input.addEventListener("change", (event) => handleImageChange(event, deleteButton));
});

// 드래그 앤 드롭 기능 추가
const addDragAndDropEvents = (element) => {
    element.addEventListener("dragstart", (e) => {
        e.dataTransfer.setData("text/plain", e.target.dataset.index);
        element.classList.add("dragging");
    });

    element.addEventListener("dragover", (e) => {
        e.preventDefault();
        const draggingItem = document.querySelector(".dragging");
        const currentItem = e.target.closest(".image-container");

        if (currentItem && currentItem !== draggingItem) {
            const children = Array.from(reviewImgArea.children);
            const draggingIndex = children.indexOf(draggingItem);
            const currentIndex = children.indexOf(currentItem);

            if (draggingIndex > currentIndex) {
                reviewImgArea.insertBefore(draggingItem, currentItem);
            } else {
                reviewImgArea.insertBefore(draggingItem, currentItem.nextSibling);
            }
        }
    });

    element.addEventListener("dragend", () => {
        element.classList.remove("dragging");
        reorderImageIds();
    });
};

// 기존 이미지에도 드래그 기능 추가
document.querySelectorAll(".review-img-area div").forEach(addDragAndDropEvents);
