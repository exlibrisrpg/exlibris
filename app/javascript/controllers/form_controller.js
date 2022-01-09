import { Controller } from "@hotwired/stimulus"
import debounce from "lodash.debounce"

export default class extends Controller {
  static targets = ["form", "submit"]

  static values = {
    submitFrame: String
  }

  initialize() {
    this.submit = debounce(this.submit.bind(this), 200)
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
