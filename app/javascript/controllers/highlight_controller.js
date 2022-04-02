import { Controller } from "@hotwired/stimulus"
import { annotate } from "rough-notation"

export default class extends Controller {
  static values = {
    animate: Boolean,
    initialBackground: String,
    color: String
  }

  initialize() {
    const initialStyles = window.getComputedStyle(this.element)

    if (initialStyles.backgroundColor == this.transparent) {
      console.warn(
        "Applying highlights with --color-highlight is deprecated. Please set a background-color.",
        this.element
      )
      this.colorValue = "var(--color-highlight, var(--color-action))"
    } else {
      this.initialBackgroundValue = initialStyles.backgroundColor
      this.colorValue = this.initialBackgroundValue
    }
  }

  async connect() {
    // Wait for fonts to load before drawing highlights if supported by browser.
    // https://developer.mozilla.org/en-US/docs/Web/API/FontFaceSet/ready
    if (document.fonts != undefined) {
      await document.fonts.ready
    }

    this.element.style.backgroundColor = this.transparent

    this.annotation.show()
  }

  disconnect() {
    this.annotation.hide()

    this.element.style.backgroundColor = this.initialBackgroundValue
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
      color: this.colorValue,
      iterations: 1,
      multiline: true,
      type: "highlight"
    }
  }

  get transparent() {
    return "rgba(0, 0, 0, 0)"
  }
}
