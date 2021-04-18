import { Controller } from "stimulus"
import { annotate, annotationGroup } from "rough-notation"

export default class extends Controller {
  connect() {
    const searches = document.querySelectorAll(".search")
    this.annotateElementsIndividually(searches, {
      type: "highlight",
      color: "var(--color-action-translucent)",
      iterations: 1,
      animationDuration: 400
    })

    const links = document.querySelectorAll("a")
    this.annotateElementsIndividually(links, {
      type: "highlight",
      color: "var(--color-action-translucent)",
      iterations: 1,
      animate: false
    })

    const marks = document.querySelectorAll("mark")
    this.annotateElementsAsGroup(marks, {
      type: "highlight",
      color: "var(--color-foreground-translucent)",
      animationDuration: 800,
      iterations: 3
    })
  }

  annotateElements(elements, options) {
    return [...elements].map((element) => {
      element.parentNode.style = "position: relative;"
      return annotate(element, options)
    })
  }

  annotateElementsIndividually(elements, options) {
    this.annotateElements(elements, options).forEach((element) =>
      element.show()
    )
  }

  annotateElementsAsGroup(elements, options) {
    annotationGroup(this.annotateElements(elements, options)).show()
  }
}
