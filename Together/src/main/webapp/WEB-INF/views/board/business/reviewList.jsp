<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="reviewList" value="${map.reviewList}"/>
<c:set var="pagination" value="${map.reviewPagination}"/>

<c:set var="url" value="/board/${boardCode}/reviewList?reviewCp="/>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>브랜드 리뷰 목록 페이지</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css/businessDetail-style.css">

    <script src="https://kit.fontawesome.com/f8edd1a12b.js" crossorigin="anonymous"></script>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <main>
        <section class="content">
            <div class="list-area">
                <h3>REVIEW</h3>
                <table>
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>상품 이미지</th>
                            <th>상품 제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty reviewList}">
                            <tr>
                                <th colspan="5">리뷰가 없습니다.</th>
                            </tr>
                        </c:if>

                        <c:if test="${!empty reviewList}">
                            <c:forEach var="review" items="${reviewList}">
                                <tr>
                                    <td>${review.reviewNo}</td>
                                    <td>
                                        <c:if test="${!empty review.imageList}">
                                            <img class="list-thumbnail" src="${review.imageList[0].imagePath}${review.imageList[0].imageReName}">
                                        </c:if>
                                        <c:if test="${empty review.imageList}">
                                            <img class="list-thumbnail" src="${review.businessThumbnail}">
                                        </c:if>
                                    </td>
                                    <td class="show-modal-area" review-no="${review.reviewNo}">${review.reviewContent}</td>
                                    <td>${review.memberNickname}</td>
                                    <td class="date-area" data-date="${review.reviewCreatedDate}"></td>
                                </tr>
                            </c:forEach>
                        </c:if>
                    </tbody>
                </table>
                <div class="pagination-area">
                    <c:if test="${pagination.maxPage>1}">
                        <ul class="pagination">
                            <li><a href="${url}1">&lt;&lt;</a></li>
        
                            <li><a href="${url}${pagination.prevPage}">&lt;</a></li>
                            
                            <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
                                <c:if test="${pagination.currentPage==i}">
                                    <li><a class="current">${i}</a></li>
                                </c:if>
                                <c:if test="${pagination.currentPage!=i}">
                                    <li><a href="${url}${i}">${i}</a></li>
                                </c:if>
                            </c:forEach>
                            
                            <li><a href="${url}${pagination.nextPage}">&gt;</a></li>
        
                            <li><a href="${url}${pagination.maxPage}">&gt;&gt;</a></li>
                        </ul>
                    </c:if>
                </div>
            </div>
        </section>
    </main>
    
    <div class="modal hide">
        <div id="modalContent">
            <div class="modal-img-area"></div>
            <div class="modal-detail-area">
                <div class="rating-area"></div>
                <div class="user-area"></div>
                <div class="review-option-area">
                    <span>사용자가 선택한 옵션 내용(추후 수정 예정)</span>
                </div>
                <div class="review-content"></div>
                <div class="reply-area">
                    <div id="replyMemberArea"></div>
                    <div id="replyContentArea"></div>
                </div>
                <div class="modal-btn-area">
                    <button id="closeModalBtn" onclick="closeModal(event)">취소</button>
                    <a id="goToDetail">상세 페이지</a>
                </div>
            </div>
        </div>
    </div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/main.js"></script>
    <script>
        const loginMemberNo = "${loginMember.memberNo}";
        const reviewList = JSON.parse(`${reviewListJson}`);
    </script>
    <script src="/resources/js/business/reviewList.js"></script>
</body>
</html>