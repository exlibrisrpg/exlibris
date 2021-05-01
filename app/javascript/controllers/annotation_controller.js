import { Controller } from "stimulus"
import { annotate, annotationGroup } from "rough-notation"

export default class extends Controller {
  initialize() {
    const searches = document.querySelectorAll(
      ".search--field, .search--submit"
    )
    this.searchAnnotations = this.annotateElements(searches, {
      type: "highlight",
      color: "var(--color-highlight, var(--color-action-translucent))",
      iterations: 1,
      animationDuration: 400
    })

    const links = document.querySelectorAll("a")
    this.linkAnnotations = this.annotateElements(links, {
      type: "highlight",
      color: "var(--color-highlight, var(--color-action-translucent))",
      iterations: 1,
      animate: false
    })

    const marks = document.querySelectorAll("mark")
    this.markAnnotations = this.annotateElements(marks, {
      type: "highlight",
      color: "var(--color-foreground-translucent)",
      animationDuration: 800,
      iterations: 3
    })
  }

  connect() {
    this.showAnnotations(this.searchAnnotations)
    this.showAnnotations(this.linkAnnotations)
    this.showAnnotationsOnPageScroll(this.markAnnotations)
  }

  disconnect() {
    this.hideAnnotations([
      ...this.searchAnnotations,
      ...this.linkAnnotations,
      ...this.markAnnotations
    ])
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

  showAnnotations(annotations) {
    annotations.forEach((annotation) => annotation.show())
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
