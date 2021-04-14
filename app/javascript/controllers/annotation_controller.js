import { Controller } from "stimulus"
import { annotate, annotationGroup } from "rough-notation"

export default class extends Controller {
  connect() {
    const links = document.querySelectorAll("a")
    links.forEach((link) =>
      annotate(link, {
        type: "highlight",
        color: "var(--color-action-translucent)",
        iterations: 1,
        animate: false
      }).show()
    )

    const marks = document.querySelectorAll("mark")
    annotationGroup(
      [...marks].map((mark) =>
        annotate(mark, {
          type: "highlight",
          color: "var(--color-foreground-translucent)",
          animationDuration: 800,
          iterations: 3
        })
      )
    ).show()
  }
}
