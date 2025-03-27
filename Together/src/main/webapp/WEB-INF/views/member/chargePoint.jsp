<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>포인트 충전</title>
  <link rel="stylesheet" href="/resources/css/member/point-style.css">
  <script src="https://js.tosspayments.com/v1/payment"></script>
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
    <button id="chargeBtn" type="button">토스로 충전하기</button>
  </div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
 const tossPayments = TossPayments("test_ck_3Vzaq1JxM63m5Rxlrw0vbG9nYz0X");


  document.getElementById("chargeBtn").addEventListener("click", () => {
    const selected = document.querySelector('input[name="point"]:checked');
    let selectedAmount;

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
      selectedAmount = parseInt(customAmount);
    } else {
      selectedAmount = parseInt(selected.value);
    }

    const orderId = "order_" + new Date().getTime();
    const orderName = "포인트 충전";
    const customerName = "${loginMember.memberName}"; // ✅ 세션에서 로그인 이름 사용

    tossPayments.requestPayment("카드", {
      amount: selectedAmount,
      orderId: orderId,
      orderName: orderName,
      customerName: customerName,
      successUrl: "http://localhost/toss/success",
      failUrl: "http://localhost/toss/fail"
    });
  });

</script>

</body>
</html>
