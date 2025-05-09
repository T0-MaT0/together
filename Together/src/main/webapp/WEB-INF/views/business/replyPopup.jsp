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
    <title>브랜드 Q&A 작성 팝업창</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <link rel="stylesheet" href="/resources/css/businessReview-style.css">
    
    <script src="https://kit.fontawesome.com/f8edd1a12b.js" crossorigin="anonymous"></script>
</head>

<body>
	<div id="reviewPopup">
        <div class="popup-header">Q&A 작성하기</div>
        <form action="/board/${boardCode}/${boardNo}/insertReply" method="post" id="replyWriteForm" enctype="multipart/form-data">
            <div class="popup-content-area">
                <div class="popup-content">
                    <textarea name="replyContent" id="popupContentArea" placeholder="문의 내용을 입력하세요"></textarea>
                    <span id="popupContentCount">0/1000</span>
                </div>
                <div class="secret-area">
                    <label class="custom-radio">
                        <input type="radio" name="secretReplyStatus" value="N" checked>
                        <span class="radio-mark"></span>
                        공개글
                    </label>
                    <label class="custom-radio">
                        <input type="radio" name="secretReplyStatus" value="Y">
                        <span class="radio-mark"></span>
                        비밀글
                    </label>
                </div>
                <div class="popup-footer">
                    <span>
                        문의 내용에 대한 답변은 해당 상품의 상세 페이지 또는 'Q&A 리스트'에서 확인하실 수 있습니다.
                    </span>
                    <div class="btn-area">
                        <button type="button" class="btn cancel" onclick="closePopup()">취소</button>
                        <button type="submit" class="btn submit">등록</button>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <script src="/resources/js/business/write.js"></script>
</body>
</html>