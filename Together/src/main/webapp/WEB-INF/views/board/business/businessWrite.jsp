<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <main>
        <form action="/board/${boardCode}/insertProduct" method="post" id="businessWriteForm" enctype="multipart/form-data">
            <section class="content">
                <section id="optionArea">
                    <div class="product-img">
                        <label>
                            <img class="preview" src="">
                            <input type="file" name="images" id="thumbnail" class="inputImage" accept="image/*">
                        </label>
                        <span class="x-btn">&times;</span>
                    </div>
                    <div class="option-detail-area">
                        <input type="text" class="product-title" name="boardTitle" value="">
                        <table class="product-info-area border-top">
                            <tbody>
                                <tr>
                                    <td>카테고리</td>
                                    <td>
                                        <select name="parentCategoryNo" id="parentCategory">
                                            <option value="default">카테고리를 선택해주세요.</option>
                                            <option disabled>--------------------------------------</option>
                                            <c:forEach var="category" items="${categoryList}">
                                                <c:if test="${category.parentCategoryNo eq null}">
                                                    <option value="${category.categoryNo}">${category.categoryName}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr id="childCategoryArea" class="hide">
                                    <td>카테고리 상세</td>
                                    <td>
                                        <select name="categoryNo" id="childCategory"></select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>판매가</td>
                                    <td><input type="text" name="productPrice" id="productPrice" value=""></td>
                                </tr>
                                <tr>
                                    <td>배송비</td>
                                    <td><input type="text" name="deliveryFee" id="deliveryFee" value="0"></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="product-option-area border-top">
                            <span>옵션명</span>
                            <div class="option-input-area">
                                <div>
                                    <input type="text" name="optionName" class="optionName" placeholder="옵션을 입력해 주세요">
                                    <span id="plusBtn">+</span>
                                </div>
                            </div>
                        </div>
                        <div class="stock-area border-top">
                            <span>재고</span>
                            <input type="text" name="productCount" id="productCount" value="">
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
                                <img class="preview" src="">
                                <input type="file" name="images" class="inputImage" accept="image/*">
                            </label>
                            <span class="x-btn">&times;</span>
                        </div>
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
                    <textarea name="boardContent" id="boardContent"></textarea>
                </section>
                <div class="btn-area">
                    <button type="button" onclick="history.back()" class="btn">취소하기</button>
                    <button class="btn">등록하기</button>
                </div>
            </section>

            <input type="hidden" name="coalitionTitle" id="coalitionTitle">
            <input type="hidden" name="coalitionContent" id="coalitionContent">
            <input type="hidden" name="permissionFl" value="${permissionFl}">
        </form>
    </main>

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
        
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/main.js"></script>
    <script>
        const boardCode = "${boardCode}";
        const categoryList = ${categoryListJson};
        const permissionFl = "${permissionFl}";
    </script>
    <script src="/resources/js/business/businessWrite.js"></script>
</body>
</html>