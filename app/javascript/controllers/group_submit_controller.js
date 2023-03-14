import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="group-submit"
export default class extends Controller {
  static targets = ["btn", "link"];
  connect() {}

  submit() {
    this.btnTargets.forEach((btn) => {
      btn.click();
    });
  }

  destroy() {
    this.linkTargets.forEach((btn) => {
      btn.click();
    });
  }
}
