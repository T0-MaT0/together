document.addEventListener("DOMContentLoaded", function () {
    const productGrid = document.getElementById("product-grid");
    let startIndex = 6; 
    const itemsPerPage = 6;
    let allProducts = [...document.querySelectorAll(".product-grid .product")];

    // 초기 9개만 표시하고 나머지는 숨김 처리
    allProducts.forEach((product, index) => {
        if (index >= startIndex) {
            product.style.display = "none";
        }
    });

    function loadMoreProducts() {
        const nextProducts = allProducts.slice(startIndex, startIndex + itemsPerPage);
        nextProducts.forEach(product => product.style.display = "block");
        startIndex += itemsPerPage;
    }

    // 스크롤 시 자동 로드
    window.addEventListener("scroll", function () {
        if (window.innerHeight + window.scrollY >= document.body.offsetHeight - 200) {
            loadMoreProducts();
        }
    });
});