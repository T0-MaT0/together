console.log("order.js");

// 내 주소
const postalCode = document.querySelector('[placeholder="우편번호"]');
const address = document.querySelector('[placeholder="도로명/지번 주소"]');

// 주소 입력에 내 주소 삽입 함수
const insertMyAddr=()=>{
    postalCode.value = memberAddr[0];
    address.value = memberAddr[1];
    document.querySelector('[placeholder="상세 주소"]').value = memberAddr[2];
};

document.getElementById("myAddr")?.addEventListener("click", insertMyAddr);

// 결제 페이지로
const resultPrice = document.getElementById("resultPrice");
const goToBuy=()=>{
    if(resultPrice.classList[0]==='minus'){
        alert("포인트가 부족해 결제를 진행 할 수 없습니다.");
        return;
    }

    if(postalCode.value.trim().length==0) {
        handleAddress("우편 번호를 작성해 주세요.", postalCode);
        return;
    }

    if(address.value.trim().length==0) {
        handleAddress("도로명/지번 주소를 작성해 주세요.", address);
        return;
    }

    document.getElementById("orderForm").submit();
};

const handleAddress=(alertMessage, event)=>{
    if(confirm("작성된 주소가 없습니다. 내 주소로 불러오시겠습니까?")){
        insertMyAddr();
    } else {
        alert(alertMessage);
        event.focus();
    }
}