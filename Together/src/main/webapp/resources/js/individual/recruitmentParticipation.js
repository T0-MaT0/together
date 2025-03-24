document.addEventListener("DOMContentLoaded", function () {
    const countSelect = document.getElementById("participant-count");
    const selectedCountSpan = document.getElementById("selectedCount");
    const totalPointSpan = document.getElementById("totalPoint");
    const unitPrice = parseInt(document.getElementById("unitPrice").value);

    countSelect.addEventListener("change", function () {
        const selectedCount = parseInt(this.value);

        // selectedCount 반영
        selectedCountSpan.textContent = selectedCount;

        // 총 포인트 계산 후 포맷팅
        const total = unitPrice * selectedCount;
        totalPointSpan.textContent = total.toLocaleString(); // 10000 -> "10,000"
    });
});

