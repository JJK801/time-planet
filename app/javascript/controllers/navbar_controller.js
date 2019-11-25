import { Controller } from 'stimulus';
import {disableBodyScroll, enableBodyScroll, clearAllBodyScrollLocks} from 'body-scroll-lock';

export default class extends Controller {
  static targets = [ 'hamburger' ];

  connect() {
    this.hamburgerActiveClass = 'is-active';
    this.darkModeClass = 'Navbar--dark';
    this.menuOpenClass = 'Navbar--menuOpen';
    this.toggleDarkModeOnScroll();
  }

  closeMenuOnLargeBreakpoint() {
    if (window.innerWidth > 990 && this.isMenuOpen()) {
      clearAllBodyScrollLocks();
      this.element.classList.remove(this.menuOpenClass);
      this.hamburgerTarget.classList.remove(this.hamburgerActiveClass);
      if (this.isWindowAtTheTop()) {
        this.element.classList.remove(this.darkModeClass);
      }
    }
  }

  toggleDarkModeOnScroll() {
    if (!this.isWindowAtTheTop()) {
      this.element.classList.add(this.darkModeClass);
    } else {
      this.element.classList.remove(this.darkModeClass);
    }
  }

  isMenuOpen() {
    return this.hamburgerTarget.classList.contains(this.hamburgerActiveClass);
  }

  isWindowAtTheTop() {
    return window.scrollY < 10;
  }

  toggleMenu() {
    const isClosingMenu = this.isMenuOpen();
    this.hamburgerTarget.classList.toggle(this.hamburgerActiveClass);
    this.element.classList.toggle(this.menuOpenClass);
    if (!this.element.classList.contains(this.darkModeClass)) {
      this.element.classList.add(this.darkModeClass);
    }
    if (isClosingMenu && this.isWindowAtTheTop()) {
      this.element.classList.remove(this.darkModeClass);
    }
    this.toggleScrollOnBody(isClosingMenu);
  }

  toggleScrollOnBody(isClosingMenu) {
    if (isClosingMenu) {
      enableBodyScroll(this.element);
    } else {
      disableBodyScroll(this.element);
    }
  }
}
