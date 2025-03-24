<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>


<!-- <div id="reportProfileModal"> -->
    <div class="profile-content sectionColor draggable">
        <div class="mod-header" id="dragMe">
            <span class="fold"><i class="fa-solid fa-minus"></i></span>
            <span class="close" onclick="closeProfile()"><i class="fa-solid fa-x"></i></span>
            <h class="mod-title"> 신고</h>
        </div>
        <div class="mod-body">
            <div class="profile-section board-inner">
                <div class="profile-info">
                    <div style="padding: 5px; font-size: 20px;">신고 당한 목록</div>
                    <div class="profile-detail">
                        <!-- <img src="/resources/images/image-manager/profile.png" alt="프로필">
                        <div style="font-size: 15px; font-weight: normal;"><strong>닉네임:</strong> 폼폼푸리</div>
                        <div style="font-size: 15px; font-weight: normal;"><strong>경고 횟수:</strong> 2회</div> -->
                    </div>
                </div>
                <div class="pro-board p-title">
                    <div>번호</div>
                    <div>제목</div>
                    <div>일자</div>
                    <div>상태</div>
                </div>
                <div class="profile-list">
                    <!-- <div class="pro-board  body-board">
                        <div>1</div>
                        <div>신고신고!</div>
                        <div>2025-01-01</div>
                        <div>대기</div>
                    </div> -->
                </div>
    
            </div>
    
            <div class="report-list-section board-inner">
                    <div class="detail-title">신고 내용</div>
                    <div class="nothing"> 목록을 클릭해 주세요 </div>
            </div>
        </div>

    </div>
<!-- </div> -->