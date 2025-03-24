document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");
    const paymentBtn = document.querySelector(".payment-btn");

    paymentBtn.addEventListener("click", function (e) {
        const currentPoint = parseInt(document.getElementById("currentPoint").value);
        const paymentAmount = parseInt(document.getElementById("paymentAmount").value);

        if (currentPoint < paymentAmount) {
            alert("보유 포인트가 부족합니다. 참여할 수 없습니다.");
            e.preventDefault();
        }
    });
});