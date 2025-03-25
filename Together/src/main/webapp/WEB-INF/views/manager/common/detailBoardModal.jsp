<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!-- 
모집 번호: ${map.RECRUITMENT_NO}
<br/>
모집 상태: ${map.RECRUITMENT_STATUS}
<br/>
모집 내용: ${map.BOARD_CONTENT}
<br/>
URL: ${map.PRODUCT_URL}
<br/>
BOARD_NO: ${map.BOARD_NO}
<br/>
CREATE_DATE: ${map.CREATE_DATE}
<br/>
BOARD_CD: ${map.BOARD_CD} 
<br/>
BOARD_TITLE: ${map.BOARD_TITLE}
<br/>
최대 인원: ${map.MAX_PARTICIPANTS}
<br/>
qr코드: ${map.QR_CODE}
<br/>
MEMBER_NO: ${map.MEMBER_NO}
<br/>
REGION: ${map.REGION}
<br/> -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/manager-css/common/detailBoardModal.css">
</head>
<body>
    
    
    <div id="container">
        <section id="titleArea" class="border-bottom">
            <c:if test="${!empty map.reply}">
                <div class="padding-left">문제의 댓글</div>
            </c:if>
        </section>
        <section id="urlArea" class="align-center  padding-left">
            <!-- <div>
                LINK: <a  href="/board/">해당 게시글 보러가기</a>
            </div> -->
            <span style="color: red;">* 문제의 댓글은 빨간색으로 표시</span>
        </section>
        <section id="contentArea" class="padding over-flow">
           
            <c:forEach var="reply" items="${map.reply}">
                <c:if test="${reply.parentNo != 0}">
                    <div class="child border-bottom">
                        <c:if test="${empty reply.profileImg}">
                            <img src="/resources/images/image-manager/profile.png">
                        </c:if>
                        <c:if test="${!empty reply.profileImg}">
                            <img src="${reply.profileImg}" alt="">
                        </c:if>
                        <div>
                            <div class="padding-left">
                                <c:if test="${reply.replyNo==no}">
                                    <span style="color: red;">
                                        ${reply.memberNick}
                                    </span>
                                </c:if>
                                <c:if test="${reply.replyNo!=no}">
                                    <span >
                                        ${reply.memberNick}
                                    </span>
                                </c:if>
                                &nbsp;
                                ${reply.replyCreatedDate}
                            </div>
                            <div class="padding">${reply.replyContent}</div>
                        </div>
                    </div>
                    
                </c:if>

                <c:if test="${reply.parentNo == 0}">
                    <div class="reply-wrap border-bottom">
                        <c:if test="${empty reply.profileImg}">
                            <img src="/resources/images/image-manager/profile.png">
                        </c:if>
                        <c:if test="${!empty reply.profileImg}">
                            <img src="${reply.profileImg}" alt="">
                        </c:if>
                        <div>
                            <div class="padding-left">
                                <c:if test="${reply.replyNo==no}">
                                    <span style="color: red;">
                                        ${reply.memberNick}
                                    </span>
                                </c:if>
                                <c:if test="${reply.replyNo!=no}">
                                    <span >
                                        ${reply.memberNick}
                                    </span>
                                </c:if>
                                &nbsp;
                                ${reply.replyCreatedDate}
                            </div>
                            <div class="padding">${reply.replyContent}</div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </section>
    </div>

    <script>
        const no = Number(${no});
        const type = Number(${type});
        const url = Number(${map.url});
    </script>
    <script src="/resources/js/manager-js/boardDetailModal.js"></script>
</body>
</html>