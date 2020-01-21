import { Controller } from 'stimulus';
import {disableBodyScroll, enableBodyScroll, clearAllBodyScrollLocks} from 'body-scroll-lock';

export default class extends Controller {
  static targets = [ 'hamburger' ];

  connect() {
    this.hamburgerActiveClass = 'is-active';
    this.stickyMenuClass = 'Navbar--sticky';
    this.darkMenuClass = 'Navbar--dark';
    this.menuOpenClass = 'Navbar--menuOpen';
    this.toggleDarkModeOnScroll();
    clearAllBodyScrollLocks();
  }

  closeMenuOnLargeBreakpoint() {
    if (window.innerWidth > 990 && this.isMenuOpen()) {
      clearAllBodyScrollLocks();
      this.element.classList.remove(this.menuOpenClass);
      this.hamburgerTarget.classList.remove(this.hamburgerActiveClass);
      if (this.isWindowAtTheTop()) {
        this.element.classList.remove(this.darkMenuClass);
      }
    }
  }

  toggleDarkModeOnScroll() {
    if (this.element.classList.contains('Navbar--notSticky')) {
      return;
    } else if (!this.isWindowAtTheTop()) {
      this.element.classList.add(this.stickyMenuClass, this.darkMenuClass);
    } else {
      this.element.classList.remove(this.stickyMenuClass, this.darkMenuClass);
    }
  }

  isMenuOpen() {
    return this.hamburgerTarget.classList.contains(this.hamburgerActiveClass);
  }

  isWindowAtTheTop() {
    return window.scrollY < 64;
  }

  toggleMenu() {
    const isClosingMenu = this.isMenuOpen();
    this.hamburgerTarget.classList.toggle(this.hamburgerActiveClass);
    this.element.classList.toggle(this.menuOpenClass);
    if (!this.element.classList.contains(this.darkMenuClass)) {
      this.element.classList.add(this.darkMenuClass);
    }
    if (isClosingMenu && this.isWindowAtTheTop()) {
      this.element.classList.remove(this.darkMenuClass);
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
