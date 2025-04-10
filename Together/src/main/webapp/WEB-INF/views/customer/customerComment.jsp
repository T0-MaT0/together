<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<div id="commentArea">
    <!-- 댓글 목록 -->
    <div class="comment-list-area">
        
        <ul id="commentList">
            
            <c:forEach items="${board.commentList}" var="comment">
            <!-- 부모/자식 댓글 -->
             <!-- int에 null 값이 0으로 담김 -->
            <li id="c${comment.commentNo}" class="comment-row <c:if test= '${comment.parentNo != 0}'>child-comment</c:if>">


                    <p class="comment-writer">
    
                    <c:choose>
                        <c:when test="${empty comment.profileImage}">
                            <!-- 프로필 이미지가 없는 경우 기본이미지 -->
                            <img src="/resources/images/user.png">
                        </c:when>
                        <c:otherwise>
                            <img src="${comment.profileImage}">
                        </c:otherwise>
                    </c:choose>
                        <%--<img src="/resources/images/user.png">--%>
    
                        <!-- 닉네임 -->
                        <span>${comment.memberNickname}</span>
                        
                        <!-- 작성일 -->
                        <span class="comment-date">${comment.commentCreateDate}</span>
                    </p>
                    
                    <!-- 댓글 내용 -->
                    <p class="comment-content">${comment.commentContent}</p>
    
    
                    <!-- 버튼 영역 -->
                    <div class="comment-btn-area">
                        <c:if test="${!empty loginMember}">

                            <button onclick="showInsertComment(${comment.commentNo}, this)">답글</button>   

                        </c:if>
                            
                        <!-- 로그인 회원과 댓글 작성자가 같은 경우 --> 
                        <c:if test="${loginMember.memberNo == comment.memberNo}">

                            <button onclick="updateComment(${comment.commentNo}, this)">수정</button>     
                            <button onclick="deleteComment(${comment.commentNo})">삭제</button>
                        </c:if>
                    </div>

                </c:forEach>
            </li>


        </ul>
    </div>
    

    <!-- 댓글 작성 부분 -->
    <div class="comment-write-area">
        <textarea id="commentContent"></textarea>
        <button id="addComment">
            댓글<br>
            등록
        </button>
 
    </div>

</div>