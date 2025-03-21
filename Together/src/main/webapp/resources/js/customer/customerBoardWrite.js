console.log("CustomerBoardWrite 연결");


// 게시글 등록 시 제목, 내용 작성 여부 검사
const boardTitle = document.getElementsByName("boardTitle")[0];
const boardContent = document.getElementsByName("boardContent")[0];
const boardWriteFrm = document.getElementById("boardWriteFrm");

boardWriteFrm.addEventListener("submit", e=>{


    if(boardTitle.value.trim().length == 0){
        alert("제목을 입력해주세요.")
        boardTitle.focus();
        boardTitle.value="";
        e.preventDefault();
        return;
    } 
    

    if(boardContent.value.trim().length ==''){
        alert("내용을 입력해주세요.")
        boardContent.focus();
        boardContent.value="";
        e.preventDefault();
        return;
    } 

})

// 사진 미리보기
const preview = document.getElementsByClassName("preview");
const inputImage = document.getElementsByClassName("inputImage");
const deleteImage = document.getElementsByClassName("delete-image");


for(let i = 0; i<preview.length; i++){
    // 파일이 선택되거나, 선택 후 최소 되었을 때
    inputImage[i].addEventListener("change", e=>{

       const file =  e.target.files[0];// 선택된 파일의 데이터
       if(file !=undefined){//파일이 선택되었을 때
        const reader = new FileReader();// 파일을 읽는 객체

        reader.readAsDataURL(file);
        // 지정된 파일을 읽은 후 result 변수에 url 형식으로 저장
        
       reader.onload=function(e){ // 파일을 다 읽은 후 수행
        preview[i].setAttribute("src", e.target.result);
       }

       }else{ // 선택 후 최소 되었을 때 == 선택된 파일 없음 -> 미리보기 삭제
        preview[i].removeAttribute('src');
        inputImage[i].value=''
       }

    })

    //미리보기 삭제(x버튼)
    deleteImage[i].addEventListener("click", e=>{
        //미리보기 이미지가 있을 경우
        if(preview[i].getAttribute("src") != ''){
        
            // 미리보기 삭제
            preview[i].removeAttribute("src");

            // file 태그의 value 삭제
            // * input type = 'file'의 value는 ''(빈칸)만 대입 가능! *
            inputImage[i].value='';
        }
    })
    
}