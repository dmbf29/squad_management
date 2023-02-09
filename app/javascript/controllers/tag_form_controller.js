import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="tag-form"
export default class extends Controller {
  connect() {}

  submit(event) {
    event.preventDefault();
    fetch(this.element.action, {
      method: "POST",
      headers: { Accept: "application/json" },
      body: new FormData(this.element),
    })
      .then((response) => response.text())
      .then((data) => {
        this.element.outerHTML = data;
      });
  }

  destroy(event) {
    event.preventDefault();
    console.log(this.element.dataset.id);
    fetch(this.element.href, {
      method: "DELETE",
      headers: { Accept: "application/json" },
      body: JSON.stringify({ id: this.element.dataset.id }),
    })
      .then((response) => response.text())
      .then((data) => {
        this.element.parentElement.outerHTML = data;
      });
  }
}
