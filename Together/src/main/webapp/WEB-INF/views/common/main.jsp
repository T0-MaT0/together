<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인화면</title>
    
    <link rel="stylesheet" href="/resources/css/site-main-style.css">
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

    ${loginMember}
    

    
    <section class="hero">
        <div class="banner carousel">
            <c:forEach var="banner" items="${recruitmentList[0].mainBannerList}">
                <img src="${banner.imagePath}${banner.imageReName}" alt="메인 배너" class="carousel-image">
            </c:forEach>
            <!-- 좌우 버튼 추가 -->
            <button class="carousel-button prev">&#10094;</button>
            <button class="carousel-button next">&#10095;</button>
        </div>
    </section>
    
    
    <section class="purchase-section">
        <h2 class="main-product-title">😺개인 공동구매에 참여해보세요😺</h2>
        <div class="product-list">
            <c:forEach var="recruitment" items="${recruitmentList}" begin="${i}" end="${i+4}" varStatus="status">
                
                <c:set var="progress" value="${(recruitment.currentParticipants * 100.0) / recruitment.maxParticipants}" />
                <c:set var="discount" value="${Math.ceil(recruitment.productPrice / recruitment.maxParticipants).intValue()}" />
                <c:set var="formattedProgress">
                    <fmt:formatNumber value="${progress}" type="number" maxFractionDigits="1" />
                </c:set>
                
                <div class="product">
                    <img src="${recruitment.thumbnail != null ? recruitment.thumbnail : '/resources/images/mypage/관리자 프로필.webp'}" alt="공구 세트">
                    <p class="product-name">${recruitment.productName}</p>
                    <span class="prior-price">${recruitment.productPrice}원</span>
                    <span class="real-price"> → ${discount}</span>
    
                    <p class="deadline">⏳ ${time}</p>
                    <div class="progress">
                        <div class="progress-container">
                            <div class="progress-bar"></div>
                        </div>
                        <p class="progress-percent">${formattedProgress}%</p>
                    </div>
                    <p class="participants">${recruitment.currentParticipants} / ${recruitment.maxParticipants}명 참여 중</p>
                </div>
            </c:forEach>
        </div>
    </section>
    
    <section class="process-section">
        <h3 class="main-title">이용 프로세스</h3>
        <h2 class="sub-title">공동구매를 쉽고 빠르게 경험해 보세요.</h2>
      
        <div class="process-wrapper">
          <!-- 텍스트들만 스크롤 -->
          <div class="text-scroll-sections">
            <div class="info-text" data-img="/resources/images/mainJHI/main1.png">
              <p>🎉 혼자 사지 마세요! 함께 사면 더 저렴해져요! 🎉</p>
              <p>⚡ 3초 만에 공동구매 시작! 누구나 쉽게 가능! ⚡</p>
              <p>🔍 좋은 제품 발견? 친구들과 공동구매 GO! 📢</p>
            </div>
            <div class="info-text" data-img="/resources/images/mainJHI/main2.png">
              <p>💰 사업자님, 공동구매로 매출 UP! 📈</p>
              <p>✨ 수수료 0원! 부담 없이 판매 시작! ✨</p>
              <p>📢 광고비 없이 빠르게 고객 확보! 💞</p>
              <p>🏆 지금 <b>1,000개</b> 이상의 사업자가 함께하고 있어요! 🙌</p>
            </div>
            <div class="info-text" data-img="/resources/images/mainJHI/main3.png">
              <p>📦 개인도! 사업자도! 누구나 공동구매 가능! 🛍️</p>
              <p>🤔 이렇게 쉬운데, 아직도 안 해보셨나요? 😆</p>
              <p>💡 더 싸게 사고, 더 많이 팔고 싶다면? 지금 가입하세요! 💥</p>
              <a class="start-button" href="/member/login">공동구매 시작하기</a>
            </div>
          </div>
      
          <!-- 오른쪽 고정 이미지 -->
          <div class="fixed-image">
            <img id="process-image" src="/resources/images/mainJHI/main1.png" alt="공동구매 이미지" />
          </div>
        </div>
      </section>

    <c:set var="url" value="/board/2/"/>
    <section class="hot-products">
        <h2 class="main-product-title">🔥HOT🔥한 상품들</h2>
        <div class="hot-product-list">
            <a class="hot-product main-product" href="${url}${map.businessHotList[0].boardNo}">
                <span class="hot-rank">1</span>
                <img src="${map.businessHotList[0].thumbnail}" alt="상품 이미지">
                <p class="product-name">${map.businessHotList[0].boardTitle}</p>
                <p class="price">${map.businessHotList[0].productPrice}원</p>
            </a>

    
            <div class="hot-product-group">

                <c:forEach var="hotList" items="${map.businessHotList}" begin="${i+1}" end="${i+6}" varStatus="status">
                    <a class="hot-product" href="${url}${hotList.boardNo}">
                        <img src="${hotList.thumbnail}" alt="상품 이미지">
                        <p class="product-name">${hotList.boardTitle}</p>
                        <p class="price">${hotList.productPrice}원</p>
                    </a>
                
                </c:forEach>
            </div>
        </div>
    </section>
    
    
    
    <section class="new-products">
        <h2 class="main-product-title">🆕새로 올라온 상품들🆕</h2>
        <div class="new-product-list">
            <c:forEach var="newList" items="${map.businessNewList}" begin="${i}" end="${i+4}" varStatus="status">

                    <a class="new-product" href="${url}${newList.boardNo}">
                        <img src="${newList.thumbnail}" alt="상품 이미지">
                        <p class="product-name">${newList.boardTitle}</p>
                        <p class="price">${newList.productPrice}원</p>
                    </a>

            </c:forEach>
            
        </div>
    </section>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <script src="/resources/js/main.js"></script>


      

</body>

</html>