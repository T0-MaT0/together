<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>포인트 충전</title>
  <script src="https://js.tosspayments.com/v2/standard"></script>

  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      margin: 0;
      padding: 0;
    }

    .point-container {
      max-width: 800px;
      margin: 80px auto;
      text-align: center;
      background: #fff;
      padding: 60px 40px;
      border-radius: 16px;
      box-shadow: 0 6px 30px rgba(0,0,0,0.1);
    }

    #title {
      font-size: 32px;
      font-weight: bold;
      margin-bottom: 40px;
    }

    .radio-wrap {
      display: flex;
      flex-direction: column;
      gap: 20px;
      align-items: center;
      margin-bottom: 30px;
    }

    .radio-area {
      display: flex;
      justify-content: center;
      gap: 24px;
      flex-wrap: wrap;
    }

    .radio-area input[type="radio"] {
      display: none;
    }

    .radio-btn {
      border: 2px solid #ccc;
      border-radius: 12px;
      padding: 14px 28px;
      font-size: 18px;
      background-color: #fff;
      cursor: pointer;
      transition: all 0.2s;
      min-width: 140px;
      font-weight: 500;
    }

    .radio-area input[type="radio"]:checked + label {
      background-color: #3182F6;
      color: #fff;
      border-color: #3182F6;
    }

    .custom-input-area {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 16px;
      margin-top: 0;
    }

    #pointAmount {
      width: 180px;
      height: 50px;
      padding: 8px 12px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 8px;
      text-align: right;
    }

    #openPaymentBtn {
      background-color: #3182F6;
      color: #fff;
      border: none;
      padding: 14px 32px;
      border-radius: 8px;
      font-size: 18px;
      font-weight: 600;
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
      padding: 12px 28px;
      border-radius: 8px;
      font-size: 16px;
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
      padding: 12px 28px;
      border-radius: 8px;
      font-size: 16px;
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
  <div class="radio-wrap">
    <div class="radio-area">
      <input type="radio" name="point" value="5000" id="p5000" />
      <label for="p5000" class="radio-btn">5000원</label>

      <input type="radio" name="point" value="10000" id="p10000" />
      <label for="p10000" class="radio-btn">10000원</label>
    </div>
    <div class="radio-area">
      <input type="radio" name="point" value="30000" id="p30000" />
      <label for="p30000" class="radio-btn">30000원</label>

      <input type="radio" name="point" value="50000" id="p50000" />
      <label for="p50000" class="radio-btn">50000원</label>
    </div>
    <div class="radio-area">
      <input type="radio" name="point" value="custom" id="customPoint" />
      <label for="customPoint" class="radio-btn">직접입력</label>
    </div>
    <div class="custom-input-area">
      <input type="text" id="pointAmount" placeholder="금액 입력 (숫자만)" /> 원
    </div>
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
      alert("충전 금액을 선택하거나 입력해주세요.");
      return;
    }

    if (selected.id === "customPoint") {
      let input = document.getElementById("pointAmount").value.replace(/,/g, "").trim();
      if (!input || isNaN(input) || parseInt(input) <= 0 || parseInt(input) % 1000 !== 0) {
        alert("1000원 단위의 유효한 금액을 입력해주세요.");
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
        orderName: "포인트 충전",
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

  const input = document.getElementById("pointAmount");
  input.addEventListener("input", () => {
    document.getElementById("customPoint").checked = true;
    let raw = input.value.replace(/[^0-9]/g, "");
    if (raw === "") {
      input.value = "";
      return;
    }
    const formatted = Number(raw).toLocaleString();
    input.value = formatted;
  });

  const radios = document.querySelectorAll('input[name="point"]');
  radios.forEach(radio => {
    if (radio.id !== "customPoint") {
      radio.addEventListener("change", () => {
        input.value = ""; // 다른 금액 선택 시 직접입력값 초기화
      });
    }
  });
</script>
</body>
</html>