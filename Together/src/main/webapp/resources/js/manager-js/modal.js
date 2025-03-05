const modal = document.querySelector('#modal');
const clickList = document.getElementsByClassName("clickList");

for(let item of clickList){
    item.addEventListener("click", e=>{
        console.log(item);
        modal.classList.add("modalActive");
        


    })

}

/* 모달 닫기 */
document.getElementsByClassName("close")[0].addEventListener("click", e=>{
    modal.classList.remove("modalActive");


})
