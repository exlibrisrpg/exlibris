import { Controller } from "stimulus"
import { annotate, annotationGroup } from "rough-notation"

export default class extends Controller {
  initialize() {
    const marks = this.element.querySelectorAll("mark")
    this.markAnnotations = this.annotateElements(marks, {
      type: "highlight",
      color: "var(--color-foreground-translucent)",
      animationDuration: 800,
      iterations: 3
    })
  }

  connect() {
    this.showAnnotationsOnPageScroll(this.markAnnotations)
  }

  disconnect() {
    this.hideAnnotations([...this.markAnnotations])
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

  annotateElements(elements, options) {
    return [...elements].map((element) => {
      return this.annotateElement(element, options)
    })
  }

  showAnnotationsOnPageScroll(elements) {
    const observer = new IntersectionObserver((entries) => {
      const revealedEntries = entries.filter(
        (entry) => entry.intersectionRatio > 0
      )

      annotationGroup(
        revealedEntries.map((entry) => entry.target.annotation)
      ).show()
    })

    ;[...elements].forEach((element) => {
      observer.observe(element._e)
    })
  }

  hideAnnotations(annotations) {
    annotations.forEach((annotation) => annotation.hide())
  }
}
