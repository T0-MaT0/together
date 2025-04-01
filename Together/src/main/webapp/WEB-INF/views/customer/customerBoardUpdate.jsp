<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객센터 글 작성하기</title>

    <link rel="stylesheet" href="/resources/css/customer/customerBoardUpdate.css">
</head>
<body>
    ${map}
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div id="main-content">

        <section id="notice-header">

            <c:if test="${boardCode == 3}">
                <div id="notice-header-title">공지사항 수정하기</div>
            </c:if>
            <c:if test="${boardCode == 4}">
                <div id="notice-header-title">FAQ 수정하기</div>
            </c:if>

        </section>
    
        <section id="notice-detail-content">
            <form action="/customer2/${boardCode}/${boardNo}/update" method="POST" class="board-write" 
            enctype="multipart/form-data"  id="boardUpdateFrm">

                <c:if test="${boardCode == 4}">
                    <select name="boardCd" id="boardCd">
                        <option disabled hidden ${empty map.boardDetail.boardCd ? 'selected' : ''}>문의 종류</option>
                        <option value="9"  ${map.boardDetail.boardCd == 9  ? 'selected' : ''}>회원/계정 문의</option>
                        <option value="10" ${map.boardDetail.boardCd == 10 ? 'selected' : ''}>공동구매 문의</option>
                        <option value="11" ${map.boardDetail.boardCd == 11 ? 'selected' : ''}>결제/환불 문의</option>
                        <option value="12" ${map.boardDetail.boardCd == 12 ? 'selected' : ''}>수령/배송 문의</option>
                        <option value="13" ${map.boardDetail.boardCd == 13 ? 'selected' : ''}>기타 문의</option>
                    </select>
                </c:if>
        
                <div id="write-title-area">
        
                    <div class="board-title-area">
                        <input type="text" id="boardTitle" name="boardTitle" placeholder="제목을 입력해주세요." value="${map.boardDetail.boardTitle}">
                    </div>
                </div>


                <div class="board-content-area">
                    <textarea id="boardContent" name="boardContent" placeholder="내용을 입력해주세요.">${map.boardDetail.boardContent}</textarea>
                </div>

                <div id="checkPw-public-secret">
                    비밀번호<input type="password" id="check-pw">
                </div>

                <!-- board.imageList에 존재하는 이미지 객체를 얻어와서 순서(imageLevel)대로 변수 생성 -->
                <c:forEach items="${map.imageList}" var="img">
                    <c:choose>
                        <c:when test="${img.imageLevel == 0}">
                            <c:set var="img1" value="${img.imagePath}${img.imageReName}"/>
                        </c:when>
                        <c:when test="${img.imageLevel == 1}">
                            <c:set var="img2" value="${img.imagePath}${img.imageReName}"/>
                        </c:when>
                        <c:when test="${img.imageLevel == 2}">
                            <c:set var="img3" value="${img.imagePath}${img.imageReName}"/>
                        </c:when>
                    </c:choose>

                </c:forEach>

                <c:if test="${boardCode == 3}">

                    <div class="img-box">

                        <div class="boardImg">
                            <label for="img1">
                                <img class="preview" src="${img1}">
                            </label>
                            <input type="file" name="images" class="inputImage" id="img1" accept="image/*">
                            <span class="delete-image">&times;</span>
                        </div>
                        <div class="boardImg">
                            <label for="img2">
                                <img class="preview" src="${img2}">
                            </label>
                            <input type="file" name="images" class="inputImage" id="img2" accept="image/*">
                            <span class="delete-image">&times;</span>
                        </div>
                        <div class="boardImg">
                            <label for="img3">
                                <img class="preview" src="${img3}">
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
                

                <!-- 기존 이미지가 있다가 삭제된 이미지의 순서를 기록 -->
                <input type="hidden" name="deleteList" value="">

                <!-- 수정 성공 시 주소(쿼리스트링) 유지용도 -->
                <input type="hidden" name="cp" value="${param.cp}">


                <div id="writeform-button-area">
                    <button type="submit" id="writebtn">등록</button>
                    <button type="button" id="go-back" onclick="history.back()">취소</button>
                </div>
            </form>

    
            
        </section>

    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script>
        const memberNo = "${loginMember.memberNo}";
    </script>
    <script src="/resources/js/customer/customerBoardUpdate.js"></script>

</body>
</html>