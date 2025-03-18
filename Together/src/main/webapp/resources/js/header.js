const currentUrl = window.location.pathname; 
const navLinks = document.querySelectorAll(".sub-nav .left-links a");

navLinks.forEach(link => {
    if (link.getAttribute("href") === currentUrl) {
        link.classList.add("active"); 
    } else {
        link.classList.remove("active"); 
    }
});

document.querySelector(".btn-recruit").addEventListener("click", function () {
    window.location.href = "/group/create";
});
