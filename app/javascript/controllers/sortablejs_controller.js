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
        // Sends an AJAX request to update the spot_places for each spot
        if (event.to.dataset.id === event.from.dataset.id) {
          this.updatePlaces(event.to);
        } else {
          // when a player is moved from one spot to another
          this.updatePlaces(event.to);
          this.updatePlaces(event.from);
        }
      },
    });
  }

  updatePlaces(formElement) {
    let rows = [];
    let rank = 1;
    const rowElements = formElement.querySelectorAll(".spot-place-row");
    rowElements.forEach((element) => {
      rows.push({
        id: element.dataset.id,
        rank: rank,
        spot_id: formElement.dataset.id,
      });
      rank++;
    });
    console.log(rows);
    const url = `/spots/${formElement.dataset.id}/update_places`;
    fetch(url, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ places: rows }),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
      });
  }
}
