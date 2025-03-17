document.addEventListener("DOMContentLoaded", function () {
    const currentUrl = window.location.pathname; 

    const navLinks = document.querySelectorAll(".sub-nav .left-links a");

    navLinks.forEach(link => {
        if (link.getAttribute("href") === currentUrl) {
            link.classList.add("active"); 
        } else {
            link.classList.remove("active"); 
        }
    });
});