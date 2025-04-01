<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>RecentPurchase</title>
<link rel="stylesheet" href="/resources/css/my_info/RecentPurchase.css">
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
                <section class="recent-purchases-section" id="recent-purchases-section">
                    <h2 class="recent-purchase-title">최근 구매 상품</h2>
                    <div class="recent-purchase-container" id="recent-purchase-container">
                    </div>
                </section>
            </section>
        </div>
    </main>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="/resources/js/member/mypages.js"></script>
</html>