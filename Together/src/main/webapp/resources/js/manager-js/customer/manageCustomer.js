console.log("asdf");


//------------- 고객 상태 페이지


// 고객 목록 클릭
function customerState(memberNo) {
    console.log(memberNo);
    location.href = "customerProfile?memberNo=" + memberNo;
}



const listArea = document.querySelector('#list-area');
const pagination = document.querySelector('#pagination');
const subMenuBtn = document.querySelectorAll(".subMenu-area > a");
const titleDiv  = document.querySelector("#container-center > section:nth-child(2) > div.board-title > div.title");

document.addEventListener("DOMContentLoaded",()=>{
    subMenuBtn[0]?.click();
})

/* 고객 프로필 게시판 조회 */
function boardList(boardCode, memberNo, cp) {


    fetch("/manageCustomer/customerProfile/" + boardCode + "?memberNo=" + memberNo)
        .then(resp => resp.json())
        .then(result => {

            titleDiv.innerText='';
            let title = '';
            for(let i=0; i<subMenuBtn.length; i++){
                console.log(subMenuBtn.length);
                if(boardCode == i){
                    subMenuBtn[i].classList.add("select");
                    switch(i){
                        case 0: title = "작성한 모집글"; break;
                        case 1: title = "1:1 문의"; break;
                        case 2: title = "주문 목록"; break;
                        case 3: title = "신고 당한 목록"; break;
                        case 4: title = "댓글 목록"; break;
                        case 5: title = "신고한 목록"; break;
                    }
                    titleDiv.append(title);
                }else{
                    subMenuBtn[i].classList.remove("select");
                }
            }
            

            const boardList = result.boardList;

            const pagination = result.pagination;

            // 목록 비우기
            listArea.innerHTML='';
            // 목록  상태 생성
            const listItem1 = document.createElement('div');
            listItem1.classList.add('list');
            
            const d1 = document.createElement("div");
            d1.innerText = "번호";
            const d2 = document.createElement("div");
            d2.innerText = "제목";
            const d3 = document.createElement("div");
            d3.innerText = "일자";
            const d4 = document.createElement("div");
            d4.innerText = "상태";
            listItem1.append(d1, d2, d3, d4);
            
            listArea.append(listItem1);

            if(boardList.length == 0 ){
                const notFound = document.createElement('div');
                notFound.classList.add('notFound');
                notFound.innerText = "존재하는 게시글이 없습니다.";
                listArea.append(notFound);
                return;
            }

            console.log(pagination);

            // 게시글 목록 for문
            for (let board of boardList) {
                console.log(board);
                // 새로운 div 요소들을 생성합니다.
                const listItem = document.createElement('div');
                listItem.classList.add('list', 'item', 'bottom-line'); // 클래스 추가

                // 첫 번째 div (번호)
                const div1 = document.createElement('div');
                div1.innerText = board.no;
                console.log(div1);
                // 두 번째 div (내용)
                const div2 = document.createElement('div');
                div2.innerText = board.title;

                // 세 번째 div (날짜)
                const div3 = document.createElement('div');
                div3.innerText = board.createDate;

                // 네 번째 div (상태)
                const div4 = document.createElement('div');
                div4.innerText = board.state;

                // 각 div를 listItem에 appendChild로 추가합니다.
                listItem.append(div1);
                listItem.append(div2);
                listItem.append(div3);
                listItem.append(div4);
                listArea.append(listItem);
                
            }


            if(Number(pagination.nextPage) < 2){
            return;
            }    
            const prevPage = document.querySelector("#pagination > li:nth-child(1)");
            prevPage.setAttribute('onclick',`prevPage(${boardCode}, ${memberNo}, ${pagination.prevPage})`);
            const nextPage = document.querySelector("#pagination > li:nth-child(2)");
            nextPage.setAttribute('onclick',`nextPage(${boardCode}, ${memberNo}, ${pagination.nextPage})`);
            



        })
        .catch(err => console.log(err))


}



function prevPage(boardCode, memberNo, cp){
    console.log('prevPage');
    boardList(boardCode, memberNo, cp );
}
function nextPage(boardCode, memberNo, cp){
    console.log('nextPage');
    boardList(boardCode, memberNo, cp );
}
