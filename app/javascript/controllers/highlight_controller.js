import { Controller } from "stimulus"
import { annotate, annotationGroup } from "rough-notation"

export default class extends Controller {
  static values = {
    animate: Boolean
  }

  initialize() {
    this.annotation = this.annotateElement(this.element, {
      animate: this.animateValue,
      animationDuration: 400,
      color: "var(--color-highlight, var(--color-action))",
      iterations: 1,
      multiline: true,
      type: "highlight"
    })
  }

  connect() {
    if (document.fonts != undefined) {
      document.fonts.ready.then(() => {
        this.annotation.show()
      })
    } else {
      this.annotation.show()
    }
  }

  disconnect() {
    this.annotation.hide()
  }

  annotateElement(element, options) {
    if (element.annotation != undefined) {
      return element.annotation
    }

    element.parentNode.style.position = "relative"
    const annotation = annotate(element, options)
    element.annotation = annotation
    return annotation
  }
}
