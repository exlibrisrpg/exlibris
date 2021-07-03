import { Controller } from "stimulus"

export default class extends Controller {
  initialize() {
    this.resizeObserver = new ResizeObserver((entries) => {
      this.toggleOverflowClass(entries[0].target)
    })

    this.mutationObserver = new MutationObserver((entries) => {
      this.toggleOverflowClass(entries[0].target)
    })
  }

  connect() {
    this.resizeObserver.observe(this.element)
    this.mutationObserver.observe(this.element, { childList: true })
  }

  toggleOverflowClass(elem) {
    elem.classList.toggle("overflowing", elem.scrollWidth > elem.clientWidth)
  }
}
