<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<div id="modal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2> 신고</h2>

        <div class="modalInner brandInner">

            <div class="modalTop">
                <!-- <div class="modalTitle">
                    <strong>제목:</strong> 정말 나쁜 말을 했어요! 마상입었어요!
                </div> -->
                <div class="modalReport">
                    <strong>제목:</strong> 정말 품질 나쁜 물품을 팔았어요! 식중독에 걸렸어요!!
                </div>
                <div class="modal-submit">  
                    <select name="modalSubmit" id="modalSubmit" class="modalSubmit barndSubmit">
                        <option disabled selected>선택</option>
                        <option>반려</option>
                        <option>블랙</option>
                        <option>경고</option>
                    </select>
                </div>
                <div class="memberName">
                    <strong>신고자:</strong> 폼폼푸리 
                </div>
                <div class="reportedName">
                    <strong>신고대상:</strong> 폼폼푸리 
                </div>
            </div>

            <div class="modalMid">
                <div>내용</div>
                <div  class="customerText">asdfasdf</div>
                <!-- <textarea name="managerText" class="customerText">ㅁㄴㅇㄹㅁㄴㅇㄹ</textarea> -->
            </div>

            <div class="midBtn barndBtn">
                <button id="infoBtn" onclick="openProfile()">브랜드 정보 조회</button>
                <button id="BoardBtn" onclick="openBoard()">문제 상품 조회</button>
            </div>
            <div class="modalBottom">
                <div>답변</div>
                <!-- <div class="managerReportText">ㅁㄴㅇㄹㅁㄴㅇㄹ</div> -->
                <div class="managerReportText" contenteditable="true">ㅁㄴㅇㄹㅁㄴㅇㄹ</div>
            </div>
            <div class="modal-btn barndBtn">
                <button onclick="reportSubmit('brand')">처리</button>
            </div>


            <!-- 로딩 화면 -->
            <div class="loadingCoverPurple">
                <div class="spinner">
                    <div class="double-bounce1Purple"></div>
                    <div class="double-bounce2Purple"></div>
                </div>
            </div>
        </div>

    </div>
</div>