import { Controller } from "stimulus"

export default class extends Controller {
  initialize() {
    const resolution = 1000
    this.options = {
      rootMargin: "0px 0px 40% 0px",
      threshold: [...Array(resolution).keys()].map((x) => x / resolution)
    }
    this.observer = new IntersectionObserver((entries, observer) => {
      entries.forEach((entry) => {
        entry.target.style.setProperty(
          "--progress",
          1 - entry.intersectionRatio
        )
      })
    }, this.options)
  }

  connect() {
    this.observer.observe(this.element)
  }

  disconnect() {
    this.observer.disconnect()
  }
}
