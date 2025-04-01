//조건에 따른 목록 조회
const BoardContainer = document.querySelector("#container-center > section");
const listAreaWrap = document.createElement('div');
const filterCustomerStatus = (e)=>{
    BoardContainer.innerHTML ='';
    listAreaWrap.innerHTML ='';
    boardStructureTop();
    boardStructureSubTitle();

    //회원, 블랙, 탈퇴
    let customerState = e.target.value;
    // console.log(customerState);
    const select = document.querySelector('#customerStatus');
    if (customerState == '대기') {
        select.value = '대기';
    
    } else if (customerState == '반려') {
        select.value = '반려';
    
    } else if (customerState == '경고') {
        select.value = '경고';
    
    } else if (customerState == '블랙') {
        select.value = '블랙';
    } else{
        location.href = '/manageCustomer/report';
    }
    
    console.log(customerState)
    fetch("reportCondition?customerState="+ customerState )
    .then(resp=>resp.json())
    .then(customerList =>{
        console.log(customerList);
        if(customerList.pagination.endPage == 0) {
            const notFound = document.createElement('div');
            notFound.classList.add('notFound');
            notFound.innerText = "존재하는 회원이 없습니다.";
            BoardContainer.append(notFound);
            return;
        }

        for(let customer of customerList.stateList){
            console.log(customer);
            boardStructure(customer);
        }

        const StatePagination = document.createElement("ul");
        StatePagination.id = "pagination";
        BoardContainer.append(StatePagination);
        //pagination 객체
        const pagination = customerList.pagination;

        //<<
        const li1 = document.createElement('li');
        const a1 = document.createElement('a');
        a1.setAttribute("onclick", `statePageMove('${customerState}', 1)`)
        a1.append("<<");
        li1.append(a1);
        StatePagination.append(li1);
        //<
        const li2 = document.createElement('li');
        const a2 = document.createElement('a');
        a2.setAttribute("onclick", `statePageMove('${customerState}', ${pagination.prevPage})`)
        a2.append("<");
        li2.append(a2);
        StatePagination.append(li2);

        // 숫자
        for (let i = pagination.startPage; i <= pagination.endPage; i++) {
            console.log('작동')
            if(pagination.currentPage ==i){
                let li3 = document.createElement('li');
                li3.classList.add('curr');
                li3.innerText = i;
                StatePagination.append(li3);
            }else{
                let li4 = document.createElement('li');
                // li4.classList.add('curr');
                let a3 = document.createElement('a');
                a3.innerText=i;
                a3.setAttribute("onclick", `statePageMove('${customerState}', ${i})`);
                li4.append(a3);
                StatePagination.append(li4);
            }

        }

        //>
        const li5 = document.createElement('li');
        const a4 = document.createElement('a');
        a4.setAttribute("onclick", `statePageMove('${customerState}', ${pagination.nextPage})`)
        a4.append(">");
        li5.append(a4);
        StatePagination.append(li5);
        //>>
        const li6 = document.createElement('li');
        const a5 = document.createElement('a');
        a5.setAttribute("onclick", `statePageMove('${customerState}', ${pagination.maxPage})`)
        a5.append(">>");
        li6.append(a5);
        StatePagination.append(li6);


        // StatePagination.append();
    })
    .catch(err => console.log(err))


}

