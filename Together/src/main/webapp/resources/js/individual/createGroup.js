document.addEventListener("DOMContentLoaded", function () {
    const createBtn = document.querySelector(".btn-create");

    if (createBtn) {
        createBtn.addEventListener("click", function () {
            // 팝업창 크기
            const width = 800;
            const height = 650;
            
            // 화면 중앙 정렬
            const left = (window.screen.width / 2) - (width / 2);
            const top = (window.screen.height / 2) - (height / 2);

            // 팝업창 옵션
            const windowFeatures = `width=${width},height=${height},left=${left},top=${top},resizable=no,scrollbars=yes`;
            
            // 팝업 열기
            window.open("/kakaoAPI", "kakaoAPIPopup", windowFeatures);
        });
    }
});

function setJibunAddress(addr) {
    document.getElementById("chosenAddress").textContent = addr;
    document.getElementById("regionInput").value = addr;
}

// 날짜를 "YY. MM. DD"로 포맷
function formatYYMMDD(date) {
    const yy = (date.getFullYear() % 100).toString().padStart(2, '0');
    const mm = (date.getMonth() + 1).toString().padStart(2, '0');
    const dd = date.getDate().toString().padStart(2, '0');
    return `${yy}. ${mm}. ${dd}`;
}

document.addEventListener("DOMContentLoaded", function() {
    const displaySingle = document.getElementById("displaySingle");
    const hiddenEndDate = document.getElementById("hiddenRangeInput");
    const calendarIcon  = document.getElementById("calendarIcon");

    // 1) Flatpickr: 단일 날짜 선택
    const myCal = flatpickr("#hiddenRangeInput", {
        mode: "single",       // 한 날짜만 고름
        locale: "ko",
        minDate: "today",     // 오늘 이전 불가
        static: true,         // 인풋 아래 고정 or 그대로 노출 등 (원하는 대로)
        dateFormat: "Y-m-d",  // 폼 전송 시 "YYYY-MM-DD" 저장

        onChange: function(selectedDates, dateStr) {
            // selectedDates[0]이 마감 기한
            if (selectedDates.length === 1) {
                const endDate = selectedDates[0];
                // 표시용
                displaySingle.textContent = formatYYMMDD(endDate);
                // 실제 폼 전송할 값 (YYYY-MM-DD)
                hiddenEndDate.value = dateStr;
            }
        }
    });

    // 2) 달력 아이콘 클릭 -> 달력 열기
    calendarIcon.addEventListener("click", function() {
        myCal.open();
    });
});

// 카테고리 설정
document.addEventListener("DOMContentLoaded", function() {
    const parentSelect = document.getElementById("parentCategory");
    const childSelect = document.getElementById("childCategory");

    // 부모 카테고리 변경 시 
    parentSelect.addEventListener("change", function() {
        const parentNo = this.value;
        
        // 만약 부모 선택이 없으면 자식 초기화
        if (!parentNo) {
            childSelect.innerHTML = '<option value="">-- 선택 --</option>';
            childSelect.disabled = true;
            return;
        }

        // 자식 카테고리 조회 
        fetch(`/category/children?parentNo=${parentNo}`)
            .then(response => response.json())
            .then(data => {
                if (data.length > 0) {
                    let options = '<option value="">-- 선택 --</option>';
                    data.forEach(child => {
                        options += `<option value="${child.categoryNo}">
                                       ${child.categoryName}
                                    </option>`;
                    });
                    childSelect.innerHTML = options;
                    childSelect.disabled = false;
                } else {
                    // 자식이 없으면 
                    childSelect.innerHTML = '<option value="">(하위 없음)</option>';
                    childSelect.disabled = true;
                }
            })
            .catch(error => {
                console.error("자식 카테고리 조회 실패:", error);
            });
    });
});

