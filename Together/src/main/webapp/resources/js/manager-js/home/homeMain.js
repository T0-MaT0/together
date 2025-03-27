console.log("managerHome!");

const mainPageBtn = document.querySelector("#mainPageBtn");
const privatePageBtn = document.querySelector("#privatePageBtn");
const brandPageBtn = document.querySelector('#brandPageBtn');

/* 메인 페이지 관리 버튼 */
mainPageBtn?.addEventListener("click", ()=>{
    
    location.href = "/manageHome/mainPage";
})

/* 개인 페이지 관리 버튼 */
privatePageBtn?.addEventListener("click", ()=>{

    location.href = "/manageHome/privatePage";
})

/* 브랜드 페이지 관리 버튼 */
brandPageBtn?.addEventListener("click", ()=>{

    location.href = "/manageHome/brandPage";
})

/* ----------------------------------------------------------------------------------------- */
/* 홈페이지 이미지 편집 */
const bannerItems = document.getElementsByClassName("bannerItem");
const bannerInput = document.getElementsByTagName("input");
const InsertNo = new Set();
const updateNo = new Set();
const deleteNo = new Set();


/* 초기 상태 저장 배열 */
const initialStates = [];

// 초기 상태 저장
for (let i = 0; i < bannerItems.length; i++) {
    initialStates[i] = Number(bannerItems[i].getAttribute("state")) || 0; // state 값 저장 (없으면 0)
}



for (let i = 0; i < bannerItems.length; i++) {
    bannerItems[i].addEventListener("click", () => {
        bannerInput[i].click();
    });

    bannerInput[i].addEventListener("change", function () {
        
        console.log(bannerInput[i].getAttribute("no"));
        const file = this.files[0]; 
        
        if (file) {
            console.log("파일 선택됨");
            if(initialStates[i] === 0){

                InsertNo.add(i);
                // console.log(i);
            }else{
              
                if(bannerItems[i].getAttribute("state") === "-1"){
                    deleteNo.delete(i);
                }
              
                updateNo.add(i);
                // console.log(i);

                const refreshButton = document.getElementsByClassName("refreshButton")[i];
                refreshButton.style.display = "block";

            }
            
            bannerItems[i].setAttribute("state", "2");
            const reader = new FileReader();

            reader.readAsDataURL(file);

            reader.onload = function (e) {
                bannerItems[i].setAttribute("src", e.target.result);
            };
        } else {
            console.log("파일 없음");
            bannerItems[i].setAttribute("src", "/resources/images/image-manager/banner/noneImg.png");
            bannerInput[i].value = '';
            if(initialStates[i] === 0){
                InsertNo.delete(i);
            bannerItems[i].setAttribute("state", initialStates[i]);
            }else{
                deleteNo.add(i);
                bannerItems[i].setAttribute("state", "-1");
            }

        }
    });
}


    // 이미지 변경 시 state를 2로 업데이트
function updateState(input) {
    const hiddenInput = input.previousElementSibling; // 숨겨진 state input
        if (hiddenInput && hiddenInput.name === "states") {
            hiddenInput.value = "2"; // 상태를 2로 변경
        }
    }

    



function removeImage(i) {
    
    if(bannerItems[i].getAttribute("state") === "0"){
        console.log("이미지 없음");
        return;
    }

    // 현재 상태 확인
    const currentState = Number(bannerItems[i].getAttribute("state"));

    // 초기 상태가 0이면 다시 0으로 복원
    if (initialStates[i] === 0) {

        //이미지가 있다면
        if(bannerItems[i].getAttribute("state") === "2"){
            console.log("이미지가 있었음");
            InsertNo.delete(i);
        }

        console.log("원래 없었던 이미지, 상태를 0으로 복원");
        bannerItems[i].setAttribute("state", "0");
        
    } else {
        console.log("원래 있었던 이미지, 상태를 -1로 설정");
        bannerItems[i].setAttribute("state", "-1");
        deleteNo.add(i);

        const refreshButton = document.getElementsByClassName("refreshButton")[i];
        refreshButton.style.display = "block";
    }

    // 이미지 제거
    bannerItems[i].setAttribute("src", "/resources/images/image-manager/banner/noneImg.png");
    bannerInput[i].value = '';
    updateNo.delete(i);

    // console.log("updateNo: "+updateNo);
    // console.log(deleteNo);
    console.log("이미지 삭제");
    // console.log(bannerInput[i].value);
}


