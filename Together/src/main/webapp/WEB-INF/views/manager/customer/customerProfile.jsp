<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<c:set var="menuName" value="customer"/> <!-- 사이드 메뉴 설정 -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/manager-css/manager-common.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/customer/customer-profile.css" />
    <script>
        // 사이드 메뉴 설정
        const menuName = "${menuName}";
    </script>
</head>

<body>

</body>

<main>
    
    <!-- 사이드 메뉴 -->
    <jsp:include page="/WEB-INF/views/manager/common/sideMenu.jsp"/>


    <!-- 위쪽 영역 -->
    <header>
        <div class="head-title">
            <div>고객 관리</div>
             &nbsp; <div> - 프로필</div>
        </div>
    </header>

    <!-- 본문(중앙) -->
    <div id="container-center">
        <section class="pro-board">
            <div class="board-title bottom-line">
                <div class="title">회원 프로필</div>
                <div class="btn-area">
                    <a href="report?memberNo=${profile.memberNo}">블랙</a>
                    <a href="report?memberNo=${profile.memberNo}">경고</a>
                </div>
            </div>

            <div class="profile-area">
                <c:if test="${empty profile.profileImg}">
                    <img src="/resources/images/image-manager/profile.png" alt="프로필">
                </c:if>
                <c:if test="${!empty profile.profileImg}">
                    <img src="${profile.profileImg}" alt="프로필">
                </c:if>
                <div class="nickname">${profile.memberNick}</div>
            </div>

            <div class="status-area">
                <div class="ch-number">
                    <div class="status-title">상태</div>
                    <div class="status-content">${profile.state}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">댓글</div>
                    <div class="status-content">${profile.replyCount}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">모집글</div>
                    <div class="status-content">${profile.getherCount}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">주문상품</div>
                    <div class="status-content">${profile.orderCount}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">경고</div>
                    <div class="status-content">${profile.warnCount}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">신고</div>
                    <div class="status-content">${profile.reportCount}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">피신고</div>
                    <div class="status-content">${profile.reportedCount}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">1:1문의</div>
                    <div class="status-content">${profile.questCount}</div>
                </div>
            </div>

            <div class="info-wrap">
                <div class="info-item">
                    <div>아이디: </div> <div>${profile.memberId}</div>
                </div>
                <div class="info-item">
                    <div>이름: </div> <div>${profile.memberName}</div>
                </div>
                <div class="info-item">
                    <div>생년월일: </div> <div>${profile.memberBirth}</div>
                </div>
                <div class="info-item">
                    <div>가입일자: </div> <div>${profile.enrollDate}</div>
                </div>
                <div class="info-item">
                    <div>이메일: </div> <div>${profile.memberEmail}</div>
                </div>
                <div class="info-item">
                    <div>전화번호: </div> <div>${profile.memberTel}</div>
                </div>

                <c:set var="addressParts" value="${fn:split(profile.memberAddr, '^^^')}" />

                <div class="info-item">
                    <div>주소: </div> <div>${addressParts[0]}</div>
                </div>
                <div class="address">
                    <div>${addressParts[1]}</div>
                </div>
                <div class="address">
                    <div>${addressParts[2]}</div>
                </div>
            </div>

        </section>
        <section class="pro-board">
            <div class="subMenu-area">
                <a class="select" onclick="boardList(0)">모집글</a>
                <a onclick="boardList(1)" >문의</a>
                <a onclick="boardList(2)" >주문상품</a>
                <a onclick="boardList(3)">신고</a>
                <a onclick="boardList(5)" >댓글</a>
            </div>
        
            <div class="board-title">
                <div class="title">판매 상품 이력</div>
                <div class="select-area">
                    <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>미처리</option>
                        <option>처리</option>
                    </select>
                </div>

            </div>
            
            <div id="list-area">
                <div class="list">
                    <div>번호</div>
                    <div>문의제목</div>
                    <div>문의일자</div>
                    <div>상태</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>미처리</div>
                </div>
                <div class="list item bottom-line">
                    <div>1</div>
                    <div>문의할게 있어요!! 상품 판매...</div>
                    <div>2025.02.25</div>
                    <div>처리</div>
                </div>
                
            </div>

            <ul id="pagination">
                <li>&lt;&lt;</li>
                <li>&lt;</li>
                <li class="curr">1</li>
                <li>2</li>
                <li>3</li>
                <li>4</li>
                <li>5</li>
                <li>6</li>
                <li>7</li>
                <li>8</li>
                <li>9</li>
                <li>10</li>
                <li>&gt;</li>
                <li>&gt;&gt;</li>
            </ul>

        </section>
        
    </div>


</main>
<script src="/resources/js/manager-js/customer/manageCustomer.js"></script>
</body>

</html>