<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="thumbnail" value="${business.imageList[0].imagePath}${business.imageList[0].imageReName}"/>
<c:set var="imageList" value="${review.imageList}"/>

<c:forEach var="option" items="${business.optionList}">
    <c:if test="${option.optionNo==order.optionNo}">
        <c:set var="optionName" value="${option.optionName}"/>
    </c:if>
</c:forEach>

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
                <img src="${thumbnail}">
                <div>
                    <span>${business.memberNickname}</span>
                    <span>${business.boardTitle}</span>
                    <span>${optionName}</span>
                </div>
            </div>
            <form action="/board/${boardCode}/${boardNo}/insertReview" method="post" id="reviewWriteForm" enctype="multipart/form-data">
                <input type="hidden" name="orderNo" value="${order.orderNo}">
                <input type="hidden" name="reviewUpdateNo" value="${review.reviewNo}">
                <input type="hidden" name="deleteList" id="deleteList">
                <div class="star-area">
                    <span>상품은 만족하셨나요?</span>
                    <div class="stars" id="starRating">
                        <c:forEach var="i" begin="1" end="5">
                            <c:if test="${i<=review.reviewStar}">
                                <i class="fa-solid fa-star"></i>
                            </c:if>
                            <c:if test="${i>review.reviewStar}">
                                <i class="fa-regular fa-star"></i>
                            </c:if>
                            <c:if test="${empty review.reviewStar}">
                                <i class="fa-regular fa-star"></i>
                            </c:if>
                        </c:forEach>
                    </div>
                    <input type="hidden" id="starCount" name="reviewStar" value="${review.reviewStar}">
                    <span id="starResult">
                        <c:if test="${empty review.reviewStar}">
                            선택하세요
                        </c:if>
                        <c:if test="${!empty review.reviewStar}">
                            ${review.reviewStar}점을 선택하셨습니다.
                        </c:if>
                    </span>
                </div>
                <div class="popup-content">
                    <textarea name="reviewContent" id="popupContentArea" 
                        placeholder="리뷰를 입력하세요">${review.reviewContent}</textarea>
                    <span id="popupContentCount">
                        <c:if test="${empty review.reviewContent}">
                            0/1000
                        </c:if>
                        <c:if test="${!empty review.reviewContent}">
                            ${fn:length(review.reviewContent)}/1000
                        </c:if>
                    </span>
                </div>
                <div class="review-img-area">
                    <c:forEach var="i" begin="0" end="4">
                        <c:if test="${!empty imageList[i]}">
                            <c:set var="displayStyle" value="display: inline;"/>
                            <c:set var="imageNo" value="${imageList[i].imageNo}"/>
                        </c:if>
                        <c:if test="${empty imageList[i]}">
                            <c:set var="displayStyle" value="display: none;"/>
                            <c:set var="imageNo" value="-1"/>
                        </c:if>
                        <div class="image-container" draggable="true">
                            <input type="hidden" name="imageNo" value="${imageNo}">
                            <input type="hidden" name="imageLevel" value="${i}">
                            <label for="img${i}">
                                <img class="preview" src="${imageList[i].imagePath}${imageList[i].imageReName}">
                            </label>
                            <input type="file" name="images" class="input-image" id="img${i}" accept="image/*">
                            <span class="delete-image" style="${displayStyle}">&times</span>
                        </div>
                    </c:forEach>
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