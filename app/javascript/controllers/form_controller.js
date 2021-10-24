import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "submit"]

  static values = {
    submitFrame: String
  }

  submit() {
    if (this.hasSubmitFrameValue) {
      this.formTarget.dataset.turboFrame = this.submitFrameValue
    }

    this.submitTarget.click()

    if (this.hasSubmitFrameValue) {
      delete this.formTarget.dataset.turboFrame
    }
  }
}
