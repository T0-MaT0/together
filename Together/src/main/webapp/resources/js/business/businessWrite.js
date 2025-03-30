console.log("businessWrite.js");

const preview = document.getElementsByClassName("preview");
const inputImage = document.getElementsByClassName("inputImage");
const deleteImage = document.getElementsByClassName("x-btn");

for(let i=0;i<inputImage.length;i++){
    // 사진 미리 보기 
    inputImage[i].addEventListener("change", e=>insertPreview(e.target, i));
    // 미리보기 삭제(x버튼)
    deleteImage[i].addEventListener("click", ()=>{
        if(preview[i].getAttribute("src")!=""){
            preview[i].removeAttribute("src");
            inputImage[i].value="";
        }
    });
}

// 사진 미리보기 함수
const insertPreview=(e, i)=>{
    const file=e.files[0];
    const maxSize=1*1024*1024*2;
    if(file.size>maxSize){
        alert("2MB 이하의 이미지를 선택하주세요.");
        inputImage[i].value = "";
        return;
    }
    if(file != undefined){
        const reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = e=>{
            preview[i].setAttribute("src", e.target.result);
        }
    } else {
        preview[i].removeAttribute("src");
    }
}

const parentCategory = document.getElementById("parentCategory");
const childCategoryArea = document.getElementById("childCategoryArea");
const childCategory = document.getElementById("childCategory");

// 부모 카테고리
parentCategory.addEventListener("change", ()=>{
    if(parentCategory.value=="default"){
        childCategoryArea.classList.add("hide");
        return;
    }

    childCategoryArea.classList.remove("hide");
    childCategory.innerHTML = "";
    categoryList.forEach(category=>{
        if(category.parentCategoryNo==parentCategory.value){
            const option = document.createElement("option");
            option.value = category.categoryNo;
            option.innerText = category.categoryName;
            childCategory.append(option);
        }
    });  
});

const plusBtn = document.getElementById("plusBtn");
const optionInputArea = document.getElementsByClassName("option-input-area")[0];

// 플러스 버튼 클릭 시
plusBtn.addEventListener("click", ()=>{
    const optionArea = document.createElement("div");
    const optionInput = document.createElement("input");
    const minusBtn = document.createElement("span");

    optionInput.name = "optionName";
    optionInput.classList.add("optionName");
    optionInput.placeholder = "옵션을 입력해 주세요.";
    minusBtn.innerText = "-";
    minusBtn.addEventListener("click", ()=>deleteOptionArea(optionArea));
    optionArea.append(optionInput, minusBtn);
    optionInputArea.append(optionArea);
});

document.querySelectorAll(".minusBtn").forEach(minusBtn=>{
    minusBtn.addEventListener("click", ()=>deleteOptionArea(minusBtn.parentElement));
});

// 옵션 영역 삭제 함수
const deleteOptionArea=optionArea=>{
    optionArea.remove();
}

// 상품 사진 영역 추가
const addImageArea = document.getElementById("addImageArea");
const productImageArea = document.getElementById("productImageArea");
addImageArea.addEventListener("click", ()=>{
    const productImg = document.createElement("div");
    const label = document.createElement("label");
    const preview = document.createElement("img");
    const inputImage = document.createElement("input");
    const deleteButton = document.createElement("span");

    productImg.classList.add("product-img");
    preview.classList.add("preview");
    preview.src="";

    inputImage.type="file";
    inputImage.name="images";
    inputImage.classList.add("inputImage");
    inputImage.accept="image/*";
    label.append(preview, inputImage);

    const index = document.getElementsByClassName("inputImage").length;
    inputImage.addEventListener("change", ()=>insertPreview(inputImage, index))

    deleteButton.classList.add("x-btn");
    deleteButton.innerHTML="&times;";
    deleteButton.addEventListener("click", ()=>deleteImageArea(productImg));

    productImg.append(label, deleteButton);
    productImageArea.append(productImg);
});

// 이미지 영역 삭제 함수
const deleteImageArea=productImg=>{
    productImg.remove();
};

// 서버로 요청
const thumbnail = document.getElementById("thumbnail");
const productTitle = document.getElementsByClassName("product-title")[0];
const productPrice = document.getElementById("productPrice");
const deliveryFee = document.getElementById("deliveryFee");
const optionNames = document.querySelectorAll(".optionName");
const productCount = document.getElementById("productCount");
const boardContent = document.getElementById("boardContent");
const modal = document.getElementById("modal");
const businessWriteForm = document.getElementById("businessWriteForm");
businessWriteForm.addEventListener("submit", e=>{
    if(e.target.action.split("/").pop()!="update"){
        if(thumbnail.value==""){
            alert("상품의 썸네일을 넣어야 상품 등록이 가능합니다.");
            e.preventDefault();
            return;
        }

        if(permissionFl=="N"){
            modal.classList.add("modalActive");
            e.preventDefault();
        }
    }
    
    if(productTitle.value.trim()===""){
        alert("상품 이름을 작성해주셔야 상품 등록이 가능합니다.");
        productTitle.focus();
        e.preventDefault();
        return;
    }
    
    if(parentCategory.value=="default"){
        alert("상품 카테고리를 선택해주셔야 상품 등록이 가능합니다.");
        parentCategory.focus();
        e.preventDefault();
        return;
    }
    
    if(productPrice.value.trim()===""){
        alert("상품 가격을 작성해주셔야 상품 등록이 가능합니다.");
        productPrice.focus();
        e.preventDefault();
        return;
    }
    
    if(deliveryFee.value.trim()===""){
        alert("상품 배송비를 작성해주셔야 상품 등록이 가능합니다.");
        deliveryFee.focus();
        e.preventDefault();
        return;
    }
    
    let flag = true;
    optionNames.forEach(optionName=>{
        if(optionName.value.trim().length>0){
            flag=false;
        }
    })

    if(flag){
        alert("상품 옵션을 1개 이상 작성해주셔야 상품 등록이 가능합니다.");
        optionNames[0].focus();
        e.preventDefault();
        return;
    }

    if(productCount.value.trim()===""){
        alert("상품 재고를 작성해주셔야 상품 등록이 가능합니다.");
        productCount.focus();
        e.preventDefault();
        return;
    }

    if(boardContent.value.trim()===""){
        alert("상품 내용을 작성해주셔야 상품 등록이 가능합니다.");
        boardContent.focus();
        e.preventDefault();
        return;
    }
});

// 모달 닫기
const closeModalBtn = document.getElementsByClassName("close")[0];
closeModalBtn.addEventListener("click", e=>closeModal(e));
modal.addEventListener("click", e=>closeModal(e));

// 모달 닫기 함수
const closeModal = e=>{
    if(e.target!==modal&&e.target!==closeModalBtn) return;
    
    modal.classList.remove("modalActive");
};

const modalTitle = document.getElementById("modalTitle");
const modalContent = document.getElementById("modalContent");

modalTitle.addEventListener("input", e=>{
    document.getElementById("coalitionTitle").value=e.target.value;
});

modalContent.addEventListener("input", e=>{
    document.getElementById("coalitionContent").value=e.target.value;
});

const submitForm=()=>{
    if(modalTitle.value.trim().length==0){
        alert("제휴문의 제목을 작성해주세요.");
        modalTitle.focus();
        return;
    }
    if(modalContent.value.trim().length==0){
        alert("제휴문의 내용을 작성해주세요.");
        modalContent.focus();
        return;
    }
    businessWriteForm.submit();
};