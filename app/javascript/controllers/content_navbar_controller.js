import { Controller } from 'stimulus';

export default class extends Controller {

  connect() {
    this.stickyClass = 'ContentNavbar--sticky';
    this.navbarOffsetTop = this.element.offsetTop;
    this.stickNavbar();
  }

  scroll(event) {
    event.preventDefault();
    const scrollToId = event.target.closest('a').getAttribute('href').substr(1);

    const navbarOffset = 72; // 4.5rem
    const scrollToPosition = document.getElementById(scrollToId).offsetTop;
    const offsetPosition = scrollToPosition - navbarOffset;

    window.scrollTo({
      top: offsetPosition,
      behavior: "smooth"
    });
  }

  stickNavbar() {
    const windowScroll = document.body.scrollTop + document.documentElement.scrollTop;
    if ( windowScroll > this.navbarOffsetTop) {
      this.element.classList.add(this.stickyClass);
    } else {
      this.element.classList.remove(this.stickyClass);
    }
  }
}
