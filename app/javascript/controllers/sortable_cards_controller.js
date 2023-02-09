import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";

// Connects to data-controller="sortable-cards"
export default class extends Controller {
  connect() {
    Sortable.create(this.element, {
      ghostClass: "ghost",
      group: "cards",
      handle: ".handle",
      animation: 150,
      onEnd: (event) => {
        // Sends an AJAX request to update the spot_places for each spot
        if (event.to.dataset.row === event.from.dataset.row) {
          this.updateSpots(event.to);
        } else {
          // when a spot is moved from one row to another
          this.updateSpots(event.to);
          this.updateSpots(event.from);
        }
        console.log(event);
      },
    });
  }

  updateSpots(rowElement) {
    let cards = [];
    let rank = 1;
    const cardElements = rowElement.querySelectorAll(".card-spot");
    cardElements.forEach((element) => {
      cards.push({
        id: element.dataset.id,
        rank: rank,
        row_number: parseInt(rowElement.dataset.row, 10),
      });
      rank++;
    });
    console.log(cards);
    const url = "/spots/update_all";
    fetch(url, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ spots: cards }),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
      });
  }
}
