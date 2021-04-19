import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["links", "template", "form"]

  connect() {
    this.wrapperClass = this.data.get("wrapperClass") || "nested-fields"
  }

  addAssociation(event) {
    event.preventDefault()

    const content = this.templateTarget.innerHTML.replace(
      /NEW_RECORD/g,
      new Date().getTime()
    )
    this.formTarget.insertAdjacentHTML("beforeend", content)
  }

  removeAssociation(event) {
    event.preventDefault()

    const wrapper = event.target.closest("." + this.wrapperClass)

    if (wrapper.dataset.newRecord == "true") {
      this.removeNewAssociation(wrapper)
    } else {
      this.removeExistingAssociation(wrapper)
    }
  }

  removeNewAssociation(wrapper) {
    wrapper.remove()
  }

  removeExistingAssociation(wrapper) {
    console.log("remove existing association")
    wrapper.querySelector("input[name*='_destroy']").value = "true"
    wrapper.style.display = "none"
  }
}
