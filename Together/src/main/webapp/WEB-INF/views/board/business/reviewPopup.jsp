<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="optionCount" value="${fn:length(business.optionList)}"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>브랜드 리뷰 작성 팝업창</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <link rel="stylesheet" href="/resources/css/businessReview-style.css">
    
    <script src="https://kit.fontawesome.com/f8edd1a12b.js" crossorigin="anonymous"></script>
</head>

<body>
	<div id="reviewPopup">
        <div class="popup-header">리뷰 작성하기</div>
        <div class="popup-content-area">
            <div class="product-option-area">
                <img src="/resources/images/business/product.png">
                <div>
                    <!-- 수정 예정 -->
                    <span>브랜드 이름</span>
                    <span>제품이름이 긴 상품</span>
                    <span>옵션 내용</span>
                </div>
            </div>
            <form action="#" method="post" id="reviewWriteForm" enctype="multipart/form-data">
                <div class="star-area">
                    <span>상품은 만족하셨나요?</span>
                    <div class="stars" id="starRating">
                        <i class="fa-regular fa-star"></i>
                        <i class="fa-regular fa-star"></i>
                        <i class="fa-regular fa-star"></i>
                        <i class="fa-regular fa-star"></i>
                        <i class="fa-regular fa-star"></i>
                    </div>
                    <input type="hidden" id="starCount">
                    <span id="starResult">선택하세요</span>
                </div>
                <div class="popup-content">
                    <textarea id="popupContentArea" placeholder="리뷰를 입력하세요"></textarea>
                    <span id="popupContentCount">0/1000</span>
                </div>
                <div class="review-img-area">
                    <div>
                        <label for="img0">
                            <img class="preview" src="">
                        </label>
                        <input type="file" name="images" class="input-image" id="img0" accept="image/*">
                        <span class="delete-image">&times</span>
                    </div>
                </div>
                <div class="popup-footer">
                    <span>
                        리뷰 내용에 대한 답변은 해당 상품의 상세 페이지 또는 '마이페이지 > 리뷰 후기'에서 확인하실 수 있습니다.
                    </span>
                    <div class="btn-area">
                        <button type="button" class="btn cancel" onclick="closePopup()">취소</button>
                        <button type="submit" class="btn submit">등록</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="/resources/js/business/write.js"></script>
</body>
</html>