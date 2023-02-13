import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="activate-button"
export default class extends Controller {
  static targets = ["input", "button"];

  connect() {
    console.log(this.inputTarget);
    console.log(this.buttonTarget);
  }
}