//페이지 전환
function statePageMove(customerState, cp){
    
    BoardContainer.innerHTML ='';
    listAreaWrap.innerHTML ='';
    boardStructureTop();
    boardStructureSubTitle();
    const select = document.querySelector('#customerStatus');
    if (customerState == '대기') {
        select.value = '대기';
    
    } else if (customerState == '반려') {
        select.value = '반려';
    
    } else if (customerState == '경고') {
        select.value = '경고';
    
    } else if (customerState == '블랙') {
        select.value = '블랙';
    } else{
        location.href = '/manageCustomer/report';
    }
    fetch("reportCondition?customerState="+customerState+"&cp="+cp )
    .then(resp=>resp.json())
    .then(customerList =>{
        console.log(customerList);
        if(customerList.pagination.endPage == 0) {
            const notFound = document.createElement('div');
            notFound.classList.add('notFound');
            notFound.innerText = "존재하는 문의가 없습니다.";
            BoardContainer.append(notFound);
            return;
        }

        for(let customer of customerList.stateList){
            console.log(customer);
            boardStructure(customer);
        }
        const StatePagination = document.createElement("ul");
        StatePagination.id = "pagination";
        BoardContainer.append(StatePagination);
        //pagination 객체
        const pagination = customerList.pagination;

        //<<
        const li1 = document.createElement('li');
        const a1 = document.createElement('a');
        a1.setAttribute("onclick", `statePageMove('${customerState}', 1)`)
        a1.append("<<");
        li1.append(a1);
        StatePagination.append(li1);
        //<
        const li2 = document.createElement('li');
        const a2 = document.createElement('a');
        a2.setAttribute("onclick", `statePageMove('${customerState}', ${pagination.prevPage})`)
        a2.append("<");
        li2.append(a2);
        StatePagination.append(li2);

        // 숫자
        for (let i = pagination.startPage; i <= pagination.endPage; i++) {

            if(pagination.currentPage ==i){
                let li3 = document.createElement('li');
                li3.classList.add('curr');
                li3.innerText = i;
                StatePagination.append(li3);
            }else{
                let li4 = document.createElement('li');
                // li4.classList.add('curr');
                let a3 = document.createElement('a');
                a3.innerText=i;
                a3.setAttribute("onclick", `statePageMove('${customerState}', ${i})`);
                li4.append(a3);
                StatePagination.append(li4);
            }

        }

        //>
        const li5 = document.createElement('li');
        const a4 = document.createElement('a');
        a4.setAttribute("onclick", `statePageMove('${customerState}', ${pagination.nextPage})`)
        a4.append(">");
        li5.append(a4);
        StatePagination.append(li5);
        //>>
        const li6 = document.createElement('li');
        const a5 = document.createElement('a');
        a5.setAttribute("onclick", `statePageMove('${customerState}', ${pagination.maxPage})`)
        a5.append(">>");
        li6.append(a5);
        StatePagination.append(li6);


        // StatePagination.append();
    })
    .catch(err => console.log(err))
}


// boardTopTitleCreate
function boardStructureTop(){

    const boardTitle = document.createElement('div');
    boardTitle.classList.add('board-title', 'bottom-line');

    const titleDiv = document.createElement('div');
    titleDiv.classList.add('title');
    titleDiv.innerText = '고객 대상 신고';

    const selectArea = document.createElement('div');
    selectArea.classList.add('select-area');

    const select = document.createElement('select');
    select.name = 'customerStatus';
    select.id = 'customerStatus';
    select.setAttribute('onchange', 'filterCustomerStatus(event)');

    const optionAll = document.createElement('option');
    optionAll.innerText = '전체';

    const optionWait = document.createElement('option');
    optionWait.innerText = '대기';


    const optionBack = document.createElement('option');
    optionBack.innerText = '반려';

    const optionWarn = document.createElement('option');
    optionWarn.innerText = '경고';

    const optionBlack = document.createElement('option');
    optionBlack.innerText = '블랙';
    


    select.append(optionAll, optionWait, optionBack, optionWarn, optionBlack );
    selectArea.append(select);
    boardTitle.append(titleDiv, selectArea);
    BoardContainer.append(boardTitle);
}
//boardSubTitleCreate
function boardStructureSubTitle(){
    listAreaWrap.id = 'list-area';

    const listItem = document.createElement('div');
    listItem.classList.add('list');

    const div1 = document.createElement('div');
    div1.innerText = '번호';

    const div2 = document.createElement('div');
    div2.innerText = '신고자';

    const div3 = document.createElement('div');
    div3.innerText = '피신고자';

    const div4 = document.createElement('div');
    div4.innerText = '신고 제목';

    const div5 = document.createElement('div');
    div5.innerText = '신고 일자';

    const div6 = document.createElement('div');
    div6.innerText = '상태';


    listItem.append(div1, div2, div3, div4, div5, div6);
    listAreaWrap.append(listItem);
    BoardContainer.append(listAreaWrap);

}

function boardStructure(customer){
    let listItem = document.createElement('div');
    listItem.classList.add('list', 'item', 'bottom-line', 'clickArea');
    listItem.setAttribute('onclick', `customerState(${customer.memberNo})`);

    let div1 = document.createElement('div');
    div1.innerText = customer.reportNo;

    let div2 = document.createElement('div');
    div2.innerText = customer.memberNick;

    let div3 = document.createElement('div');
    div3.innerText = customer.reportedUserNick;

    let div4 = document.createElement('div');
    div4.classList.add("clickList");
    div4.setAttribute("onclick",`customerReport(${customer.reportNo})`)
    div4.innerText = customer.reportTitle;

    let div5 = document.createElement('div');
    div5.innerText = customer.reportDate;

    let div6 = document.createElement('div');
    div6.innerText = customer.reportStatus;

    listItem.append(div1, div2, div3, div4, div5, div6);
    listAreaWrap.append(listItem);
    BoardContainer.append(listAreaWrap);
}
console.log("hello")