<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>


<c:set var="menuName" value="brand"/> <!-- 사이드 메뉴 설정 -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/manager-css/manager-common.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/brand/brand-profile.css" />
    <script>
        // 사이드 메뉴 설정
        const menuName = "${menuName}";
    </script>
</head>

<body>

</body>

<main>
    
    <jsp:include page="/WEB-INF/views/manager/common/sideMenu.jsp"/>


    <!-- 위쪽 영역 -->
    <header>
        <div class="head-title">
            <div>브랜드 관리</div>
             &nbsp; <div> - 프로필</div>
             <!-- <a href="location">이전으로 </a> -->
             <a href="javascript:history.back();" class="backToHistory">&lt; 목록으로 돌아가기</a>
        </div>
    </header>
    <c:set var="brandProfile" value="${map.brandProfile}"></c:set>
    <!-- 본문(중앙) -->
    <div id="container-center">
        <section class="pro-board">
            <div class="board-title bottom-line">
                <div class="title">브랜드 프로필</div>
                <div class="btn-area">
                    <c:if test="${profile.state eq '블랙'}">
                        <a href="BeRecover?memberNo=${profile.memberNo}" style="background-color: #a3a3a3;">복구</a>
                    </c:if>
                    <c:if test="${profile.state != '블랙'}">
                        <a href="BeBlack?memberNo=${profile.memberNo}">블랙</a>
                   
                        <!-- <a href="BeWarn?memberNo=${profile.memberNo}">경고</a> -->
                    </c:if>      
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
                    <div class="status-content">${profile.state}/${profile.companyState}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">댓글</div>
                    <div class="status-content">${profile.replyCount}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">판매상품</div>
                    <div class="status-content">${profile.productCount}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">광고문의</div>
                    <div class="status-content">${profile.promCount}</div>
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
                <div class="info-item">
                    <div>등록 번호: </div> <div>${profile.businessNo}</div>
                </div>
                <div class="info-item">
                    <div>계좌 번호: </div> <div>${profile.bankNo}(${profile.bankName})</div>
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
            <c:set var="pagination" value="${map.pagination}"/>
            <c:set var="brandUrl" value="/manageBrand/brandProfile/"></c:set>

            <div class="subMenu-area">
                <a class="select" onclick="boardList(0, ${profile.memberNo})">상품</a>
                <a onclick="boardList(1, ${profile.memberNo}, 1)" >문의</a>
                <a onclick="boardList(2, ${profile.memberNo}, 1)" >광고</a>
                <a onclick="boardList(3, ${profile.memberNo}, 1)">신고</a>
                <a onclick="boardList(4, ${profile.memberNo}, 1)" >댓글</a>
            </div>

            <div class="board-title">
                <div class="title"></div>
                <div class="select-area">
                    <!-- <select name="customerStatus" id="customerStatus">
                        <option>전체</option>
                        <option>미처리</option>
                        <option>처리</option>
                    </select> -->
                </div>

            </div>
            
            <div id="list-area">
                <div class="list">
                    <div>번호</div>
                    <div>제목</div>
                    <div>게시일자</div>
                    <div>상태</div>
                </div>

            </div>
            <ul id="pagination">
                <!-- <li>&lt;</li>
                <li>&gt;</li> -->
            </ul>

        </section>
        
    </div>

    <jsp:include page="/WEB-INF/views/common/sidebar/sideBar-main.jsp" /> 
</main>

<script src="/resources/js/manager-js/brand/brand.js"></script>
</body>

</html>