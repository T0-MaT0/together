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
    <title>브랜드 상세 페이지</title>

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
            <section id="optionArea">
                <div class="product-img">
                    <img src="${business.imageList[0].imagePath}${business.imageList[0].imageReName}">
                </div>
                <div class="option-detail-area">
                    <span class="product-title">${business.boardTitle}</span>
                    <table class="product-info-area border-top">
                        <tbody>
                            <tr>
                                <td>브랜드</td>
                                <td>${business.memberNickname}</td>
                            </tr>
                            <tr>
                                <td>판매가</td>
                                <td>
                                    <fmt:formatNumber value="${business.productPrice}" type="number" maxFractionDigits="0"/> 원
                                </td>
                            </tr>
                            <tr>
                                <td>배송비</td>
                                <td>
                                    <c:if test="${business.deliveryFee==0}">
                                        무료
                                    </c:if>
                                    <c:if test="${business.deliveryFee!=0}">
                                        <fmt:formatNumber value="${business.deliveryFee}" type="number" maxFractionDigits="0"/> 원
                                    </c:if>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="product-option-area border-top">
                        <span>상품 옵션</span>
                        <select class="product-option">
                            <option value="default">-[필수] 옵션을 선택해 주세요</option>
                            <option disabled>--------------------------------------</option>
                            <c:forEach var="option" items="${business.optionList}">
                                <option value="${option.optionNo}-${option.optionName}">${option.optionName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="stock-area border-top">
                        <span>재고</span>
                        <span>${business.productCount}개</span>
                    </div>
                    <table class="choice-option border-top">
                        <tbody class="choice-option-area"></tbody>
                    </table>
                    <div class="total-area border-top">
                        <div class="price-area">
                            TOTAL: <span class="total-price-area">0</span>원
                            (<span class="total-count-area">0</span>개)
                        </div>
                        <div class="buy-area">
                            <c:if test="${loginMember.authority!=1&&loginMember.memberNo!=business.memberNo}">
                                <c:if test="${empty pickCheck}">
                                    <i class="fa-regular fa-heart" id="pickProduct"></i>
                                </c:if>
                                
                                <c:if test="${!empty pickCheck}">
                                    <i class="fa-solid fa-heart" id="pickProduct"></i>
                                </c:if>
                                <button class="go-to-buy">혼자 구매</button>
                                <button>공동 구매</button>
                            </c:if>
                            <c:if test="${loginMember.memberNo==business.memberNo}">
                                <i></i>
                                <button id="updateBusiness">수정</button>
                                <button id="deleteBusiness">삭제</button>
                            </c:if>
                            <c:if test="${loginMember.authority==1}">
                                <button id="deleteBusiness">삭제</button>
                            </c:if>
                        </div>
                        
                        <div>
                            <a href="javascript:void(0);" onclick="openReportModal(1, ${business.boardNo}, ${business.memberNo}, '${loginMember.memberNick}')">REPORT</a>
                            <a href="#review">REVIEW <span>0</span></a>
                            <a href="#q&a">Q & A <span>0</span></a>
                        </div>
                    </div>
                </div>
            </section>
            <section class="product-content border-top">
                <nav class="content-nav" id="detail">
                    <ul>
                        <li><a href="#detail">상품상세정보</a></li>
                        |
                        <li><a href="#guide">구매가이드</a></li>
                        |
                        <li><a href="#review">구매후기 <span>0</span></a></li>
                        |
                        <li><a href="#q&a">상품문의 <span>0</span></a></li>
                    </ul>
                </nav>
                <div class="product-img">
                    <c:choose>
                        <c:when test="${fn:length(business.imageList)==1}">
                            <img src="${business.imageList[0].imagePath}${business.imageList[0].imageReName}">
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="image" items="${business.imageList}">
                                <c:if test="${image.imageLevel!=0}">
                                    <img src="${image.imagePath}${image.imageReName}">
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div>${business.boardContent}</div>
            </section>
            <section class="product-content border-top">
                <nav class="content-nav" id="guide">
                    <ul>
                        <li><a href="#detail">상품상세정보</a></li>
                        |
                        <li><a href="#guide">구매가이드</a></li>
                        |
                        <li><a href="#review">구매후기 <span>0</span></a></li>
                        |
                        <li><a href="#q&a">상품문의 <span>0</span></a></li>
                    </ul>
                </nav>
                <div class="buy-guide-area">
                    <h3>상품 결제정보</h3>
                    <pre class="border-top">
고액 결제의 경우 안전을 위해 카드사에서 확인 전화를 드릴 수도 있습니다. 확인 과정에서 도난 카드의 사용이나 타인 명의의 주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다. 
                    
무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다. 
주문시 입력한 입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며 입금되지 않은 주문은 자동취소 됩니다.
                    </pre>

                    <h3>배송안내</h3>
                    <pre class="border-top">
- 산간벽지나 도서지방은 별도의 추가금액을 지불하셔야 하는 경우가 있습니다. 
고객님께서 주문하신 상품은 입금 확인후 배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.
                    </pre>

                    <h3>교환 및 반품안내</h3>
                    <pre class="border-top">
교환 및 반품이 가능한 경우
- 상품을 공급 받으신 날로부터 7일이내
단, 상품가치가 상실된 경우에는 교환/반품이 불가능합니다.

교환 및 반품이 불가능한 경우
- 고객님의 책임 있는 사유로 상품등이 멸실 또는 훼손된 경우. 단, 상품의 내용을 확인하기 위하여 포장 등을 훼손한 경우는 제외
- 포장을 개봉하였거나 포장이 훼손되어 상품가치가 상실된 경우

- 고객님의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우
- 시간의 경과에 의하여 재판매가 곤란할 정도로 상품등의 가치가 현저히 감소한 경우

※ 고객님의 마음이 바뀌어 교환, 반품을 하실 경우 상품반송 비용은 고객님께서 부담하셔야 합니다.(색상 교환, 사이즈 교환 등 포함)
                    </pre>
                </div>
            </section>
            <section class="product-content border-top">
                <nav class="content-nav" id="review">
                    <ul>
                        <li><a href="#detail">상품상세정보</a></li>
                        |
                        <li><a href="#guide">구매가이드</a></li>
                        |
                        <li><a href="#review">구매후기 <span>0</span></a></li>
                        |
                        <li><a href="#q&a">상품문의 <span>0</span></a></li>
                    </ul>
                </nav>
                <div class="list-area review-area">
                    <h3>REVIEW</h3>
                    <table>
                        <colgroup>
                            <col style="width: 10%;"> <!-- 첫 번째 열 (번호) -->
                            <col style="width: 20%;"> <!-- 두 번째 열 (이미지) -->
                            <col style="width: auto;"> <!-- 세 번째 열 (상품 제목) → 자동 크기 -->
                            <col style="width: 15%;"> <!-- 네 번째 열 (작성자) -->
                            <col style="width: 15%;"> <!-- 다섯 번째 열 (작성일) -->
                        </colgroup>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>상품 이미지</th>
                                <th>상품 제목</th>
                                <th>작성자</th>
                                <th>작성일</th>
                            </tr>
                        </thead>
                        <tbody id="reviewListArea"></tbody>
                    </table>
                    <div class="btn-area">
                        <c:if test="${!empty loginMember and business.memberNo!=loginMember.memberNo}">
                            <button onclick="openPopup('view')">리뷰작성</button>
                        </c:if>
                        <a href="/board/2/reviewList">모두보기</a>
                    </div>
                    <div class="pagination-area">
                        <ul class="pagination" id="reviewPaginationArea"></ul>
                    </div>
                </div>
            </section>
            <section class="product-content border-top">
                <nav class="content-nav" id="q&a">
                    <ul>
                        <li><a href="#detail">상품상세정보</a></li>
                        |
                        <li><a href="#guide">구매가이드</a></li>
                        |
                        <li><a href="#review">구매후기 <span>0</span></a></li>
                        |
                        <li><a href="#q&a">상품문의 <span>0</span></a></li>
                    </ul>
                </nav>
                <div class="list-area">
                    <h3>Q & A</h3>
                    <div>
                        <span>주문, 반품, 교환, 배송, 입금, 기타 등 모든 궁금한 사항을 남겨 주세요~</span>
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
                            <colgroup>
                                <col style="width: 10%;"> <!-- 첫 번째 열 (번호) -->
                                <col style="width: 20%;"> <!-- 두 번째 열 (이미지) -->
                                <col style="width: auto;"> <!-- 세 번째 열 (상품 제목) → 자동 크기 -->
                                <col style="width: 15%;"> <!-- 네 번째 열 (작성자) -->
                                <col style="width: 15%;"> <!-- 다섯 번째 열 (작성일) -->
                            </colgroup>
                            <tr>
                                <th>번호</th>
                                <th>상품 이미지</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성일</th>
                            </tr>
                        </thead>
                        <tbody id="replyListArea"></tbody>
                    </table>
                    <div class="btn-area">
                        <c:if test="${!empty loginMember and business.memberNo!=loginMember.memberNo}">
                            <button onclick="openPopup('ply')">문의작성</button>
                        </c:if>
                        <a href="/board/2/replyList">모두보기</a>
                    </div>
                    <div class="pagination-area">
                        <ul class="pagination" id="replyPaginationArea"></ul>
                    </div>
                </div>
            </section>
        </section>
    </main>
        
    <section class="fixed-option-bar">
        <section class="fixed-option-area">
            <div class="product-option-area">
                <span>상품 옵션</span>
                <select class="product-option">
                    <option value="default">-[필수] 옵션을 선택해 주세요</option>
                    <option disabled>--------------------------------------</option>
                    <c:forEach var="option" items="${business.optionList}">
                        <option value="${option.optionNo}-${option.optionName}">${option.optionName}</option>
                    </c:forEach>
                </select>
            </div>
            <table class="choice-option">
                <tbody class="choice-option-area"></tbody>
            </table>
            <div class="total-area">
                <div class="price-area">
                    TOTAL: <span class="total-price-area">0</span>원
                    (<span class="total-count-area">0</span>개)
                </div>
                <div class="buy-area">
                    <i class="fa-regular fa-heart"></i>
                    <i class="fa-solid fa-cart-shopping"></i>
                    <button class="go-to-buy">혼자 구매</button>
                    <button>공동 구매</button>
                </div>
            </div>
        </section>
        <span class="fixed-option-btn" onclick="changeOptionBar(this)">옵션보기></span>
    </section>

    <div class="modal hide">
        <div id="modalContent">
            <div class="modal-img-area"></div>
            <div class="modal-detail-area">
                <div class="rating-area"></div>
                <div class="user-area"></div>
                <div class="review-option-area"></div>
                <div class="review-content"></div>
                <div class="reply-area">
                    <div id="replyMemberArea"></div>
                    <div id="replyContentArea"></div>
                </div>
                <div class="modal-btn-area">
                    <button id="closeModalBtn" onclick="closeModal(event)">취소</button>
                    <a href="/board/2/reviewList">리뷰목록</a>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/board/business/reportModal.jsp"/>

    

    <c:if test="${not empty loginMember}">
        <script>
            loginMember = {
            memberNo: ${loginMember.memberNo},
            nickname: "${loginMember.memberNick}"
            };
        </script>
    </c:if>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/main.js"></script>
    <script>
        const boardCode = "${boardCode}";
        const boardNo = "${boardNo}";
        const boardMemberNo = "${business.memberNo}";
        const productPrice = Number("${business.productPrice}");
        const deliveryFee = Number("${business.deliveryFee}");
        const thumbnail = "${thumbnail}";
    </script>
    <script src="/resources/js/business/businessDetail.js"></script>
    
</body>
</html>