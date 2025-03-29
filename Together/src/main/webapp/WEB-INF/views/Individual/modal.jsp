<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<div id="modal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeReportModal()">&times;</span>
    <h2>신고</h2>

    <div class="modalInner brandInner">
      <div class="modalTop">
        <div class="modalReport">
            <strong>제목:</strong>
            <input type="text" id="reportTitle" placeholder="신고 제목을 입력하세요" 
                style="width: 300px; padding: 5px; border-radius: 5px; border: 1px solid #ccc;">
        </div>

        <div class="memberName">
          <strong>신고자:</strong> <span id="reporterName"></span>
        </div>
      </div>

      <div class="modalMid">
        <div>내용</div>
        <div class="customerText" id="reportReason" contenteditable="true"></div>
      </div>

      <div class="modal-btn barndBtn">
        <button onclick="submitReport()">처리</button>
      </div>
    </div>
  </div>
</div>

