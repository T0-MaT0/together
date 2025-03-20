<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>my_info_home</title>
<link rel="stylesheet" href="/resources/css/my_info/my_info_home.css">
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
				<!-- 프로필 섹션 -->
          <h2 class="home-title">내 정보</h2>
				<section class="profile-section">
					<div class="profile-card">
            <c:if test="${empty loginMember.profileImg}">
              <c:if test="${loginMember.authority == 2}">
              <img src="/resources/images/mypage/common/user.png" alt="프로필 이미지" class="profile-img">
              </c:if>
              <c:if test="${loginMember.authority == 3}">
              <img src="/resources/images/mypage/common/Seller.png" alt="프로필 이미지" class="profile-img">
              </c:if>
            </c:if>
            <c:if test="${not empty loginMember.profileImg}">
              <img src="${loginMember.profileImg}" alt="프로필 이미지" class="profile-img">
            </c:if>

						<div class="profile-info">
							<p>
								<strong>등급 :</strong> ${loginMember.memberGrade}등급
							</p>
							<p>
								<strong>${loginMember.memberNick}</strong>
							</p>
              <c:set var="addrs" value="${loginMember.memberAddr}" />
              <c:set var="addrArr" value="${fn:split(addrs, '^^^')}" />
			  <p>내 지역 : ${addrArr[1]}</p>
              <p class="points">포인트 : ${loginMember.point}pt</p>
						</div>
						<button class="edit-btn">설정</button>
					</div>
				</section>
				<!-- 상단 바 -->
				<div class="top-bar2">
					<div class="top-menu">
						<div class="menu-item">
							<img src="/resources/images/mypage/common/주문배송.png" alt="주문 배송">
							<p>주문 배송</p>
							<span>0</span>
						</div>
						<div class="menu-item">
							<img src="/resources/images/mypage/common/장바구니.png" alt="장바구니">
							<p>장바구니</p>
							<span>0</span>
						</div>
					</div>
					<div class="bottom-menu">
						<div class="menu-item" id="interest-store">
							<img src="/resources/images/mypage/common/관심스토어.png" alt="관심스토어">
							<p>관심스토어</p>
						</div>
						<div class="menu-item">
							<img src="/resources/images/mypage/common/찜한상품.png" alt="찜한상품">
							<p>찜한상품</p>
						</div>
						<div class="menu-item">
							<img src="/resources/images/mypage/common/최근본상품.png" alt="최근 본 상품">
							<p>최근 본 상품</p>
						</div>
						<div class="menu-item">
							<img src="/resources/images/mypage/common/QnA.png" alt="최근 본 상품">
							<p class="bold-text">Q&A</p>
						</div>
					</div>
				</div>


				<!-- 추천 상품 캐러셀 -->
				<section class="recommendation-section">
					<h3>
						마음에 드는 <span class="highlight">상품</span>을 주문해 보세요!
					</h3>

					<!-- 카테고리 필터 -->
					<div class="category-filter" id="category-filter">
					</div>

					<div class="carousel-container">

						<div class="carousel" id="carousel">
						</div>

					</div>
				</section>

				<!-- 구매 이력 -->
				<section class="purchase-history" id="purchase-history">
					<h3>구매 이력</h3>
					<div class="purchase-item" id="purchase-item">
					</div>
				</section>

				<!-- 관심 스토어 -->
				<section class="interest-store">
					<h3>관심 스토어</h3>
					<div class="store-list">
						<div class="store-circle">
							<img src="브랜드1.png" alt="기업1">
							<p class="store-name">기업명1</p>
						</div>
						<div class="store-circle">
							<img src="브랜드2.png" alt="기업2">
							<p class="store-name">기업명2</p>
						</div>
						<div class="store-circle">
							<img src="브랜드2.png" alt="기업3">
							<p class="store-name">기업명3</p>
						</div>
					</div>
				</section>

				<!-- 찜한 상품 -->
				<section class="wishlist-area" id="wishlist-area">
				</section>
			</section>
		</div>
	</main>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>
<%-- 전역변수로 값 넘기기 --%>
  const memberNo = "${loginMember.memberNo}";
</script>
<script src="/resources/js/member/mypage.js"></script>
</html>