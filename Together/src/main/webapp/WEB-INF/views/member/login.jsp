<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>개인 로그인</title>
    
    <link rel="stylesheet" href="/resources/css/member/login-style.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
    <section class="login-container">


       
            <section id="left">
                <div>
                    
                    <div id="logo"><img src="/resources/images/mainJHI/logo.png" alt=""></div>
                    <h2 class="title">ToGether에 오신 것을</h2>
                    <h2 class="title">환영합니다.</h2>
                    <h5 id="content">ToGether는 공동구매 사이트 입니다.</h5>
                    <a src="#" class="signUp-button personal" id="goToSignUp">개인 회원가입</a>
                </div>
            </section>
            <section id="center"></section>

            <form action="/member/login" method="post" id="loginFrm">


                <section id="right">
    
                    <div class="member-bar">
                        <div class="under-line personal-line" id="underLine"></div>
                        <a class="member-type font-bold" data-type="personal">개인회원</a>
                        <a class="member-type" data-type="company">기업회원</a>
                    </div>
                    <input type="hidden" name="authority" id="authority-input" value="2">
                    <div><input type="text" name="memberId" placeholder="아이디" class="input-box id-box" autocomplete="off" value="${cookie.saveId.value}"></div>
                    <div><input type="password" name="memberPw" placeholder="비밀번호" class="input-box"></div>
                    
                    <%-- 쿠키에 saveId가 있는 경우--%>
                    <c:if test="${!empty cookie.saveId.value}">
		                    	<c:set var="save" value="checked"/>
		            </c:if>

                    <div id="check-box-div">
                        <label class="check-box-div-div font-12"><input type="checkbox"  id="save-login">로그인 유지</label>
                        <label class="check-box-div-div font-12"><input type="checkbox" name="saveId" id="saveId" ${save}>아이디 저장</label>
                    </div>
                    <div id="security-test">
                        <img src="/resources/images/mainJHI/simpleCapcha.png" alt="" class="c">
                        <input type="text" class="check-captcha-code" placeholder="보안문자를 입력하세요.">
                    </div>
                    <div class="captcha-button-div">
                        <button id="reload" class="captcha-button">새로고침</button>
                        <button id="soundOn" class="captcha-button">음성듣기</button>
                    </div>
                    <div><button id="login-button">로그인</button></div>
                    <div class="font-12 find-div">
                        <a href="#" id="find-id">아이디 찾기</a>|
                        <a href="#" id="find-pw">비밀번호 찾기</a>
                    </div>
                    <div class="font-12" id="sns-login">SNS 간편 로그인</div>
                    <div>
                        <div id="kakao-login">
                            <img src="../images/kakao3.png" alt="" id="kakao-logo">
                            카카오 로그인
                        </div>
                    </div>
                    <div>
    
                        <div id="google-login">
                            <img src="../images/googleLogo.png" alt="" id="google-logo">
                            구글 로그인 바꾸기
                        </div>
                    </div>
    
            </section>
            </form>

    </section>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <script src="/resources/js/member/login.js"></script>
</body>
</html>