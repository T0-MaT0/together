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
    <link rel="stylesheet" href="/resources/css/CreateGroup.css">
    <!-- flatpickr CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <!-- flatpickr JS -->
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <!-- flatpickr 한국어 locale 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
</head>
<body>
    <div id="main-container">
        <main>

            <!-- 🔹 Form: multipart/form-data 로 파일 업로드 가능 -->
            <form id="createGroupForm" 
                  action="/group/create/insert" 
                  method="post" 
                  enctype="multipart/form-data">

                <!-- 제목 -->
                <div class="form-group title-row">
                    <label for="boardTitle" class="title-label">제목</label>
                    <input type="text" id="boardTitle" name="boardTitle" class="title-input" 
                           placeholder="제목을 입력해 주세요" maxlength="30">
                </div>

                <!-- 카테고리 (부모/자식) -->
                <div class="form-group">
                    <!-- 부모 카테고리 -->
                    <div class="form-group" style="display: flex; align-items: center; gap: 10px;">
                        <label for="parentCategory">카테고리 선택:</label>
                        <div class="url-input" style="flex: 1; display: flex; align-items: center;">
                            <span>🔍</span>
                            <select id="parentCategory" name="parentCategory"
                                    style="flex: 1; border: none; background: transparent;">
                                <option value="">-- 부모 카테고리 --</option>
                                <c:forEach var="parent" items="${parentList}">
                                    <option value="${parent.categoryNo}">${parent.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <!-- 자식 카테고리 -->
                    <div class="form-group" style="display: flex; align-items: center; gap: 10px;">
                        <label for="childCategory">하위 카테고리:</label>
                        <div class="url-input" style="flex: 1; display: flex; align-items: center;">
                            <select id="childCategory" name="categoryNo"
                                    style="flex: 1; border: none; background: transparent;" 
                                    disabled>
                                <option value="">-- 선택 --</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- 설명 -->
                <div class="form-group">
                    <textarea id="description" name="boardContent"  placeholder="모집 상품에 대해 설명해주세요"></textarea>
                </div>

                <!-- 이미지 업로드 (4장 예시) -->
                <h5>업로드 이미지</h5>
                <h5>대표 이미지</h5>
                <div class="boardImg main-image">
                    <label for="imgMain">
                        <img class="preview" src="" alt="" />
                    </label>
                    <input type="file" name="images" class="inputImage" id="imgMain" accept="image/*">
                    <span class="delete-image">&times;</span>
                </div>

                <h5>추가 이미지</h5>
                <div class="sub-img-box" style="display: flex; gap: 20px;">
                    <div class="boardImg">
                        <label for="img2">
                            <img class="preview" src="" alt=""/>
                        </label>
                        <input type="file" name="images" class="inputImage" id="img2" accept="image/*">
                        <span class="delete-image">&times;</span>
                    </div>
                    <div class="boardImg">
                        <label for="img3">
                            <img class="preview" src="" alt=""/>
                        </label>
                        <input type="file" name="images" class="inputImage" id="img3" accept="image/*">
                        <span class="delete-image">&times;</span>
                    </div>
                    <div class="boardImg">
                        <label for="img4">
                            <img class="preview" src="" alt=""/>
                        </label>
                        <input type="file" name="images" class="inputImage" id="img4" accept="image/*">
                        <span class="delete-image">&times;</span>
                    </div>
                </div>

                <!-- 기타 입력 -->
                <div class="form-group">
                    <label>상품 사이트 URL:</label>
                    <div class="url-input">
                        <input type="text" id="productUrl" name="productUrl" placeholder="구매 링크">
                    </div>
                </div>

                <div class="form-section">
                    <div class="form-box">
                        <label for="hiddenRangeInput" style="display: block; margin-bottom: 6px;">
                            <strong>마감 기한</strong>
                        </label>
                        <div>
                            <input type="text" id="hiddenRangeInput" name="recEndDate" style="display:none;">
                            <span id="calendarIcon" style="cursor:pointer; color:#b82;">📅 :</span>
                            <span id="displaySingle" style="margin-left:10px; font-weight:bold;"></span>
                        </div>
                        <p><strong>O9 지역</strong></p>
                        <button type="button" class="btn-create">찾기</button>
                        <p id="chosenAddress" name="region" style="margin-top:10px; color:black; font-weight:bold;"></p>
                        <input type="hidden" id="regionInput" name="region" />
                    </div>
                    <div class="form-box">
                        <p><strong>총 인원</strong></p>
                        <input type="text" id="maxParticipants" name="maxParticipants" placeholder="인원 수를 입력하세요">
                        <p><strong>내 선택 수량</strong></p>
                        <input type="text" id="myQuantity" name="myQuantity" placeholder="내가 선택한 수량을 입력하세요">
                    </div>
                    <div class="form-box">
                        <p><strong>총 금액</strong></p>
                        <input type="text" name="productPrice" id="productPrice" placeholder="총 금액을 입력하세요">
                    </div>
                </div>

                <!-- 제출 -->
                <div class="btn-submit-container">
                    <button type="submit" class="btn-submit">모집 만들기</button>
                </div>
            </form>
        </main>
    </div>
    
 
    <script src="/resources/js/individual/createGroup.js"></script>

    <c:if test="${not empty message}">
        <script>
            alert("${message}");
        </script>
    </c:if>
</body>
</html>
