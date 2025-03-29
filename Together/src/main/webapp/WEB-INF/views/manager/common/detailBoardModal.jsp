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
    <script src="https://kit.fontawesome.com/975074ef7f.js" crossorigin="anonymous"></script>
</head>
<body>
    
    
    <div id="container">
        <section id="titleArea" class="border-bottom">
            <c:if test="${!empty map.reply}">
                <div class="padding-left">문제의 댓글</div>
            </c:if>
            <c:if test="${!empty map.chatting}">
                <div class="padding-left">문제의 채팅</div>
            </c:if>
            <c:if test="${!empty map.review}">
                <div class="padding-left">문제의 리뷰</div>
            </c:if>
        </section>
        <section id="urlArea" class="align-center  padding-left">
            <!-- <div>
                LINK: <a  href="/board/">해당 게시글 보러가기</a>
            </div> -->
            <c:if test="${!empty map.reply}">
                <span style="color: red;">* 문제의 댓글은 빨간색으로 표시</span>
            </c:if>
            <c:if test="${!empty map.chatting}">
                <span style="color: red;">* 문제의  채팅은 빨간색으로 표시</span>
            </c:if>
        </section>
        <section id="contentArea" class="padding over-flow">
           <!-- 댓글 -->
            <c:forEach var="reply" items="${map.reply}">
                <c:if test="${reply.parentNo != 0}">
                    <div class="child border-bottom">
                        <c:if test="${empty reply.profileImg}">
                            <img src="/resources/images/image-manager/profile.png" 
                                 style="${reply.replyDelFlag == 'Y' ? 'filter: grayscale(100%);' : ''}">
                        </c:if>
                        <c:if test="${!empty reply.profileImg}">
                            <img src="${reply.profileImg}" 
                                 alt="" 
                                 style="${reply.replyDelFlag == 'Y' ? 'filter: grayscale(100%);' : ''}">
                        </c:if>
                        <div>
                            <div class="padding-left">
                                <c:if test="${reply.replyNo==no}">
                                    <span style="color: red;">
                                        ${reply.memberNick} 
                                    </span>
                                </c:if>
                                <c:if test="${reply.replyNo!=no}">
                                    <span style="color: ${reply.replyDelFlag == 'Y' ? 'gray' : 'inherit'};">
                                        ${reply.memberNick}
                                    </span>
                                </c:if>
                                &nbsp;
                                ${reply.replyCreatedDate}
                                &nbsp;
                                <c:if test="${reply.replyDelFlag != 'Y' && reply.replyNo==no}">
                                    <button class="close-btn" type="button" onclick="replyDelete(${reply.replyNo})">
                                        <i class="fa-solid fa-x"></i>
                                    </button>
                                    <span class="tooltip">문제의 댓글 삭제하기.</span>
                                </c:if>
                                <c:if test="${reply.replyDelFlag == 'Y'}">
                                    <span style="color: gray;">삭제된 댓글입니다.</span>
                                </c:if>
                            </div>
                            <div class="padding" style="color: ${reply.replyDelFlag == 'Y' ? 'gray' : 'inherit'};">
                                ${reply.replyContent}
                            </div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${reply.parentNo == 0}">
                    <div class="reply-wrap border-bottom">
                        <c:if test="${empty reply.profileImg}">
                            <img src="/resources/images/image-manager/profile.png" 
                                 style="${reply.replyDelFlag == 'Y' ? 'filter: grayscale(100%);' : 'red'}">
                        </c:if>
                        <c:if test="${!empty reply.profileImg}">
                            <img src="${reply.profileImg}" 
                                 alt="" 
                                 style="${reply.replyDelFlag == 'Y' ? 'filter: grayscale(100%);' : 'red'}">
                        </c:if>
                        <div>
                            <div class="padding-left">
                                <c:if test="${reply.replyNo==no}">
                                    <span style="color: red;">
                                        ${reply.memberNick} 
                                    </span>
                                </c:if>
                                <c:if test="${reply.replyNo!=no}">
                                    <span style="color: ${reply.replyDelFlag == 'Y' ? 'gray' : 'inherit'};">
                                        ${reply.memberNick}
                                    </span>
                                </c:if>
                                &nbsp;
                                ${reply.replyCreatedDate}
                                &nbsp;
                                <c:if test="${reply.replyDelFlag != 'Y' && reply.replyNo==no}">
                                    <button class="close-btn" type="button" onclick="replyDelete(${reply.replyNo})">
                                        <i class="fa-solid fa-x"></i>
                                    </button>
                                    <span class="tooltip">문제의 댓글 삭제하기.</span>
                                </c:if>
                                <c:if test="${reply.replyDelFlag == 'Y'}">
                                    <span style="color: gray;">삭제된 댓글입니다.</span>
                                </c:if>
                            </div>
                            <div class="padding" style="color: ${reply.replyDelFlag == 'Y' ? 'gray' : 'inherit'};">
                                ${reply.replyContent}
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
            
        

            <!-- 채팅 -->
            <c:set var="previousDate" value="" /> 
            <c:forEach var="chat" items="${map.chatting}">
                <c:set var="currentDate" value="${chat.sendDate}" />

                <c:if test="${currentDate != previousDate}">
                    <div class="date-divider">
                        <span>${currentDate}</span> 
                    </div>
                    <c:set var="previousDate" value="${currentDate}" /> 
                </c:if>

                <c:if test="${chat.reportedMemberNo == chat.memberNo}">
                    <div class="chatArea right">
                        <div class="chat-wrap right ">
                            <div><span style="color: #888;">문제의 회원:</span> ${chat.memberNick}</div>
                            <c:if test="${chat.messageNo == no}">
                                <div class="chat-right chat red" data-time="${chat.sendTime}">
                                    ${chat.messageContent}
                                </div>
                            </c:if>
                            <c:if test="${chat.messageNo != no}">
                                <div class="chat-right chat right-color" data-time="${chat.sendTime}">
                                    ${chat.messageContent}
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:if>
                <c:if test="${chat.reportedMemberNo != chat.memberNo}">
                    <div class="chatArea left parent">
                        <div class="chat-wrap left">
                            <div>${chat.memberNick}</div>
                            <div class="chat-left chat left-color" data-time="${chat.sendTime}">
                                ${chat.messageContent}
                            </div>
                        </div>
                        
                    </div>
                </c:if>

            </c:forEach>

            <c:if test="${!empty map.review}">
                <c:set var="review" value="${map.review}"></c:set>
                <div class="review-container">
                    <div class="review-top">
                        <span>
                            <span style="font-size: 18px;">${review.memberNickname}</span> &nbsp; 
                            <span>${review.reviewCreatedDate}</span>
                        </span>
                        <div class="star-rating">
                            <c:forEach var="i" begin="1" end="5">
                                <span class="${i <= review.reviewStar ? 'star filled' : 'star'}">&#9733;</span>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="review-content">
                        ${review.reviewContent}
                    </div>

                    <c:if test="${empty review.imageList}">
                        <img src="/resources/images/image-manager/noImg.png" alt="">
                    </c:if>
                    <c:if test="${!empty review.imageList}">
                        <c:forEach var="img" items="${review.imageList}">
                            <img src="${img.imagePath}${img.imageRename}" alt="">
                        </c:forEach>
                    </c:if>
                    <c:if test="${review.reviewDelFleg == 'N'}">
                        <button class="reviewDelete" type="button" onclick="reviewDelete(${review.reviewNo})">
                            해당 리뷰 삭제 하기
                        </button>
                    </c:if>
                    <c:if test="${review.reviewDelFleg == 'Y'}">
                        <div class="review-deleted-message">
                            해당 리뷰는 삭제되었습니다.
                        </div>
                    </c:if>

                </div>
            </c:if>
        </section>
    </div>

    <script>
        const no = Number(${no});
        const type = Number(${type});
        const recruitmentBoardNo = '${map.boardNo}';
    </script>
    <script src="/resources/js/manager-js/boardDetailModal.js"></script>
</body>
</html>