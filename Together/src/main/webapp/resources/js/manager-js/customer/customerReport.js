console.log("연결");



/* 고객 대상 신고 리스트 */
function customerReportList(){

    fetch("/manageCustomer/reportSelect")
    .then(resp =>resp.json())
    .then(map =>{
        console.log(map);


        const listItem = document.createElement('div');
        listItem.classList.add('list', 'item', 'bottom-line');

        const div1 = document.createElement('div');
        const div2 = document.createElement('div');
        const div3 = document.createElement('div');
        const div4 = document.createElement('div');
        const div5 = document.createElement('div');
        const div6 = document.createElement('div');

    })
    .catch(err=>console.log(err)); 
}