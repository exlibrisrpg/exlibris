import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    this.element.style.visibility = "hidden"
  }

  disconnect() {
    this.element.style.visibility = "visible"
  }
}
