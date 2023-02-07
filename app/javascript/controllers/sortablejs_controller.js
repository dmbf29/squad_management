import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";

// Connects to data-controller="sortablejs"
export default class extends Controller {
  connect() {
    Sortable.create(this.element, {
      ghostClass: "ghost",
      group: "shared",
      handle: ".handle",
      animation: 150,
      onEnd: (event) => {
        // Send an AJAX request to update the spot_places
        // alert(`${event.oldIndex} moved to ${event.newIndex}`);
        console.log(`${event.oldIndex} moved to ${event.newIndex}`);
      },
    });
  }
}
