<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="/resources/css/my_info/mypage-sidebar.css">
    
<div class="mypage-sidebar">
	<ul>
    <div class="main-item home"><a href="home">마이 홈</a></div>
    <div class="main-item section-title wishlist recentPurchase"><a href="wishlist">상품</a>
      <div class="sub-item wishlist"><a href="wishlist">찜한 상품</a></div>
      <div class="sub-item recentPurchase"><a href="recentPurchase">최근 구매 상품</a></div>
    </div>
    <div class="main-item section-title writableReview writtenReview"><a href="writableReview">리뷰 작성</a>
      <div class="sub-item writableReview"><a href="writableReview">작성 가능한 리뷰</a></div>
      <div class="sub-item writtenReview"><a href="writtenReview">내가 작성한 리뷰</a></div>
    </div>
    <div class="main-item section-title favoriteStore"><a href="favoriteStore">관심스토어</a></div>
    <div class="main-item qna QnA"><a href="QnA">Q&A</a></div>
    <div class="main-item qna ask"><a href="ask">1:1 문의</a></div>
	</ul>
</div>


<script src="/resources/js/member/mypage-sidebar.js"></script>
<script>
<%-- 전역변수로 값 넘기기 --%>
  const memberNo = "${loginMember.memberNo}";
</script>