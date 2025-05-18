<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 이미지 리스트와 마지막 이미지의 imageLevel -->
<c:set var="imageList" value="${business.imageList}"/>
<c:set var="maxLevel" value="${imageList[fn:length(imageList)-1].imageLevel}"/>
<!-- 상품 등록할 시 하위 카테고리 영역을 숨기기 위한 hide 클래스 -->
<c:if test="${empty business}">
    <c:set var="hide" value="hide"/>
</c:if>
<!-- 배송비가 없을 경우 0, 있을 경우 해당 값 -->
<c:if test="${empty business.deliveryFee}">
    <c:set var="deliveryFee" value="0"/>
</c:if>
<c:if test="${!empty business.deliveryFee}">
    <c:set var="deliveryFee" value="${business.deliveryFee}"/>
</c:if>
<!-- 상품 등록인지 수정인지에 따라 form 태그의 url -->
<c:if test="${empty business}">
    <c:set var="url" value="insertProduct"/>
</c:if>
<c:if test="${!empty business}">
    <c:set var="url" value="${productNo}/update"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>브랜드 수정/등록 페이지</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <link rel="stylesheet" href="/resources/css/header,footer.css">
    <link rel="stylesheet" href="/resources/css/businessWrite-style.css">
    <link rel="stylesheet" href="/resources/css/manager-css/modal.css" />
    
    <script src="https://kit.fontawesome.com/f8edd1a12b.js" crossorigin="anonymous"></script>
</head>

