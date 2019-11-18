import { Controller } from "stimulus";
import {disableBodyScroll, enableBodyScroll, clearAllBodyScrollLocks} from 'body-scroll-lock';

export default class extends Controller {
  static targets = [ 'main', 'hamburger' ];

  connect() {
    window.onresize = () => {
      if (window.innerWidth > 990 && this.isMenuOpen()) {
        clearAllBodyScrollLocks();
        this.mainTarget.classList.remove('Navbar--menuOpen');
        this.hamburgerTarget.classList.remove('is-active');
        if (window.scrollY < 10) {
          this.mainTarget.classList.remove('Navbar--black');
        }
      }
    };
  }

  isMenuOpen() {
    return this.hamburgerTarget.classList.contains('is-active');
  }

  openMenu() {
    const isClosing = this.isMenuOpen();
    this.hamburgerTarget.classList.toggle('is-active');
    this.mainTarget.classList.toggle('Navbar--menuOpen');
    if (!this.mainTarget.classList.contains('Navbar--black')) {
      this.mainTarget.classList.add('Navbar--black');
    }
    if (isClosing && window.scrollY < 10) {
      this.mainTarget.classList.remove('Navbar--black');
    }
    if (!isClosing) {
      disableBodyScroll(this.mainTarget);
    } else {
      enableBodyScroll(this.mainTarget);
    }
  }
}
