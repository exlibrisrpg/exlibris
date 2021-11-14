import { Controller } from "@hotwired/stimulus"
import Combobox from "@github/combobox-nav"

export default class extends Controller {
  static classes = ["hidden"]
  static targets = ["collection", "input", "list"]

  connect() {
    this.stop()
  }

  disconnect() {
    this.combobox?.destroy()
  }

  start() {
    this.combobox?.destroy()

    this.listTarget.classList.remove(this.hiddenClass)
    this.combobox = new Combobox(this.inputTarget, this.listTarget)
    this.combobox.start()
  }

  stop() {
    this.listTarget.classList.add(this.hiddenClass)
    this.combobox?.stop()
    this.dispatch("stopped")
  }

  add(event) {
    // Add selected option to collection
    const option = event.target.cloneNode(true)
    option.querySelectorAll("svg.rough-annotation").forEach((annotation) => {
      annotation.remove()
    })
    this.collectionTarget.append(option)

    // Reset the combobox
    this.combobox.clearSelection()
    while (this.listTarget.firstChild) {
      this.listTarget.removeChild(this.listTarget.firstChild)
    }
    this.stop()

    // Reset the input
    this.inputTarget.value = ""
    this.inputTarget.focus()
  }

  remove(event) {
    // Remove option from collection
    event.target.closest(`[role="option"]`).remove()
  }

  listTargetConnected() {
    this.start()
  }
}
