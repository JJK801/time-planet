import { Controller } from 'stimulus';
import {disableBodyScroll, enableBodyScroll, clearAllBodyScrollLocks} from 'body-scroll-lock';

export default class extends Controller {
  static targets = [ 'form', 'email', 'link' ];

  connect() {
    this.formOpenClass = 'AssociateForm--open';
    clearAllBodyScrollLocks();
  }

  closeForm() {
    this.formTarget.classList.remove(this.formOpenClass);
    enableBodyScroll(this.formTarget);
  }

  openForm() {
    this.formTarget.classList.add(this.formOpenClass);
    this.emailTarget.focus();
    disableBodyScroll(this.formTarget);
  }

  validate(event) {
    event.preventDefault();
    this.emailTarget.blur();
    if (this.emailTarget.validity.valid) {
      const email = this.emailTarget.value;
      const url = this.linkTarget.href;
      window.open(`${url}?mail=${email}`, '_blank');
    }
  }
}
