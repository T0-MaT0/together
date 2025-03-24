<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기업 회원가입</title>
    <link rel="stylesheet" href="/resources/css/member/signUp-company.css">
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="main-content">

        <img src="/images/companyLogo.png" alt="">
        <div id="change-company-type">
            <div id="company-type-personal" onclick="location.href='/member/signUp1'">개인회원</div>
            <div id="company-type-company">기업회원</div>
        </div>

        
    
        <form action="/member/signUp1" method="POST" name="signUpFrm" id="signUpFrm">
    

            <div id="pink-box">

                <input type="hidden" name="authority" id="authority-input" value="3">

            
                <div id="ps-notice"><span class="required">★</span> 는 필수입력사항 입니다</div>
                <label for="memberId">
                    <span class="required">★</span> 아이디
                </label>
                <div class="signUp-input-area">
                    <input type="text" name="memberId" id="memberId"
                    placeholder="영어, 숫자 6~16자 이내로 입력" maxlength="30" autocomplete="off">
        
                </div>
                <span class="signUp-message" id="idMessage"></span>
        
        
        
                <!-- 비밀번호/비밀번호 확인 입력 -->
                <label for="memberPw">
                    <span class="required">★</span> 비밀번호
                </label>
        
        
                <div class="signUp-input-area">
                    <input type="password" name="memberPw" id="memberPw"
                    placeholder="영어, 숫자, 특수문자(!,@,#,-,_) 6~20자 사이로 입력" maxlength="20" >
                </div>

                <label for="memberPwConfirm">
                    <span class="required">★</span> 비밀번호 확인
                </label>
                <div class="signUp-input-area">
                    <input type="password" name="memberPwConfirm" id="memberPwConfirm"
                    placeholder="비밀번호 확인" maxlength="20" >
                </div>
        
        
                <span class="signUp-message" id="pwMessage"></span>
        
        
                <label for="memberName">
                    <span class="required">★</span> 이름
                </label>
                <div class="signUp-input-area">
                    <input type="text" name="memberName" id="memberName"
                    placeholder="홍길동" maxlength="20" >
                </div>
        
                <label for="memberBirth">
                    <span class="required">★</span> 생년월일
                </label>
                <div class="signUp-input-area">
                    <input type="text" name="memberBirth" id="memberBirth"
                    placeholder="생년월일 8자리 입력" maxlength="20" >
                </div>
                <span class="signUp-message" id="birthMessage"></span>

                <input type="hidden" id="isKakao" value="${not empty kakaoEmail}">
        
        
                <label for="memberEmail">
                    <span class="required">★</span> 이메일
                </label>
                <div class="signUp-input-area button-relative-area">
                    <input type="text" name="memberEmail" id="memberEmail"
                    placeholder="인증받을 이메일을 입력" maxlength="30" autocomplete="off" value="${kakaoEmail}">
                   
                    <button id="sendAuthKeyBtn" type="button">인증번호 전송</button>
                </div>
                <span class="signUp-message" id="emailMessage"></span>
        
        
        
                <div class="signUp-input-area button-relative-area marginTop-10">
                    <input type="text" name="authKey" id="authKey" s placeholder="인증번호 입력" maxlength="6" autocomplete="off" >
                   
                    <button id="checkAuthKeyBtn" type="button" class="button-style">확인</button>
                </div>
                <span class="signUp-message" id="authKeyMessage"></span>
               
        
                <label for="memberNick">
                    <span class="required">★</span> 사업자명
                </label>
        
        
                <div class="signUp-input-area">
                    <input type="text" name="memberNick" id="memberNick" placeholder="2~13자 이내로 입력해주세요." maxlength="13" >
                </div>
        
        
                <span class="signUp-message" id="nickMessage"></span>
        


                
                <label for="businessNo">
                    <span class="required">★</span> 사업자 등록번호
                </label>
        
        
                <div class="signUp-input-area button-relative-area">
                    <input type="text" name="businessNo" id="businessNo" placeholder="- 제외하고 10자리 숫자" maxlength="10" >
                    <button id="checkBusinessNo" type="button" class="button-style">확인</button>
                </div>
        
        
                <span class="signUp-message" id="businessNoMessage"></span>
        
        
        
        
                <!-- 전화번호 입력 -->
                <label for="memberTel">
                    <span class="required">★</span> 전화번호
                </label>
        
        
                <div class="signUp-input-area">
                    <input type="text" name="memberTel" id="memberTel" placeholder="-를 제외하고 숫자만 입력" maxlength="11">
                </div>
        
        
                <span class="signUp-message" id="telMessage"></span>

                <!-- 은행/계좌번호 입력 -->
                <label for="bankNo">
                    <span class="required">★</span> 계좌번호
                </label>


                <select name="bankName" id="bankName">
                    <option value=""selected disabled class="placeholder">은행을 선택하세요 &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; ▼</option>
                    <option value="국민은행">국민은행</option>
                    <option value="신한은행">신한은행</option>
                    <option value="하나은행">하나은행</option>
                    <option value="우리은행">우리은행</option>
                    <option value="카카오뱅크">카카오뱅크</option>
                    <option value="토스뱅크">토스뱅크</option>
                    <option value="케이뱅크">케이뱅크</option>
                </select>
        
        
                <div class="signUp-input-area">
                    <input type="text" name="bankNo" id="bankNo" placeholder="-를 제외하고 숫자만 입력" maxlength="40">
                </div>
        
        
                <span class="signUp-message" id="bankMessage"></span>
        
        
        
        
        
        
                <!-- 주소 입력 -->
                <label for="memberAddr">
                    <span class="required">★</span>
                    주소</label>
        
        
                <div class="signUp-input-area button-relative-area marginBottom">
                    <input type="text" name="memberAddr" placeholder="우편번호" maxlength="6" id="sample6_postcode">
                   
                    <button type="button" onclick="sample6_execDaumPostcode()" class="button-style">검색</button>
                </div>
        
        
                <div class="signUp-input-area">
                    <input type="text" name="memberAddr" placeholder="도로명/지번 주소" id="sample6_address">
                </div>
        
        
                <div class="signUp-input-area area-margin">
                    <input type="text" name="memberAddr" placeholder="상세 주소" id="sample6_detailAddress">
                </div>
    

                <div>
                    <img id="not-robot" src="/resources/images/mainJHI/notrobot.png" alt="">
                </div>

                
    
                <div id="all-agree-area" class="agree-area">
                    <label for="all-agree" id="all-agree-text">필수동의 항목 및 개인정보 수집 및 이용동의(선택), 광고성 정보 수신(선택)에 모두 동의합니다.</label>
                    <input type="checkbox" name="all-agree" id="all-agree">
                </div>
    
                <div class="make-line"></div>
                <div class="agree-area">
                    <label for="use-agree"><span class="required">[필수]</span> 이용약관 동의</label>
                    <input type="checkbox" name="use-agree" id="use-agree">
                </div>
                <div class="agree-area">
                    <label for="userdataPS-agree"><span class="required">[필수]</span> 개인정보 수집 및 이용 동의</label>
                    <input type="checkbox" name="userdataPS-agree" id="userdataPS-agree">
                </div>
                <div class="make-line"></div>
                <div class="agree-area">
                    <label for="userdateOP-agree">[선택] 개인정보 수집 및 이용동의</label>
                    <input type="checkbox" name="userdateOP-agree" id="userdateOP-agree">
                </div>
                <div class="agree-area">
                    <label for="email-agree">[선택] 광고성 정보 이메일 수신 동의</label>
                    <input type="checkbox" name="email-agree" id="email-agree">
                </div>
                <div class="agree-area">
                    <label for="sns-agree">[선택] 광고성 정보 SNS 수신 동의</label>
                    <input type="checkbox" name="sns-agree" id="sns-agree">
                </div>

            </div>
    
    
    
            <button id="signUpBtn">가입하기</button>
        </form>

    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script src="/resources/js/member/signUp.js"></script>

    
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function sample6_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    
                    var addr = ''; 
                   
                
                    if (data.userSelectedType === 'R') { 
                        addr = data.roadAddress;
                    } else { 
                        addr = data.jibunAddress;
                    }

                    
                    document.getElementById('sample6_postcode').value = data.zonecode;
                    document.getElementById("sample6_address").value = addr;
                    
                    document.getElementById("sample6_detailAddress").focus();
                }
            }).open();
        }
    </script>
        

    
</body>
</html>