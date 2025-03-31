<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객센터 글 작성하기</title>

    <link rel="stylesheet" href="/resources/css/customer/customerBoardWrite.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div id="main-content">

        <section id="notice-header">
            <c:if test="${boardCode == 3}">
                <div id="notice-header-title">공지사항 작성하기</div>
            </c:if>
            <c:if test="${boardCode == 4}">
                <div id="notice-header-title">FAQ 작성하기</div>
            </c:if>
            <c:if test="${boardCode == 6}">
                <div id="notice-header-title">1 대 1 문의하기</div>
            </c:if>
        </section>
    
        <section id="notice-detail-content">
            <form action="/customer2/${boardCode}/insert" method="POST" class="board-write" 
            enctype="multipart/form-data"  id="boardWriteFrm">

                <c:if test="${boardCode == 4}">
                    <select name="boardCd" id="boardCd">
                        <option disabled selected hidden value="">문의 종류</option>
                        <option value="9">회원/계정 문의</option>
                        <option value="10">공동구매 문의</option>
                        <option value="11">결제/환불 문의</option>
                        <option value="12">수령/배송 문의</option>
                        <option value="13">기타 문의</option>
                    </select>
                </c:if>
        
                <div id="write-title-area">
        
                    <div class="board-title-area">
                        <input type="text" id="boardTitle" name="boardTitle" placeholder="제목을 입력해주세요.">
                    </div>
                </div>


                <div class="board-content-area">
                    <textarea id="boardContent" name="boardContent" placeholder="내용을 입력해주세요."></textarea>
                </div>

                <div id="checkPw-public-secret">
                    비밀번호<input type="password" id="check-pw">
                </div>

                <c:if test="${boardCode == 3}">

                    <div class="img-box">

                        <div class="boardImg">
                            <label for="img1">
                                <img class="preview" src="">
                            </label>
                            <input type="file" name="images" class="inputImage" id="img1" accept="image/*">
                            <span class="delete-image">&times;</span>
                        </div>
                        <div class="boardImg">
                            <label for="img2">
                                <img class="preview" src="">
                            </label>
                            <input type="file" name="images" class="inputImage" id="img2" accept="image/*">
                            <span class="delete-image">&times;</span>
                        </div>
                        <div class="boardImg">
                            <label for="img3">
                                <img class="preview" src="">
                            </label>
                            <input type="file" name="images" class="inputImage" id="img3" accept="image/*">
                            <span class="delete-image">&times;</span>
                        </div>
                    </div>


                </c:if>
               
                    

   
                

                <c:if test="${boardCode == 6}">
                    <div id="security-test">
                        <img src="" alt="captcha" id="captcha-img" class="c">
                        <input type="text" name="captchaInput" class="check-captcha-code" placeholder="보안문자를 입력하세요.">
                    </div>
                    
                    <div class="captcha-button-div">
                        <button id="reload" class="captcha-button">새로고침</button>
                        <button id="soundOn" class="captcha-button">음성듣기</button>
                    </div>
                </c:if>
                


                <div id="writeform-button-area">
                    <button type="submit" id="inquiry-write-button">등록</button>
                    <button type="button" id="go-back" onclick="history.back()">취소</button>
                </div>
            </form>

    
            
        </section>

    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script>
        const memberNo = "${loginMember.memberNo}";
    </script>
    <script src="/resources/js/customer/customerBoardWrite.js"></script>

</body>
</html>