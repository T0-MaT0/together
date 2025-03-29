<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>포인트 추전</title>
  <script src="https://js.tosspayments.com/v2/standard"></script>

  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f9f9f9;
      margin: 0;
      padding: 0;
    }

    .point-container {
      max-width: 600px;
      margin: 60px auto;
      text-align: center;
      background: #fff;
      padding: 40px 30px;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    }

    #title {
      font-size: 28px;
      font-weight: bold;
      margin-bottom: 30px;
    }

    .radio-area {
      display: flex;
      justify-content: center;
      flex-wrap: wrap;
      gap: 16px;
      margin-bottom: 20px;
    }

    .radio-area label {
      display: flex;
      align-items: center;
      justify-content: center;
      border: 2px solid #ccc;
      border-radius: 50px;
      padding: 12px 24px;
      font-size: 16px;
      cursor: pointer;
      transition: all 0.2s;
      background-color: #fff;
    }

    .radio-area input[type="radio"] {
      display: none;
    }

    .radio-area input[type="radio"]:checked + span {
      background-color: #333;
      color: #fff;
      border-color: #333;
      border-radius: 50px;
      padding: 12px 24px;
    }

    .radio-area label span {
      display: inline-block;
      width: 100%;
    }

    #pointAmount {
      padding: 10px 16px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 8px;
      width: 160px;
    }

    #openPaymentBtn {
      background-color: #3182F6;
      color: #fff;
      border: none;
      padding: 12px 24px;
      border-radius: 8px;
      font-size: 16px;
      font-weight: 500;
      cursor: pointer;
      transition: background-color 0.2s;
    }

    #openPaymentBtn:hover {
      background-color: #1f64d4;
    }

    #payment-modal {
      display: none;
      position: fixed;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background: rgba(0,0,0,0.6);
      z-index: 9999;
      overflow-y: auto;
    }

    .modal-content {
      background: #fff;
      margin: 5vh auto;
      padding: 30px 20px;
      width: 95%;
      max-width: 650px;
      min-height: 600px;
      border-radius: 12px;
      box-shadow: 0 0 30px rgba(0,0,0,0.2);
      overflow: visible;
    }

    .btn-primary {
      background-color: #3182F6;
      color: #fff;
      border: none;
      padding: 10px 22px;
      border-radius: 6px;
      font-size: 15px;
      font-weight: 500;
      cursor: pointer;
      transition: background-color 0.2s;
      margin-left: 10px;
    }

    .btn-primary:hover {
      background-color: #1f64d4;
    }

    .btn-secondary {
      background-color: #e5e7eb;
      color: #374151;
      border: none;
      padding: 10px 22px;
      border-radius: 6px;
      font-size: 15px;
      font-weight: 500;
      cursor: pointer;
      transition: background-color 0.2s;
    }

    .btn-secondary:hover {
      background-color: #d1d5db;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section class="point-container">
  <div id="title">포인트 충전하기</div>
  <div class="radio-area">
    <label><input type="radio" name="point" value="10000" /><span>10000원</span></label>
    <label><input type="radio" name="point" value="30000" /><span>30000원</span></label>
    <label><input type="radio" name="point" value="50000" /><span>50000원</span></label>
  </div>

  <div class="radio-area">
    <label><input type="radio" name="point" value="custom" id="customPoint" /><span>직접입력</span></label>
    <input type="text" id="pointAmount" placeholder="금액 입력 (숫자만)" /> 원
  </div>

  <div class="radio-area">
    <button id="openPaymentBtn" type="button">결제하기</button>
  </div>
</section>

<div id="payment-modal">
  <div class="modal-content">
    <div id="payment-method"></div>
    <div id="agreement" style="margin-top: 20px;"></div>
    <div style="text-align: right; margin-top: 20px;">
      <button id="paymentBtn" class="btn-primary">결제하기</button>
      <button type="button" onclick="closeModal()" class="btn-secondary">취소</button>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>
  const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
  const customerKey = "member_${loginMember.memberNo}";
  const customerName = "${loginMember.memberName}";
  const customerEmail = "${loginMember.memberEmail}";
  const customerTel = "${loginMember.memberTel}";

  let widgets, selectedAmount;
  const tossPayments = TossPayments(clientKey);

  async function initWidgets(amount) {
    widgets = tossPayments.widgets({ customerKey });

    await widgets.setAmount({ currency: "KRW", value: amount });

    await Promise.all([
      widgets.renderPaymentMethods({ selector: "#payment-method", variantKey: "DEFAULT" }),
      widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" })
    ]);
  }

  document.getElementById("openPaymentBtn").addEventListener("click", async () => {
    const selected = document.querySelector('input[name="point"]:checked');

    if (!selected) {
      alert("추전 금액을 선택하거나 입력해주세요.");
      return;
    }

    if (selected.id === "customPoint") {
      const input = document.getElementById("pointAmount").value.trim();
      if (!input || isNaN(input) || parseInt(input) <= 0) {
        alert("유효한 금액을 입력해주세요.");
        return;
      }
      selectedAmount = parseInt(input);
    } else {
      selectedAmount = parseInt(selected.value);
    }

    document.getElementById("payment-modal").style.display = "block";
    await initWidgets(selectedAmount);
  });

  document.getElementById("paymentBtn").addEventListener("click", async () => {
    const orderId = "order_" + new Date().getTime();

    try {
      await widgets.requestPayment({
        orderId,
        orderName: "포인트 추전",
        successUrl: "http://localhost/toss/success",
        failUrl: "http://localhost/toss/fail",
        customerName,
        customerEmail,
        customerMobilePhone: customerTel
      });
    } catch (err) {
      alert("결제 실패: " + err.message);
    }
  });

  function closeModal() {
    document.getElementById("payment-modal").style.display = "none";
  }
</script>
</body>
</html>
