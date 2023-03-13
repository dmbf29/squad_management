import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="group-submit"
export default class extends Controller {
  static targets = ["btn"];
  connect() {}

  submit() {
    this.btnTargets.forEach((btn) => {
      btn.click();
    });
  }
}
