import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="activate-button"
export default class extends Controller {
  static targets = ["button"];

  connect() {
    // console.log(this.buttonTarget);
  }

  toggle(event) {
    const inputElement = event.currentTarget;
    if (inputElement.value === "") {
      this.buttonTarget.disabled = true;
    } else {
      this.buttonTarget.disabled = false;
    }
  }
}
