import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  disable() {
    this.element.setAttribute("disabled", "")
  }
}
