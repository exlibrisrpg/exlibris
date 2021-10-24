import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static classes = ["hidden"]

  connect() {
    this.element.classList.add(this.hiddenClass)
  }

  disconnect() {
    this.element.classList.remove(this.hiddenClass)
  }
}