function refreshImage(path, i) {

    // 초기 상태가 1인 경우만 복원
    if (initialStates[i] === 1) {
        
        // 삭제한 경우 
        if(Number(bannerItems[i].getAttribute("state")) == -1){
            // console.log(i);
            deleteNo.delete(Number(i));
            // console.log(deleteNo);
        // 수정한 경우
        }else{
            updateNo.delete(Number(i));
        }


        // 상태를 1로 변경
        bannerItems[i].setAttribute("state", "1");
        bannerItems[i].setAttribute("src", path);
    

        // 새로고침 아이콘 숨기기
        const refreshButton = document.getElementsByClassName("refreshButton")[i];
        refreshButton.style.display = "none";

        console.log("이미지 복원 완료");
    } else {
        console.log("초기 상태가 1이 아니므로 복원 불가");
    }
}


let changeFlag = false;

function imageSubmit(e){

        for(let item of bannerItems){
            itemState = Number(item.getAttribute("state"));
            if(itemState === 2 || itemState === -1){
                changeFlag = true;
                break;
            }
        }

        if(!changeFlag){
            alert("변경된 사항이 없습니다.");
            e.preventDefault();
            return;
        }   

       // InsertNo, updateNo, deleteNo 값을 문자열로 변환하여 hidden input에 설정
       const insertNoArray = Array.from(InsertNo).sort((a, b) => a - b); // 오름차순 정렬
       const updateNoArray = Array.from(updateNo).sort((a, b) => a - b);
       const deleteNoArray = Array.from(deleteNo).sort((a, b) => a - b);
   
       document.querySelector('input[name="InsertNo"]').value = insertNoArray.join(",");
       document.querySelector('input[name="updateNo"]').value = updateNoArray.join(",");
       document.querySelector('input[name="deleteNo"]').value = deleteNoArray.join(",");

    // console.log("InsertNo 정렬:", insertNoArray);
    // console.log("updateNo 정렬:", updateNoArray);
    // console.log("deleteNo 정렬:", deleteNoArray);
    alert("변경된 사항이 저장되었습니다.");
    // e.preventDefault();
    // return;
}


const modalMidPromotionSection = document.querySelector("#modalMidPromotionSection");
const promotionImageContent = document.querySelector(".promotionImageContent");
function promotionCollection(typeImg){
    console.log('click');
    modalMidPromotionSection.classList.toggle("active");

    fetch('promotionSelect?typeImg='+typeImg)
    .then(resp=>resp.json())
    .then(imageList =>{
        console.log(imageList);
       
        let count = 1;
        promotionImageContent.innerHTML='';
        for(let image of imageList){
            let div = document.createElement('div');
            let img = document.createElement("img");
            let closeButton = document.createElement("button");

            if(typeImg ==7){
                img.classList.add("promotionImage");
            }else{
                img.classList.add("miniPromotionImage");
            }
            div.classList.add("promotionImageTitle");
            closeButton.classList.add("closeButton");

            closeButton.setAttribute("onclick","closeButton()")

            div.append(count);
            img.setAttribute("src", `${image.imagePath}${image.imageReName}`);
            closeButton.innerHTML = "&#10005;"; // X symbol


            
            
            closeButton.addEventListener("click", () => {
               if(!confirm("해당 광고를 삭제하겠습니까?")){
                return;
               }
               
                div.remove();
                img.remove();
                closeButton.remove();

                fetch("deletePromotionImage?imageNo="+image.imageNo)
                .then(resp=>resp.json())
                .then(result=>{
                    if(result >0){
                        alert("해당 광고 이미지를 삭제하였습니다.")
                    }else{
                        alert("해당 광고 이미지 삭제 실패.")
                    }
                })
                .catch(err =>console.log(err))
                
            });


            let container = document.createElement("div");
            container.style.position = "relative";
            container.style.display = "inline-block";

            container.append(img, closeButton);
            promotionImageContent.append(div, container);
            count++;
        }
        
        
    })
    .catch(err=>{console.log(err)})
}

function closeAdModal() {
    modalMidPromotionSection.classList.toggle("active");
}

// 광고 이미지 삭제
function closeButton(){

}