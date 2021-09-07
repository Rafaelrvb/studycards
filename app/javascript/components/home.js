const initUpdateMiddleBannerOnScroll = () => {
  const middleBanner = document.querySelector('.wrapper2');
  if (middleBanner) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= window.innerHeight) {
        middleBanner.classList.add('#slide2');
      }
    });
  }
}

export { initUpdateMiddleBannerOnScroll };
