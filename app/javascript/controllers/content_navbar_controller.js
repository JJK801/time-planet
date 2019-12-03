import { Controller } from 'stimulus';

export default class extends Controller {

  connect() {
    this.stickyClass = 'ContentNavbar--sticky';
    this.navbarOffsetTop = this.element.offsetTop;
    this.stickNavbar();
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
