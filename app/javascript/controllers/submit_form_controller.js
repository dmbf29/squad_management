import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="submit-form"
export default class extends Controller {
  static targets = ["btn"];

  connect() {}

  submit() {
    this.btnTarget.click();
  }
}