document.addEventListener("DOMContentLoaded", function() {
    const titleInput   = document.getElementById("boardTitle");
    const parentSelect = document.getElementById("parentCategory");
    const childSelect  = document.getElementById("childCategory");
    const description  = document.getElementById("description");
    const productUrlField  = document.getElementById("productUrl");       // 상품 URL
    const hiddenRangeInput = document.getElementById("hiddenRangeInput"); // 마감 기한 (내부 값)
    const chosenAddress = document.getElementById("chosenAddress"); // 지역역
    const maxPartField     = document.getElementById("maxParticipants");  // 총 인원
    const myQuantityField  = document.getElementById("myQuantity");       // 내 선택 수량
    const submitBtn    = document.querySelector(".btn-submit");
    
    submitBtn.addEventListener("click", function(e) {
        // 쉽표 제거
        const priceField = document.getElementById("productPrice"); 
        if(priceField){ 
            priceField.value = priceField.value.replace(/,/g, "");
        }

        // 1) 제목 체크
        if (!titleInput.value.trim()) {
            alert("제목을 입력해주세요.");
            titleInput.focus();  
            e.preventDefault();
            return;
        }

        // 2) 부모 카테고리 체크
        if (!parentSelect.value) {
            alert("부모 카테고리를 선택해주세요.");
            parentSelect.focus();
            e.preventDefault();
            return;
        }

        // 3) 자식 카테고리 체크
        if (!childSelect.value) {
            alert("하위 카테고리를 선택해주세요.");
            childSelect.focus();
            e.preventDefault();
            return;
        }

        // 4) 상품 설명 체크
        if (!description.value.trim()) {
            alert("상품 설명을 입력해주세요.");
            description.focus();
            e.preventDefault();
            return;
        }

        // 5) 상품 URL 체크
        if (!productUrlField.value.trim()) {
            alert("상품 사이트 URL을 입력해주세요.");
            productUrlField.focus();
            e.preventDefault();
            return;
        }

        // 6) 마감 기한 체크
        if (!hiddenRangeInput.value.trim()) {
            alert("마감 기한을 선택해주세요.");
            hiddenRangeInput.focus(); 
            e.preventDefault();
            return;
        }
        // 7) 지역 체크
        if (!chosenAddress.value.trim()) {
            alert("지역을 선택해주세요.");
            chosenAddress.focus(); 
            e.preventDefault();
            return;
        }

        // 8) 총 인원 체크
        if (!maxPartField.value.trim()) {
            alert("총 인원을 입력해주세요.");
            maxPartField.focus();
            e.preventDefault();
            return;
        }
        if (!isOnlyNumber(maxPartField.value.trim())) {
            alert("총 인원은 숫자만 입력해주세요.");
            maxPartField.focus();
            e.preventDefault();
            return;
        }

        // 9) 내 선택 수량 체크
        if (!myQuantityField.value.trim()) {
            alert("내 선택 수량을 입력해주세요.");
            myQuantityField.focus();
            e.preventDefault();
            return;
        }
        if (!isOnlyNumber(myQuantityField.value.trim())) {
            alert("내 선택 수량은 숫자만 입력해주세요.");
            myQuantityField.focus();
            e.preventDefault();
            return;
        }

        // 10) 총 금액 체크
        if (!priceField.value.trim()) {
            alert("총 금액을 입력해주세요.");
            priceField.focus();
            e.preventDefault();
            return;
        }
        if (!isValidCurrencyFormat(priceField.value.trim())) {
            alert("총 금액은 숫자만 입력하거나 천 단위로 쉼표(,)를 넣어주세요.\n예: 10000 또는 10,000");
            priceField.focus();
            e.preventDefault();
            return;
        }


        function isOnlyNumber(value) {
            return /^[0-9]+$/.test(value);
        }

        function isValidCurrencyFormat(value) {
            return /^(\d{1,3})(,\d{3})*$/.test(value) || /^[0-9]+$/.test(value); // 1000 또는 1,000 형식
        }
    });
});

// 이미지 미리보기
const preview = document.getElementsByClassName("preview");
const inputImage = document.getElementsByClassName("inputImage");
const deleteImage = document.getElementsByClassName("delete-image");

for(let i =0; i<preview.length; i++){

    // 파일 선택(변경) 시
    inputImage[i].addEventListener('change', e=>{
        const file = e.target.files[0]; // 선택된 파일
        if(file != undefined){ 
            const reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = e=>{
                preview[i].setAttribute('src', e.target.result);
            }
        } else { 
            preview[i].removeAttribute('src');
        }
    });

    // 미리보기 삭제(x버튼)
    deleteImage[i].addEventListener('click', e=>{
        if(preview[i].getAttribute('src')){
            preview[i].removeAttribute('src');
            inputImage[i].value = '';
        }
    });
}


const titleInput = document.getElementById('boardTitle');

  titleInput.addEventListener('input', function () {
    if (this.value.length > 29) {
      alert("제목은 30자까지 입력할 수 있습니다.");
      this.value = this.value.substring(0, 30); // 초과된 글자 잘라냄
    }
  });