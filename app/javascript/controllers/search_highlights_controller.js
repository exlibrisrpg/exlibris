import { Controller } from "@hotwired/stimulus"
import { annotate, annotationGroup } from "rough-notation"

export default class extends Controller {
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
    this.marks.forEach((element) => {
      element.style.backgroundColor = null
      element.annotation.hide()
    })
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

        const initialStyles = window.getComputedStyle(element)

        var highlightColor = initialStyles.backgroundColor
        if (highlightColor == this.transparent) {
          console.warn(
            "Applying search highlights with --color-foreground-translucent is deprecated. Please set a background-color.",
            element
          )
          highlightColor = "var(--color-foreground-translucent)"
        } else {
          element.intialBackgroundColor = highlightColor
        }

        element.parentNode.style.position = "relative"
        element.style.backgroundColor = "transparent"
        const annotation = annotate(element, {
          animationDuration: 800,
          color: highlightColor,
          iterations: 3,
          multiline: true,
          type: "highlight"
        })
        element.annotation = annotation
        return annotation
      })
    }

    return this._markAnnotations
  }
}
