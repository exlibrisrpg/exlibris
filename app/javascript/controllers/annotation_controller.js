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

  annotateElement(element, options) {
    element.parentNode.style = "position: relative;"
    const annotation = annotate(element, options)
    element.annotation = annotation
    return annotation
  }

  annotateElements(elements, options) {
    return [...elements].map((element) => {
      return this.annotateElement(element, options)
    })
  }

  annotateElementsIndividually(elements, options) {
    this.annotateElements(elements, options).forEach((element) =>
      element.show()
    )
  }

  annotateElementsAsGroup(elements, options) {
    const observer = new IntersectionObserver((entries) => {
      const revealedEntries = entries.filter(
        (entry) => entry.intersectionRatio > 0
      )

      annotationGroup(
        revealedEntries.map((entry) => entry.target.annotation)
      ).show()
    })

    ;[...elements].forEach((element) => {
      const annotation = this.annotateElement(element, options)
      observer.observe(element)
    })
  }
}
