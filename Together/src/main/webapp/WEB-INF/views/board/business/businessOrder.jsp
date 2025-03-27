<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="option" value="${fn:split(param.option, '-')}"/>

<c:set var="thumbnail" value="${business.imageList[0].imagePath}${business.imageList[0].imageReName}"/>
<c:set var="price" value="${business.productPrice * param.quantity}"/>
<c:set var="totalPrice" value="${price + business.deliveryFee}"/>
<c:set var="sumPrice" value="${loginMember.point-totalPrice}"/>

<c:choose>
    <c:when test="${sumPrice>=0}">
        <c:set var="resultClassName" value="violet-color"/>
    </c:when>
    <c:otherwise>
        <c:set var="resultClassName" value="minus"/>
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>브랜드 상품 주문</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <link rel="stylesheet" href="/resources/css/businessOrder-style.css">
    
    <script src="https://kit.fontawesome.com/f8edd1a12b.js" crossorigin="anonymous"></script>
</head>

<body>
	<section class="order-header">
        <div class="header-up">
            <a href="/">
                <img src="/resources/images/business/logo.png">
            </a>
            <span>To 브랜드</span>
            <a href="/mypage/home">
                <c:choose>
                    <c:when test="${empty loginMember.profileImg}">
                        <i class="fa-regular fa-user"></i>
                    </c:when>
                    <c:otherwise>
                        <img src="${loginMember.profileImg}">
                    </c:otherwise>
                </c:choose>
            </a>
        </div>
        <div class="header-down">
            <span onclick="goToBuy()">주문/결제</span>
        </div>
    </section>

    <main>
        <section class="content">
            <div class="content-left">
                <div class="address-area">
                    <div class="title-area">
                        <h3>배송지</h3>
                        <button class="btn" id="myAddr">내 주소</button>
                    </div>
                    <form id="orderForm" method="post" action="/board/2/${boardNo}/order">
                        <div class="content-row">
                            <input type="text" name="postCode" placeholder="우편번호" maxlength="6" id="sample6_postcode">
                            <button class="btn" type="button" onclick="sample6_execDaumPostcode()">주소검색</button>
                        </div>
                        <div class="content-row">
                            <input type="text" name="roadAddress" placeholder="도로명/지번 주소" id="sample6_address">
                        </div>
                        <div class="content-row">
                            <input type="text" name="detailAddress" placeholder="상세 주소" id="sample6_detailAddress">
                        </div>
                        <input type="hidden" name="optionNo" value="${option[0]}">
                        <input type="hidden" name="quantity" value="${param.quantity}">
                        <input type="hidden" name="totalPrice" value="${totalPrice}">
                        <input type="hidden" name="memberNo" value="${loginMember.memberNo}">
                    </form>
                </div>
                <div>
                    <div class="title-area">
                        <h3>주문 상품</h3>
                    </div>
                    <div class="content-row">
                        <span>${business.boardTitle}</span>
                        <img src="${thumbnail}">
                    </div>
                    <div class="content-row">
                        <div>
                            <span class="violet-color">옵션</span> 
                            <span>${option[1]}-${param.quantity}개</span>
                        </div>
                        <span>
                            <fmt:formatNumber value="${price}" type="number" maxFractionDigits="0"/> 원
                        </span>
                    </div>
                    <div class="content-row">
                        <div>
                            <span class="violet-color">배송비</span> 
                            <span></span>
                        </div>
                        <span>
                            <c:if test="${business.deliveryFee==0}">
                                무료
                            </c:if>
                            <c:if test="${business.deliveryFee!=0}">
                                <fmt:formatNumber value="${business.deliveryFee}" type="number" maxFractionDigits="0"/> 원
                            </c:if>
                        </span>
                    </div>
                    <div class="content-row">
                        <span class="violet-color">합계</span> 
                        <span>
                            <fmt:formatNumber value="${totalPrice}" type="number" maxFractionDigits="0"/> 원
                        </span>
                    </div>
                </div>
                <div>
                    <div class="title-area">
                        <div>
                            <img src="/resources/images/business/logo.png">
                            <span>머니</span>
                        </div>
                        <button class="btn">충전하기</button>
                    </div>
                    <div class="content-row">
                        <span>현재 포인트</span>
                        <span class="violet-color">
                            <fmt:formatNumber value="${loginMember.point}" type="number" maxFractionDigits="0"/> 원
                        </span>
                    </div>
                    <div class="content-row">
                        <span class="violet-color">총 주문금액</span>
                        <span>
                            <fmt:formatNumber value="${totalPrice}" type="number" maxFractionDigits="0"/> 원
                        </span>
                    </div>
                    <div class="content-row">
                        <span class="violet-color">합계</span>
                        <span class="${resultClassName}">
                            <fmt:formatNumber value="${sumPrice}" type="number" maxFractionDigits="0"/> 원
                        </span>
                    </div>
                </div>
            </div>
            <div class="content-right">
                <span>결제 예상 금액</span>
                <span class="${resultClassName}" id="resultPrice">
                    <fmt:formatNumber value="${totalPrice}" type="number" maxFractionDigits="0"/> 원
                </span>
                <button onclick="goToBuy()">포인트로 결제하기</button>
            </div>
        </section>
    </main>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function sample6_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('sample6_postcode').value = data.zonecode;
                    document.getElementById("sample6_address").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("sample6_detailAddress").focus();
                }
            }).open();
        }

        const memberAddr="${loginMember.memberAddr}".split("^^^ ");
    </script>
    <script src="/resources/js/business/order.js"></script>
</body>
</html>