import { Controller } from "@hotwired/stimulus"
import { annotate } from "rough-notation"

export default class extends Controller {
  static values = {
    animate: Boolean
  }

  async connect() {
    if (document.fonts != undefined) {
      await document.fonts.ready
    }

    this.annotation.show()
  }

  disconnect() {
    this.annotation.hide()
  }

  redraw() {
    this.annotation.show()
  }

  get annotation() {
    if (this.element.annotation == undefined) {
      this.element.parentNode.style.position = "relative"
      this.element.annotation = annotate(this.element, this.annotationOptions)
    }

    return this.element.annotation
  }

  get annotationOptions() {
    return {
      animate: this.animateValue,
      animationDuration: 400,
      color: "var(--color-highlight, var(--color-action))",
      iterations: 1,
      multiline: true,
      type: "highlight"
    }
  }
}
