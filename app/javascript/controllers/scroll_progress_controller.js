import { Controller } from "stimulus"
import scrollama from "scrollama"

export default class extends Controller {
  initialize() {
    this.scroller = scrollama()
      .setup({ step: [this.element], progress: true })
      .onStepProgress(({ progress }) => this.updateProgress(progress))
  }

  connect() {
    this.scroller.enable()
  }

  disconnect() {
    this.scroller.disable()
  }

  resize() {
    this.scroller.resize()
  }

  updateProgress(progress) {
    this.element.style.setProperty("--progress", progress)
  }
}
