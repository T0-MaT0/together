<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1 : 1 문의 작성하기</title>

    <link rel="stylesheet" href="/resources/css/customer/problemWrite.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    ${boardCode}
    <div id="main-content">

        <section id="notice-header">
            <c:if test="${boardCode = 3}"></c:if>
            <div id="notice-header-title">공지사항 작성하기</div>
        </section>
    
        <section id="notice-detail-content">
            <form action="/customer2/${boardCode}/insert" method="POST" class="board-write" 
            enctype="multipart/form-data"  id="boardWriteFrm">
        
                <div id="write-title-area">

                    <c:if test="${boardCode > 8}">
                        <select name="problem-sort" id="problem-sort">
                            <option disabled selected hidden>문의 종류</option>
                            <option value="memberP">회원/계정 문의</option>
                            <option value="buyP">공동구매 문의</option>
                            <option value="cashP">결제/환불 문의</option>
                            <option value="shipP">수령/배송 문의</option>
                            <option value="elseP">기타 문의</option>
                        </select>
                    </c:if>
                    
        
        
                    <div class="board-title-area">
                        <input type="text" id="boardTitle" name="boardTitle" placeholder="제목을 입력해주세요.">
                    </div>
                </div>


                <div class="board-content-area">
                    <textarea id="boardContent" name="boardContent" placeholder="내용을 입력해주세요."></textarea>
                </div>

                <div id="checkPw-public-secret">
                    비밀번호<input type="text" id="check-pw">
                    <!-- <div id="secretOrPublic">
                        <input type="radio" name="secret-or-public" value="public" id="publicWrite" checked><label for="publicWrite">공개글</label>
                        <input type="radio" name="secret-or-public" value="secret" id="secretWrite"><label for="secretWrite">비밀글</label>
                    </div> -->
                </div>
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


                <div>
                    <img src="/resources/images/mainJHI/simpleCapcha.png">
                    <input type="text" placeholder="보안문자를 입력하세요.">
                </div>
                <div>
                    <button>새로고침</button>
                    <button>음성듣기</button>
                </div>


                <div id="writeform-button-area">
                    <button type="submit" id="inquiry-write-button">등록</button>
                    <button id="go-back">취소</button>
                </div>
            </form>

    
            
        </section>

    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/customer/customerBoardWrite.js"></script>

</body>
</html>