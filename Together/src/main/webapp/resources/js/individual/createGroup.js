document.addEventListener("DOMContentLoaded", function () {
    const createBtn = document.querySelector(".btn-create");

    if (createBtn) {
        createBtn.addEventListener("click", function () {
            // 팝업창 크기
            const width = 800;
            const height = 650;
            
            // 화면 중앙 정렬
            const left = (window.screen.width / 2) - (width / 2);
            const top = (window.screen.height / 2) - (height / 2);

            // 팝업창 옵션
            const windowFeatures = `width=${width},height=${height},left=${left},top=${top},resizable=no,scrollbars=yes`;
            
            // 팝업 열기
            window.open("/kakaoAPI", "kakaoAPIPopup", windowFeatures);
        });
    }
});

function setJibunAddress(addr) {
    document.getElementById("chosenAddress").textContent = addr;
}

document.addEventListener("DOMContentLoaded", function() {
    // 날짜를 "YY. MM. DD" 형태로 변환하는 헬퍼 함수
    function formatYYMMDD(date) {
        const year = (date.getFullYear() % 100).toString().padStart(2, '0'); // 예: 2023 → "23"
        const month = (date.getMonth() + 1).toString().padStart(2, '0');     // 1~12 → "01"~"12"
        const day = date.getDate().toString().padStart(2, '0');             // 1~31 → "01"~"31"
        return `${year}. ${month}. ${day}`;
    }

    // Flatpickr 초기화 (range 모드)
    const myCal = flatpickr("#hiddenRangeInput", {
        mode: "range",
        // 굳이 dateFormat 안 써도 됨 (폼 전송용이라면 "Y-m-d" 정도로)
        locale: "ko",
        minDate: "today",
        static: true,

        onChange: function(selectedDates) {
            // 시작/끝 날짜 2개 선택된 경우
            if (selectedDates.length === 2) {
                const startDate = selectedDates[0];
                const endDate   = selectedDates[1];

                const startStr = formatYYMMDD(startDate);
                const endStr   = formatYYMMDD(endDate);

                // "YY. MM. DD ~ YY. MM. DD" 형식으로 표시
                document.getElementById("displayRange").textContent
                    = `${startStr} ~ ${endStr}`;
            }
        }
    });

    // 달력 아이콘 클릭 → 달력 열기
    document.getElementById("calendarIcon").addEventListener("click", function() {
        myCal.open();
    });
});