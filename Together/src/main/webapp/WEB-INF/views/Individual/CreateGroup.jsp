<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CreateGroup</title>
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css/CreateGroup.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div id="main-container">
        <main>
            <div class="recruitment-form">
                <div class="form-title">제목을 입력해 주세요</div>
                <div class="form-group">
                    <div class="form-group" style="display: flex; align-items: center; gap: 10px;">
                        <label for="category">카테고리 선택:</label>
                        <div class="url-input" style="flex: 1; display: flex; align-items: center;">
                            <span>🔍</span>
                            <select id="category" style="flex: 1; border: none; background: transparent;">
                                <option value="fashion">패션 - 상의</option>
                                <option value="electronics">전자 제품</option>
                                <option value="home">생활 용품</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <textarea id="description" rows="4" style="resize: none;" placeholder="O9 상품에 대해 설명해주세요"></textarea>
                </div>


                <div class="image-upload">
                    <div class="image-container" >
                        <p>대표 이미지를 지정해 주세요</p>
                        <img src="sample-image.png" alt="대표 이미지" >
                        <input type="file" id="file-upload-group" >
                    </div>
                    <div class="file-upload-group">
                        <label for="file-upload-group" class="btn-file-select" >파일 선택</label>

                    </div>
                </div>


                <div class="form-group">
                    <label>상품 사이트 URL:</label>
                    <div class="url-input">
                        <input type="text" placeholder="구매 링크">
                    </div>
                </div>
                <div class="form-section">
                    <div class="form-box">
                        <p><strong>마감 기한</strong></p>
                        <p>📅 시작 날짜 ~ 마감 날짜</p>
                        <p><strong>O9 지역</strong></p>
                        <button class="btn-create">찾기</button>
                    </div>
                    <div class="form-box">
                        <p><strong>총 인원</strong></p>
                        <input type="text" placeholder="인원 수를 입력하세요">
                        <p><strong>내 선택 수량</strong></p>
                        <input type="text" placeholder="내가 선택한 수량을 입력하세요">
                    </div>
                    <div class="form-box">
                        <p><strong>총 금액</strong></p>
                        <input type="text" placeholder="총 금액을 입력하세요">
                    </div>
                </div>
            </div>
            <div class="btn-submit-container">
                <button class="btn-submit">O9 만들기</button>
            </div>
        </main>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/individual/individualMain.js"></script>
</body>
</html>
