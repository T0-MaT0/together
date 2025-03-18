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
        </div>
    </header>
 ${map}
    <c:set var="brandProfile" value="${map.brandProfile}"></c:set>
    <!-- 본문(중앙) -->
    <div id="container-center">
        <section class="pro-board">
            <div class="board-title bottom-line">
                <div class="title">브랜드 프로필</div>
                <div class="btn-area">
                    <a href="#">블랙</a>
                    <a href="#">경고</a>
                </div>
            </div>
            <div class="profile-area">
                <img src="/resources/images/image-manager/profile.png" alt="프로필">
                <div class="nickname">${brandProfile.memberNick}</div>
            </div>

            <div class="status-area">
                <div class="ch-number">
                    <div class="status-title">상태</div>
                    <div class="status-content">${brandProfile.permissionTFl}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">댓글</div>
                    <div class="status-content">${brandProfile.replyCount}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">판매상품</div>
                    <div class="status-content">${brandProfile.productCount}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">광고문의</div>
                    <div class="status-content">${brandProfile.promCount}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">경고</div>
                    <div class="status-content">${brandProfile.wranCount}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">신고</div>
                    <div class="status-content">${brandProfile.reportCount}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">피신고</div>
                    <div class="status-content">${brandProfile.reportedCount}</div>
                </div>
                <div class="ch-number">
                    <div class="status-title">1:1문의</div>
                    <div class="status-content">${brandProfile.counselCount}</div>
                </div>
            </div>

            <div class="info-wrap">
                <div class="info-item">
                    <div>아이디: </div> <div>${brandProfile.memberId}</div>
                </div>
                <div class="info-item">
                    <div>이름: </div> <div>${brandProfile.memberName}</div>
                </div>
                <div class="info-item">
                    <div>생년월일: </div> <div>${brandProfile.memberBirth}</div>
                </div>
                <div class="info-item">
                    <div>가입일자: </div> <div>${brandProfile.enrollDate}</div>
                </div>
                <div class="info-item">
                    <div>이메일: </div> <div>${brandProfile.memberEmail}</div>
                </div>
                <div class="info-item">
                    <div>전화번호: </div> <div>${brandProfile.memberTel}</div>
                </div>
                <div class="info-item">
                    <div>등록 번호: </div> <div>${brandProfile.businessNo}</div>
                </div>
                <div class="info-item">
                    <div>계좌 번호: </div> <div>${brandProfile.bankNo}(${brandProfile.bankName})</div>
                </div>
                
                <c:set var="addressParts" value="${fn:split(brandProfile.memberAddr, '^^^')}" />
                
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
                <c:if test="${brandBoardCode==2}">
                    <a href="${brandUrl}2?boardNo=${boardNo}" class="select">상품</a>
                    <c:set var="boardTitle" value="상품 판매 목록"/>
                </c:if>
                <c:if test="${brandBoardCode!=2}">
                    <a href="${brandUrl}2?boardNo=${boardNo}" >상품</a>
                </c:if>
                <c:if test="${brandBoardCode==6}">
                    <a href="${brandUrl}6?boardNo=${boardNo}" class="select">1:1문의</a>
                    <c:set var="boardTitle" value="1:1문의 목록"/>
                </c:if>
                <c:if test="${brandBoardCode!=6}">
                    <a href="${brandUrl}6?boardNo=${boardNo}" >1:1문의</a>
                </c:if>
                <c:if test="${brandBoardCode==7}">
                    <a href="${brandUrl}7?boardNo=${boardNo}" class="select">광고</a>
                    <c:set var="boardTitle" value="광고 문의 목록"/>
                </c:if>
                <c:if test="${brandBoardCode!=7}">
                    <a href="${brandUrl}7?boardNo=${boardNo}" >광고</a>
                </c:if>
                <c:if test="${brandBoardCode==-1}">
                    <a href="${brandUrl}-1?boardNo=${boardNo}" class="select">신고</a>
                    <c:set var="boardTitle" value="신고한 목록"/>
                </c:if>
                <c:if test="${brandBoardCode!=-1}">
                    <a href="${brandUrl}-1?boardNo=${boardNo}" >신고</a>
                </c:if>
                <c:if test="${brandBoardCode==-2}">
                    <a href="${brandUrl}-2?boardNo=${boardNo}" class="select">댓글</a>
                    <c:set var="boardTitle" value="작성한 댓글 목록"/>
                </c:if>
                <c:if test="${brandBoardCode!=-2}">
                    <a href="${brandUrl}-2?boardNo=${boardNo}" >댓글</a>
                </c:if>
            </div>
        


            <div class="board-title">
                <div class="title">${boardTitle}</div>
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
                    <div>제목</div>
                    <div>게시일자</div>
                    <div>상태</div>
                </div>

                <c:forEach var="brand" items="${map.brandList}">
                    <div class="list item bottom-line">
                        <div>${brand.boardNo}</div>
                        <div>${brand.boardTitle}</div>
                        <div>${brand.createDate}</div>
                        <div>${brand.boardDelFl}</div>
                    </div>
                </c:forEach>
                
                
            </div>

            <c:set var="urlCp" value="/manageBrand/brandProfile/${brandBoardCode}?boardNo=${boardNo}&cp="></c:set>
            <ul id="pagination">
                <li><a href="${urlCp}1">&lt;&lt;</a></li>
                <li><a href="${urlCp}${pagination.prevPage}">&lt;</a></li>
                
                    <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
                        <c:choose>
                            <c:when test="${pagination.currentPage == i}">
                                <!-- 현재 페이지인 경우 -->
                                <li class="curr">${i}</li>
                            </c:when>
            
                            <c:otherwise>
                                <!-- 현재 페이지가 아닌 경우 -->
                                <li><a href="${urlCp}${i}">${i}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>                
                
                <li><a href="${urlCp}${pagination.nextPage}">&gt;</a></li>
                <li><a href="${urlCp}${pagination.maxPage}">&gt;&gt;</a></li>
            </ul>

        </section>
        
    </div>


</main>

<script>
    const acc = document.getElementsByClassName("accordion");

    for (let i = 0; i < acc.length; i++) {
        acc[i].addEventListener("click", function () {
            this.classList.toggle("active");
            let panel = this.nextElementSibling;
            console.log(panel.style.maxHeight);
            if (panel.style.maxHeight) {
                panel.style.maxHeight = null;
            } else {
                panel.style.maxHeight = panel.scrollHeight + "px";
            }
        });

    }
</script>
</body>

</html>