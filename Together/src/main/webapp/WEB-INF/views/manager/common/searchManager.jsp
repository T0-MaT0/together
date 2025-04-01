<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>


<div class="managerSearchBarWrap">
        <input type="text" name="queryManager" placeholder="회원 닉네임를 입력하세요" class="managerSearchInput" autocomplete="off" />
        <!-- <button type="submit" class="managerSearchButton">검색</button> -->
    <div class="managerSearchListWrap hidden">
        <div class="ManagerItem">
            존재하는 회원이 없습니다.
        </div>
    </div>
</div>

<style>
    .managerSearchBarWrap{
        margin-left: 50px;
        position: relative;
    }

    .managerSearchInput{
        border: 0;
        background-color: rgba(255, 204, 255, 0.137);
        outline: none;
        width: 500px;
        padding: 10px;
        color: white;

        border-radius: 5px;
    }

    .managerSearchButton{
        padding: 10px 20px;
        border-radius: 5px;
        background-color: rgba(255, 255, 255, 0.308);
        border: 0;
        cursor: pointer;
        color: white;
    }

    .managerSearchButton:active{
        background-color: rgba(82, 82, 82, 0.308);
    }
    .managerSearchListWrap{
        background-color: rgba(255, 255, 255, 0.877);
        position: absolute;
        width: 500px;
        border-radius: 5px;
        border: 1px solid #ccc;
        color: black;

        z-index: 10000;
    }
    .managerSearchListWrap.hidden{
        display: none;
    }

    .ManagerItem{
        font-weight: normal;
        font-size: 16px;
        padding: 10px;

        cursor: pointer;
    }

    .ManagerItem:active{
        background-color: rgba(0, 0, 0, 0.164);
    }
</style>

<script>

    document.addEventListener("DOMContentLoaded", () => {
        const managerSearchInput = document.querySelector('.managerSearchInput');
        const managerSearchListWrap = document.querySelector('.managerSearchListWrap');
        if (managerSearchInput) {
            managerSearchInput.addEventListener("input", (e) => {
                
                const query = e.target.value;
                console.log(query);

                fetch("/managerSearch?query="+query)
                .then(resp=>resp.json())
                .then(memberList =>{
                    // 회원 번호, 회원 닉네임, 회원권한
                    managerSearchListWrap.innerHTML = ''; // 기존 결과 초기화
                    if (memberList.length === 0) {
                        const noResult = document.createElement("div");
                        noResult.classList.add("ManagerItem");
                        noResult.textContent = "존재하는 회원이 없습니다.";
                        managerSearchListWrap.append(noResult);
                    } else {
                        for (let member of memberList) {
                            const ManagerItem = document.createElement("div");
                            ManagerItem.classList.add("ManagerItem");
                            let authorityName = '';
                            switch (member.authority) {
                                case 2: authorityName = "개인 회원"; break;
                                case 3: authorityName = "브랜드 회원"; break;
                                default: authorityName = "알수없음";
                            }
                            const str = member.memberNick + " - " + authorityName;
                            console.log(member.memberNo);

                            let memberNo = member.memberNo;
                            ManagerItem.append(str);
                            ManagerItem.setAttribute("onclick","goToProfile("+memberNo+", "+member.authority+")");

                            managerSearchListWrap.append(ManagerItem);
                        }
                    }
                    managerSearchListWrap.classList.remove('hidden'); // 결과 표시

                })
                .catch(err=>console.log(err))




            });

            // 입력 필드 외부를 클릭하면 리스트 숨기기
            document.addEventListener("click", (e) => {
                if (!managerSearchInput.contains(e.target) && !managerSearchListWrap.contains(e.target)) {
                    managerSearchListWrap.classList.add('hidden');
                }
            });

            // 입력 필드에 포커스가 들어오면 리스트 표시
            managerSearchInput.addEventListener("focus", () => {
                managerSearchListWrap.classList.remove('hidden');
            });



        } else {
            console.error("managerSearchInput element not found.");
        }
    });

    
    // 멤버 프로필로 조회
    function goToProfile(memberNo, authority){
        if(authority == 2){
            location.href = "/manageCustomer/customerProfile?memberNo="+memberNo;
        }
        if(authority ==3){
            location.href = "/manageBrand/brandProfile?memberNo="+memberNo;

        }
    }
</script>