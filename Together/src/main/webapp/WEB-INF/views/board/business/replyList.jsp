<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="replyList" value="${map.replyList}"/>
<c:set var="pagination" value="${map.replyPagination}"/>

<c:set var="url" value="/board/${boardCode}/replyList?replyCp="/>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>브랜드 Q&A 목록 페이지</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css/businessDetail-style.css">
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <main>
        <section class="content">
            <div class="list-area">
                <h3>Q&A</h3>
                <div>
                    <span>주문, 반품, 교환, 배송, 입금, 기타 등 모든 궁금한 사항들의 목록입니다.</span>
                    <div>
                        <label>
                            <input type="checkbox" id="myQNA">
                            내 Q&A 보기
                        </label>
                        |
                        <label>
                            <input type="checkbox" id="notSecret">
                            비밀글 제외
                        </label>
                    </div>
                </div>
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
                    <tbody id="replyListArea">
                        <c:if test="${empty replyList}">
                            <tr>
                                <th colspan="5">Q&A가 없습니다.</th>
                            </tr>
                        </c:if>

                        <c:if test="${!empty replyList}">
                            <c:forEach var="reply" items="${replyList}">
                                <c:set var="comment" value="${reply.commentList[0]}"/>
                                <tr class="replyRow" reply-no="${reply.replyNo}">
                                    <td>${reply.replyNo}</td>
                                    <td>
                                        <img class="list-thumbnail" src="${reply.thumbnail}">
                                    </td>
                                    <td class="show-comment-area" reply-no="${reply.replyNo}">
                                        <div class="text-box">
                                            <c:if test="${reply.secretReplyStatus=='N'}">
                                                ${reply.replyContent}
                                            </c:if>
                                            <c:if test="${reply.secretReplyStatus=='Y'}">
                                                <c:if test="${empty loginMember}">
                                                    비밀글 입니다.🔒
                                                </c:if>
                                                <c:if test="${loginMember.memberNo==reply.memberNo}">
                                                    ${reply.replyContent}🔒
                                                </c:if>
                                            </c:if>
                                        </div>
                                    </td>
                                    <td>${reply.memberNickname}</td>
                                    <td class="date-area" data-date="${reply.replyCreatedDate}"></td>
                                </tr>
                                <tr class="current-detail">
                                    <td colspan="5">${reply.replyContent}</td>
                                </tr>
                                <c:if test="${!empty comment}">
                                    <tr class="current-detail">
                                        <td colspan="3">${comment.replyContent}</td>
                                        <td>${comment.memberNickname}</td>
                                        <td class="comment-area" data-comment="${comment.replyCreatedDate}"></td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </tbody>
                </table>
                <div class="pagination-area">
                    <c:if test="${pagination.maxPage>1}">
                        <ul class="pagination" id="replyPaginationArea">
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
    
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/main.js"></script>
    <script>
        const loginMemberNo = "${loginMember.memberNo}";
    </script>
    <script src="/resources/js/business/replyList.js"></script>
</body>
</html>