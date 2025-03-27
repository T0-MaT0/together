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
const starChange = index => {
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

const deleteList = document.getElementById("deleteList");
const deleteSet = new Set();

// 삭제 후 ID 재정렬 함수
const reorderImageIds = () => {
    const imageDivs = document.querySelectorAll(".review-img-area .image-container");

    imageDivs.forEach((div, index) => {
        const input = div.querySelector(".input-image");
        const label = div.querySelector("label");
        const imageLevel = document.getElementsByName("imageLevel")[index];

        div.dataset.index = index;
        input.id = `img${index}`;
        label.setAttribute("for", `img${index}`);
        console.log(imageLevel)
        console.log(index)
        imageLevel.value = index;
    });
};

// 이미지 변경 핸들러
const handleImageChange = (input, deleteButton) => {
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
    reader.onload = e => {
        const previewImg = input.previousElementSibling.querySelector(".preview");
        const remainder = input.parentElement.querySelector(".remainder");
        console.log(input)
        console.log(previewImg)
        previewImg.setAttribute("src", e.target.result);

        // 삭제 버튼 표시
        deleteButton.style.display = "inline";
    };
};

// 드래그 앤 드롭 기능 추가
const reviewImgArea = document.querySelector(".review-img-area");
const addDragAndDropEvents = element => {
    element.addEventListener("dragstart", e => {
        e.dataTransfer.setData("text/plain", [...reviewImgArea.children].indexOf(element));
        element.classList.add("dragging");
    });

    element.addEventListener("dragover", e => {
        e.preventDefault();
        const draggingItem = document.querySelector(".dragging");
        if (!draggingItem) return;

        const currentItem = e.target.closest(".image-container");
        if (!currentItem || currentItem === draggingItem) return;

        const children = [...reviewImgArea.children];
        const draggingIndex = children.indexOf(draggingItem);
        const currentIndex = children.indexOf(currentItem);

        if (draggingIndex > currentIndex) {
            reviewImgArea.insertBefore(draggingItem, currentItem);
        } else {
            reviewImgArea.insertBefore(draggingItem, currentItem.nextSibling);
        }
    });

    element.addEventListener("dragend", () => {
        element.classList.remove("dragging");
        reorderImageIds();
    });
};

// 기존 이미지에도 드래그 기능 추가
document.querySelectorAll(".review-img-area .image-container").forEach(container=>{
    if(container.getAttribute("draggable")==="true"){
        addDragAndDropEvents(container);
    }
});

// 기존 이미지에도 이미지 변경 기능 추가
document.querySelectorAll(".review-img-area .image-container .input-image").forEach(event=>{
    event.addEventListener("change", e=>{
        const input = e.target;
        if(input&&input.files){
            const deleteButton = input.closest(".image-container").querySelector(".delete-image");
            handleImageChange(input, deleteButton);
        }
    });
});

// 기존 이미지 삭제 버튼에 이미지 삭제 기능 추가
for(let i=0;i<5;i++){
    document.getElementsByClassName("delete-image")[i].addEventListener("click", e=>{
        const inputImage = document.getElementsByClassName("input-image")[i];
        const preview = document.getElementsByClassName("preview")[i];
        
        e.target.style.display = "none";
        inputImage.value = "";
        preview.removeAttribute("src");

        deleteSet.add(i);
    });
}

// 서버로 요청 시
document.getElementById("reviewWriteForm")?.addEventListener("submit", e => {
    if (starCount.value === "") {
        e.preventDefault();
        alert("별점을 남겨야 리뷰를 등록할 수 있습니다.");
        return;
    }
    
    if (popupContentArea.value === "") {
        e.preventDefault();
        alert("리뷰 내용을 작성해야 리뷰를 등록할 수 있습니다.");
        popupContentArea.focus();
        return;
    }

    deleteList.value = Array.from(deleteSet);
});