<body>
    <!-- 헤더 영역 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <main>
        <!-- 상품 등록/수정 form, 파일 업로드 허용 -->
        <form action="/product/${url}" method="post" id="businessWriteForm" enctype="multipart/form-data">
            <section class="content">
                <section id="optionArea">
                    <div class="product-img">
                        <label>
                            <img class="preview" src="${imageList[0].imagePath}${imageList[0].imageReName}">
                            <input type="file" name="images" id="thumbnail" class="inputImage" accept="image/*">
                        </label>
                        <span class="x-btn">&times;</span>
                    </div>
                    <div class="option-detail-area">
                        <input type="text" class="product-title" name="productTitle" value="${business.productTitle}">
                        <table class="product-info-area border-top">
                            <tbody>
                                <tr>
                                    <td>카테고리</td>
                                    <td>
                                        <!-- 상위 카테고리 -->
                                        <select name="parentCategoryNo" id="parentCategory">
                                            <option value="default">카테고리를 선택해주세요.</option>
                                            <option disabled>--------------------------------------</option>
                                            <c:forEach var="category" items="${categoryList}">
                                                <c:choose>
                                                    <c:when test="${business.parentCategoryNo==category.categoryNo}">
                                                        <option value="${category.categoryNo}" selected>${category.categoryName}</option>
                                                    </c:when>
                                                    <c:when test="${category.parentCategoryNo==null}">
                                                        <option value="${category.categoryNo}">${category.categoryName}</option>
                                                    </c:when>
                                                </c:choose>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr id="childCategoryArea" class="${hide}">
                                    <td>카테고리 상세</td>
                                    <td>
                                        <!-- 하위 카테고리 -->
                                        <select name="categoryNo" id="childCategory">
                                            <c:forEach var="category" items="${categoryList}">
                                                <c:choose>
                                                    <c:when test="${business.categoryNo==category.categoryNo}">
                                                        <option value="${category.categoryNo}" selected>${category.categoryName}</option>
                                                    </c:when>
                                                    <c:when test="${category.parentCategoryNo==business.parentCategoryNo}">
                                                        <option value="${category.categoryNo}">${category.categoryName}</option>
                                                    </c:when>
                                                </c:choose>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <!-- 판매가, 배송비 입력란 -->
                                <tr>
                                    <td>판매가</td>
                                    <td><input type="text" name="productPrice" id="productPrice" value="${business.productPrice}"></td>
                                </tr>
                                <tr>
                                    <td>배송비</td>
                                    <td><input type="text" name="deliveryFee" id="deliveryFee" value="${deliveryFee}"></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="product-option-area border-top">
                            <span>옵션명</span>
                            <div class="option-input-area">
                                <div>
                                    <input type="hidden" name="optionNo" value="${business.optionList[0].optionNo}">
                                    <input type="text" name="optionName" class="optionName" 
                                    placeholder="옵션을 입력해 주세요" value="${business.optionList[0].optionName}">
                                    <span id="plusBtn">+</span>
                                </div>
                                <!-- 수정 시 기존 옵션 -->
                                <c:if test="${!empty business.optionList}">
                                    <c:forEach var="i" begin="1" end="${fn:length(business.optionList)-1}">
                                        <div>
                                            <input type="hidden" name="optionNo" value="${business.optionList[i].optionNo}">
                                            <input type="text" name="optionName" class="optionName" 
                                            placeholder="옵션을 입력해 주세요" value="${business.optionList[i].optionName}">
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                        <div class="stock-area border-top">
                            <span>재고</span>
                            <input type="text" name="productCount" id="productCount" value="${business.productCount}">
                        </div>
                    </div>
                </section>
                <section class="product-content border-top">
                    <nav class="content-nav" id="productImg">
                        <ul>
                            <li><a href="#productImg">상품사진선택</a></li>
                            |
                            <li><a href="#productDetail">상품상세정보</a></li>
                        </ul>
                    </nav>
                    <h3 id="addImageArea">상품 사진 추가</h3>
                    <div id="productImageArea">
                        <div class="product-img">
                            <label>
                                <img class="preview" src="${imageList[1].imagePath}${imageList[1].imageReName}">
                                <input type="file" name="images" class="inputImage" accept="image/*">
                            </label>
                            <span class="x-btn">&times;</span>
                        </div>
                        <!-- 수정 시 기존 이미지 -->
                        <c:if test="${!empty imageList}">
                            <c:forEach var="i" begin="2" end="${imageList[fn:length(imageList)-1].imageLevel}">
                                <c:set var="imageSrc" value=""/>
                                <c:forEach var="image" items="${imageList}">
                                    <c:if test="${image.imageLevel==i}">
                                        <c:set var="imageSrc" value="${image.imagePath}${image.imageReName}"/>
                                    </c:if>
                                </c:forEach>
                                <div class="product-img">
                                    <input type="hidden" name="imageNo" value="${imageList[i].imageNo}">
                                    <label>
                                        <img class="preview" src="${imageSrc}">
                                        <input type="file" name="images" class="inputImage" accept="image/*">
                                    </label>
                                    <span class="x-btn">&times;</span>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                </section>
                <section class="product-content border-top">
                    <nav class="content-nav" id="productDetail">
                        <ul>
                            <li><a href="#productImg">상품사진선택</a></li>
                            |
                            <li><a href="#productDetail">상품상세정보</a></li>
                        </ul>
                    </nav>
                    <textarea name="productContent" id="productContent">${business.productContent}</textarea>
                </section>
                <div class="btn-area">
                    <button type="button" onclick="history.back()" class="btn">취소하기</button>
                    <button class="btn">
                        <!-- 등록: business 객체 X -->
                        <c:if test="${empty business}">
                            등록하기
                        </c:if>
                        <!-- 수정: business 객체 O -->
                        <c:if test="${!empty business}">
                            수정하기
                        </c:if>
                    </button>
                </div>
            </section>

            <!-- 백엔드로 넘겨줄 숨겨진 데이터들 -->
            <input type="hidden" name="coalitionTitle" id="coalitionTitle">
            <input type="hidden" name="coalitionContent" id="coalitionContent">
            <input type="hidden" name="permissionFl" value="${permissionFl}">
            <input type="hidden" name="deleteList" id="deleteList">
        </form>
    </main>

    <!-- 제휴 신청을 위한 모달 -->
    <div id="modal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>제휴</h2>

            <div class="modalInner brandInner">
                <div class="modalTop">
                    <div class="modalReport">
                        <strong>제목:</strong>
                        <input type="text" id="modalTitle">
                    </div>
                    <div class="memberName">
                        <strong>회원명:</strong> ${loginMember.memberName} 
                    </div>
                </div>

                <div class="modalMid">
                    <div>내용</div>
                    <textarea class="customerText" id="modalContent"></textarea>
                </div>
                <div class="modal-btn barndBtn">
                    <button onclick="submitForm()">제휴신청</button>
                </div>
            </div>
        </div>
    </div>
        
    <!-- 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/main.js"></script>
    <script>
        // JS에서 사용하기 위한 전역 변수
        const categoryList = ${categoryListJson};
        const permissionFl = "${permissionFl}";
    </script>
    <script src="/resources/js/business/businessWrite.js"></script>
</body>
</html>