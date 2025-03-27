<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>포인트 충전</title>
  <link rel="stylesheet" href="/resources/css/member/point-style.css">
</head>
<body>

  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <section class="point-container">
    <div id="title">포인트 충전하기</div>

    <div class="radio-area">
      <label><input type="radio" name="point" value="10000">10000원</label>
      <label><input type="radio" name="point" value="100000">100000원</label>
    </div>

    <div class="radio-area">
      <label><input type="radio" name="point" value="30000">30000원</label>
      <label><input type="radio" name="point" value="300000">300000원</label>
    </div>

    <div class="radio-area">
      <label><input type="radio" name="point" value="50000">50000원</label>
      <label class="nogap">
        <input type="radio" name="point" value="custom" id="customPoint">
        <input type="text" id="pointAmount" placeholder="직접 입력">원
      </label>
    </div>

    <div class="radio-area">
      <button id="chargeBtn" type="button">충전하기</button>
    </div>
  </section>

  <!-- 모달 -->
  <div id="paymentModal" class="modal-overlay" style="display:none;">
    <div class="modal-content">
      <h3 class="paymentTitle">결제 수단을 선택해주세요</h3>
      <div class="payment-options">
        <button type="button" class="payment-btn" data-method="bank">계좌이체</button>
        <button type="button" class="payment-btn" data-method="kakaopay">카카오페이</button>
        <button type="button" class="payment-btn" data-method="tosspay">토스페이</button>
      </div>
      <button id="modalClose" type="button">취소</button>
    </div>
  </div>

  <jsp:include page="/WEB-INF/views/common/footer.jsp" />

  <script>
    let selectedAmount = null;
  
    document.addEventListener("DOMContentLoaded", () => {
      const modal = document.getElementById("paymentModal");
  
      document.getElementById("chargeBtn").addEventListener("click", () => {
        const selected = document.querySelector('input[name="point"]:checked');
        if (!selected) {
          alert("충전 금액을 선택해주세요.");
          return;
        }
  
        if (selected.id === "customPoint") {
          const customAmount = document.getElementById("pointAmount").value.trim();
          if (!customAmount || isNaN(customAmount)) {
            alert("직접 입력한 금액이 유효하지 않습니다.");
            return;
          }
          selectedAmount = customAmount;
        } else {
          selectedAmount = selected.value;
        }
  
        modal.style.display = "flex";
      });
  
      document.querySelectorAll(".payment-btn").forEach((btn) => {
        btn.addEventListener("click", () => {
          const method = btn.getAttribute("data-method");
  
          if (!selectedAmount || !method) {
            alert("결제 정보가 정확하지 않습니다.");
            return;
          }
  
          // ✅ 여기 템플릿 리터럴 문제 해결!
          const url = "/openbanking/charge?amount=" + encodeURIComponent(selectedAmount) + "&method=" + encodeURIComponent(method);

  
          window.location.href = url;
        });
      });
  
      document.getElementById("modalClose").addEventListener("click", () => {
        modal.style.display = "none";
      });
    });
  </script>
  
  
</body>
</html>
