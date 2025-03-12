<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>my_info_home</title>
    <link rel="stylesheet" href="/resources/css/my_info/my_info_home.css">

</head>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
<body>

    <main class="myinfo-container">

    ${loginMember}
        

        <!-- 프로필 섹션 -->
        <section class="profile-section">
            <div class="profile-card">
                <img src="/resources/images/mypage/together.png" alt="프로필 이미지" class="profile-img">
                <div class="profile-info">
                    <p><strong>등급 :</strong> ${loginMember.memberGrade}등급</p>
                    <p><strong>${loginMember.memberNick}</strong></p>
                    <p>내 지역 : ${loginMember.memberAddr}</p>
                    <p class="points">포인트 : ${loginMember.point}원</p>
                </div>
                <button class="edit-btn">설정</button>
            </div>
        </section>

        <div class="myinfo-content-wrapper">
            <!-- 사이드바 -->
            <aside class="sidebar">
                <ul>
                    <li class="home">마이 홈</li>
                    <li class="section-title">주문/모집</li>
                    <li class="section-title">관심 상품</li>
                    <li class="sub-item">찜한 상품</li>
                    <li class="sub-item">최근 구매 상품</li>
                    <li class="section-title">리뷰 작성</li>
                    <li class="sub-item">작성 가능한 리뷰</li>
                    <li class="sub-item">내가 작성한 리뷰</li>
                    <li class="section-title">관심스토어</li>
                    <li class="qna">Q&A</li>
                </ul>
            </aside>

           <!-- 메인 콘텐츠 -->
            <section class="myinfo-main-content">
               <!-- 상단 바 -->
                <div class="top-bar2">
                    <div class="top-menu">
                        <div class="menu-item">
                            <img src="주문배송.png" alt="주문 배송">
                            <p>주문 배송</p>
                            <span>0</span>
                        </div>
                        <div class="menu-item">
                            <img src="장바구니.png" alt="장바구니">
                            <p>장바구니</p>
                            <span>0</span>
                        </div>
                    </div>
                    <div class="bottom-menu">
                        <div class="menu-item" id="interest-store">
                            <img src="관심스토어.png" alt="관심스토어">
                            <p>관심스토어</p>
                        </div>
                        <div class="menu-item">
                            <img src="찜한상품.png" alt="찜한상품">
                            <p>찜한상품</p>
                        </div>
                        <div class="menu-item">
                            <img src="최근본상품.png" alt="최근 본 상품">
                            <p>최근 본 상품</p>
                        </div>
                        <div class="menu-item">
                            <img src="QnA.png" alt="최근 본 상품">
                            <p class="bold-text">Q&A</p>
                        </div>
                    </div>
                </div>


                <!-- 추천 상품 캐러셀 -->
                <section class="recommendation-section">
                    <h3>마음에 드는 <span class="highlight">상품</span>을 주문해 보세요!</h3>
                    
                    <!-- 카테고리 필터 -->
                    <div class="category-filter">
                        <button class="selected">에어포스1카카오</button>
                        <button>게이밍무선마우스</button>
                        <button>닭양념육</button>
                        <button>제첵</button>
                        <button>풋살화</button>
                        <button>사무용의자</button>
                    </div>

                    <div class="carousel-container">
                        <button class="carousel-btn left-btn">&lt;</button>
                        
                        <div class="carousel">
                            <div class="carousel-item">
                                <img src="상품1.png" alt="상품1">
                                <p class="product-name">국내매장품 나이키...</p>
                                <p class="product-price">195,000원</p>
                            </div>
                            <div class="carousel-item">
                                <img src="상품2.png" alt="상품2">
                                <p class="product-name">나이키 에어포스1...</p>
                                <p class="product-price">183,000원</p>
                            </div>
                            <div class="carousel-item">
                                <img src="상품3.png" alt="상품3">
                                <p class="product-name">VXE MAD R 잠자...</p>
                                <p class="product-price">34,900원</p>
                            </div>
                            <div class="carousel-item">
                                <img src="상품4.png" alt="상품4">
                                <p class="product-name">펄사 X3 무선 게이...</p>
                                <p class="product-price">119,000원</p>
                            </div>
                            <div class="carousel-item">
                                <img src="상품4.png" alt="상품5">
                                <p class="product-name">펄사 X3 무선 게이...</p>
                                <p class="product-price">119,000원</p>
                            </div>
                        </div>

                        <button class="carousel-btn right-btn">&gt;</button>
                    </div>
                </section>

                <!-- 구매 이력 -->
                <section class="purchase-history">
                    <h3>구매 상품 2</h3>
                    <div class="purchase-item">
                        <a href="#" class="item-container">
                            <div class="item-box"></div>
                            <p class="item-title">상품 설명 1</p>
                        </a>
                        <a href="#" class="item-container">
                            <div class="item-box"></div>
                            <p class="item-title">상품 설명 2</p>
                        </a>
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
                <section class="wishlist">
                    <h3>찜한 상품 3</h3>
                    <div class="wishlist-section">
                        <h4>전체</h4>
                        <div class="product-list">
                            <div class="product-item">
                                <img src="상품1.png" alt="상품1">
                                <p class="product-name">나이키 에어포스 1</p>
                                <p class="product-price">120,000원</p>
                            </div>
                            <div class="product-item">
                                <img src="상품2.png" alt="상품2">
                                <p class="product-name">여수 쑥 떡</p>
                                <p class="product-price">12,000원</p>
                            </div>
                            <div class="product-item">
                                <img src="상품3.png" alt="상품3">
                                <p class="product-name">경북주 12도</p>
                                <p class="product-price">25,200원</p>
                            </div>
                        </div>

                        <h4>신발</h4>
                        <div class="product-list">
                            <div class="product-item">
                                <img src="상품1.png" alt="상품4">
                                <p class="product-name">나이키 에어포스 1</p>
                                <p class="product-price">120,000원</p>
                            </div>
                        </div>

                        <h4>식품</h4>
                        <div class="product-list">
                            <div class="product-item">
                                <img src="상품2.png" alt="상품5">
                                <p class="product-name">여수 쑥 떡</p>
                                <p class="product-price">12,000원</p>
                            </div>
                            <div class="product-item">
                                <img src="상품2.png" alt="상품6">
                                <p class="product-name">경북주 12도</p>
                                <p class="product-price">25,200원</p>
                            </div>
                        </div>
                    </div>
                </section>
            </section>
        </div>
    </main>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</html>