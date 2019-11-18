const initUpdateNavbarOnScroll = () => {
    const navbar = document.querySelector('.Navbar');
    if (navbar) {
        window.addEventListener('scroll', () => {
            if (window.scrollY >= 10) {
                navbar.classList.add('Navbar--black');
            } else {
                navbar.classList.remove('Navbar--black');
            }
        });
    }
};

export { initUpdateNavbarOnScroll };
