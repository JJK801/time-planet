import { Controller } from 'stimulus';
import {disableBodyScroll, enableBodyScroll, clearAllBodyScrollLocks} from 'body-scroll-lock';

export default class extends Controller {
  static targets = [ 'form', 'email' ];

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
    if (this.emailTarget.validity.valid) {
      const email = this.emailTarget.value;
      window.open(`${event.target.href}?mail=${email}`, '_blank');
    }
  }
}
