import { Controller } from 'stimulus';

export default class extends Controller {

  connect() {
    this.validInputClass = 'Form-input--valid';
    this.invalidInputClass = 'Form-input--invalid';
  }

  validate(event) {
    if (event.target.validity.valid) {
      this.makeInputValid(event.target);
    } else {
      this.makeInputInvalidAndDisplayError(event.target);
    }
  }

  makeInputInvalidAndDisplayError(input) {
    input.classList.remove(this.validInputClass);
    input.classList.add(this.invalidInputClass);

    if (this.isErrorSpanPresent(input)) {
      this.replaceErrorSpanText(input, this.errorMessage(input));
    } else {
      input.insertAdjacentHTML(
        'afterend',
        `<span class="Form-error">${this.errorMessage(input)}</span>`
      )
    }
  }

  makeInputValid(input) {
    input.classList.remove(this.invalidInputClass);
    input.classList.add(this.validInputClass);
    if (this.isErrorSpanPresent(input)) {
      this.replaceErrorSpanText(input, '');
    }
  }

  errorMessage(input) {
    const [model, attribute] = input.name.slice(0, -1).split('[');
    const format = this.errorMessageFormat(input);
    const attributeTranslation = I18n["activerecord"]["attributes"][`${model}`][`${attribute}`];
    return format.replace(/%{attribute}/gi, attributeTranslation);
  }

  errorMessageFormat(input) {
    if (I18n["errors"] ===  undefined) {
      return 'Veuillez remplir ce champ';
    } else if (input.validity.valueMissing ===  true) {
      return I18n["errors"]["messages"]["blank"];
    } else if (input.validity.typeMismatch ===  true) {
      return I18n["errors"]["messages"]["invalid"];
    } else {
      return '';
    }
  }

  isErrorSpanPresent(input) {
    return input.parentNode.getElementsByClassName('Form-error').length > 0
  }

  replaceErrorSpanText(input, text) {
    input.parentNode.getElementsByClassName('Form-error')[0].innerHTML = text;
  }
}
