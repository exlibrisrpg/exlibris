import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static classes = ["hidden"]
  static values = { startsHidden: Boolean }

  initialize() {
    this.startsHiddenValue = this.element.classList.contains(this.hiddenClass)
  }

  connect() {
    this.element.classList.toggle(this.hiddenClass, !this.startsHiddenValue)
  }

  disconnect() {
    this.element.classList.toggle(this.hiddenClass, this.startsHiddenValue)
  }
}
