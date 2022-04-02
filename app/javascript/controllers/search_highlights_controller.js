import { Controller } from "@hotwired/stimulus"
import { annotate, annotationGroup } from "rough-notation"

export default class extends Controller {
  static values = {
    color: String
  }

  initialize() {
    if (this.colorValue == "") {
      console.warn(
        "Applying search highlights with --color-foreground-translucent is deprecated. Please set data-search-highlights-color-value.",
        this.element
      )
      this.colorValue = "var(--color-foreground-translucent)"
    }
  }

  async connect() {
    // Wait for fonts to load before drawing highlights if supported by browser.
    // https://developer.mozilla.org/en-US/docs/Web/API/FontFaceSet/ready
    if (document.fonts != undefined) {
      await document.fonts.ready
    }

    this.showAnnotationsOnPageScroll()
  }

  disconnect() {
    this.hideAnnotations()
  }

  showAnnotationsOnPageScroll() {
    const observer = new IntersectionObserver((entries) => {
      const revealedEntries = entries.filter(
        (entry) => entry.intersectionRatio > 0
      )

      annotationGroup(
        revealedEntries.map((entry) => entry.target.annotation)
      ).show()
    })

    this.markAnnotations.forEach((element) => {
      observer.observe(element._e)
    })
  }

  hideAnnotations() {
    this.markAnnotations.forEach((annotation) => annotation.hide())
  }

  get marks() {
    return this.element.querySelectorAll("mark")
  }

  get markAnnotations() {
    if (this._markAnnotations == undefined) {
      this._markAnnotations = [...this.marks].map((element) => {
        if (element.annotation != undefined) {
          return element.annotation
        }

        element.parentNode.style.position = "relative"
        const annotation = annotate(element, this.annotationOptions)
        element.annotation = annotation
        return annotation
      })
    }

    return this._markAnnotations
  }

  get annotationOptions() {
    return {
      animationDuration: 800,
      color: this.colorValue,
      iterations: 3,
      multiline: true,
      type: "highlight"
    }
  }
}
