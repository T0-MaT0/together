<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ</title>
    <link rel="stylesheet" href="/resources/css/customer/FAQBoard-style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div id="main-content">

        <section id="FAQ-header">
            <div id="FAQ-header-title">❓ 자주 묻는 질문 (FAQ)</div>
            
            <form action="/board/search" method="GET">
                <fieldset class="search-area">
    
                    <input type="search" name="query" id="query"
                    placeholder="검색어를 입력해주세요.">
    
                    <button id="searchBtn" class="fa-solid fa-magnifying-glass"></button>
    
                </fieldset>
            </form>
        </section>
    
        <section id="FAQ-content">

            <div id="button-content">
                <div class="current-focus">전체</div>
                <div>회원/계정</div>
                <div>공동구매</div>
                <div>결제/환불</div>
                <div>수령/배송</div>
                <div>기타</div>
            </div>


         


            <table class="list-table">
                
                <thead id="fix-FAQ">
                </thead>

                <tbody>
                    <tr>
                        <td onclick="openAnswer()">Q. 회원가입은 어떻게 하나요?</td>
                        <td>▼</td>
                    </tr>
                    <tr class="answer-style">
                        <td colspan='2'>A. 이메일 또는 소셜 로그인(네이버, 카카오, 구글)으로 가입할 수 있습니다.</td>
                    </tr>
                    <tr>
                        <td onclick="openAnswer()">Q. 비밀번호를 잊어버렸어요. 어떻게 찾을 수 있나요?</td>
                        <td>▼</td>
                    </tr>
                    <tr class="answer-style hidden-answer">
                        <td colspan='2'>A. 로그인 페이지에서 ‘비밀번호 찾기’를 눌러 이메일을 통해 재설정할 수 있습니다.</td>
                    </tr>
                    <tr>
                        <td onclick="openAnswer()">Q. 닉네임을 변경할 수 있나요? </td>
                        <td>▼</td>
                    </tr>
                    <tr class="hidden-answer">
                        <td colspan='2'>A. 마이페이지 > 계정 설정에서 변경 가능합니다.</td>
                    </tr>
                    <tr>
                        <td onclick="openAnswer()">Q. 계정을 탈퇴하려면 어떻게 해야 하나요?</td>
                        <td>▼</td>
                    </tr>
                    <tr class="hidden-answer">
                        <td colspan='2'>A. 마이페이지 > 설정 > 계정 탈퇴에서 가능합니다. 단, 진행 중인 공동구매가 있을 경우 탈퇴가 제한됩니다.</td>
                    </tr>
                    <tr>
                        <td onclick="openAnswer()">Q. 이메일/SMS 알림을 받고 싶지 않아요. 설정을 변경할 수 있나요?</td>
                        <td>▼</td>
                    </tr>
                    <tr class="hidden-answer">
                        <td colspan='2'>A. 마이페이지 > 알림 설정에서 원하는 알림만 선택하여 받을 수 있습니다.</td>
                    </tr>
                    <tr>
                        <td onclick="openAnswer()">Q. 공동구매는 어떻게 진행되나요?</td>
                        <td>▼</td>
                    </tr>
                    <tr class="hidden-answer">
                        <td colspan='2'>A. 참여자가 일정 인원 이상 모이면 자동으로 결제가 진행되며, 이후 판매자가 상품을 배송합니다.</td>
                    </tr>
                    <tr>
                        <td onclick="openAnswer()">Q. 공동구매 모집은 얼마나 걸리나요? </td>
                        <td>▼</td>
                    </tr>
                    <tr class="hidden-answer">
                        <td colspan='2'>A. 상품마다 모집 기한이 다르며, 상세 페이지에서 확인할 수 있습니다.</td>
                    </tr>
                </tbody>
            </table>

       
    
    
        </section>
    
        <section id="pageNAtion">
            <<  <  1 2 3 4 5  >  >> 
        </section>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    

    
</body>
</html>