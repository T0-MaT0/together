<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Wishlist</title>
<link rel="stylesheet" href="/resources/css/my_info/Wishlist.css">
<link rel="stylesheet" href="/resources/css/my_info/mypage.css">

</head>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<body>

	<main class="myinfo-container">

		<!-- 사이드바 -->
    <jsp:include page="/WEB-INF/views/member/mypage/mypage-sidebar.jsp" />


		<div class="myinfo-content-wrapper">
            <!-- 메인 콘텐츠 -->
            <section class="myinfo-main-content">
                <section class="wishlist-section" id="wishlist-section">
                
                    <h2>찜한 상품</h2>
                    <div class="wishlist-container">
                        <div class="wishlist-tabs" id="wishlist-tabs">
                        </div>
                        <div class="wishlist-summary" id="wishlist-summary">전체 3</div>
                    </div>
                
                    <div class="wishlist-items" id="wishlist-items">
                    </div>
                </section>
            </section>
        </div>
    </main>


</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="/resources/js/member/mypages.js"></script>
</html>