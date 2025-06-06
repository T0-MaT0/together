<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객센터 글 작성하기</title>
    <link rel="stylesheet" href="/resources/css/customer/customerBoardWrite.css">
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div id="main-content">
        <section id="notice-header">
            <c:choose>
                <c:when test="${boardType == 'NOTICE'}">
                    <div id="notice-header-title">공지사항 작성하기</div>
                </c:when>
                <c:when test="${boardType == 'FAQ'}">
                    <div id="notice-header-title">FAQ 작성하기</div>
                </c:when>
                <c:when test="${boardType == 'INQUIRY'}">
                    <div id="notice-header-title">1 대 1 문의하기</div>
                </c:when>
            </c:choose>
        </section>
    
        <section id="notice-detail-content">
            <form action="/customer2/${boardType.toLowerCase()}/insert" method="POST" class="board-write" enctype="multipart/form-data" id="boardWriteFrm">
                <c:if test="${boardType == 'FAQ'}">
                    <select name="inquiryCategoryNo" id="categoryNo">
                        <option disabled selected hidden value="">문의 종류</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.CATEGORY_NO}">${category.CATEGORY_NAME}</option>
                        </c:forEach>
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

                <c:if test="${boardType == 'INQUIRY'}">
                    <div id="checkPw-public-secret">
                        비밀번호<input type="password" id="boardPw" name="boardPw">
                    </div>
                </c:if>

                <c:if test="${boardType == 'NOTICE'}">
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
        const boardType = '${boardType}';

        // 이미지 미리보기
        document.querySelectorAll('.inputImage').forEach((input, index) => {
            input.addEventListener('change', function(e) {
                if(e.target.files && e.target.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        document.querySelectorAll('.preview')[index].src = e.target.result;
                    }
                    reader.readAsDataURL(e.target.files[0]);
                }
            });
        });

        // 이미지 삭제
        document.querySelectorAll('.delete-image').forEach((span, index) => {
            span.addEventListener('click', function() {
                document.querySelectorAll('.inputImage')[index].value = '';
                document.querySelectorAll('.preview')[index].src = '';
            });
        });

        // 폼 제출 전 유효성 검사
        document.getElementById('boardWriteFrm').addEventListener('submit', function(e) {
            const title = document.getElementById('boardTitle').value.trim();
            const content = document.getElementById('boardContent').value.trim();
            
            if(!title) {
                alert('제목을 입력해주세요.');
                e.preventDefault();
                document.getElementById('boardTitle').focus();
                return;
            }
            
            if(!content) {
                alert('내용을 입력해주세요.');
                e.preventDefault();
                document.getElementById('boardContent').focus();
                return;
            }

            if(boardType === 'FAQ' || boardType === 'INQUIRY') {
                const category = document.getElementById('categoryNo').value;
                if(!category) {
                    alert('카테고리를 선택해주세요.');
                    e.preventDefault();
                    document.getElementById('categoryNo').focus();
                    return;
                }
            }

            if(boardType === 'INQUIRY') {
                const password = document.getElementById('boardPw').value.trim();
                if(!password) {
                    alert('비밀번호를 입력해주세요.');
                    e.preventDefault();
                    document.getElementById('boardPw').focus();
                    return;
                }
            }
        });
    </script>
</body>
</html>