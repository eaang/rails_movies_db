import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "source", "form", "input" ]

  connect() {
    this.model        = this.data.get("model")       || "model"
    this.name         = this.data.get("name")        || "name"
    this.input_class  = this.data.get("input-class") || "input"
    this.original     = this.data.get("original")    || "original"
  }

  toggle() {
    if (!this.data.get("toggled") == 1) {
      this.sourceTarget.innerHTML = this.form()

      this.data.set("toggled", 1)
    }
  }

  close(event) {
    if ((this.element.contains(event.target) === false) &&
      this.data.get("toggled") == 1) {

      this.submit()
    }
  }

  submit() {
    this.formTarget.submit()
  }

  form() {
    return `
      <form action="${this.post_url}" accept-charset="UTF-8" data-remote="true" data-target="inline-edit.form" method="post">
        <input name="utf8" type="hidden" value="✓">
        <input type="hidden" name="_method" value="patch">
        <input type="hidden" name="authenticity_token" value="${this.authenticity_token}">
        <textarea type="text" name="${this.model}[${this.name}]" class="${this.input_class}" id="${this.model}_${this.name}" data-target="inline-edit.input" data-action="onblur->inline-edit#submit">${this.original}
        </textarea>
      </form>
    `
  }

  get input_value() {
    return this.sourceTarget.textContent
  }

  get post_url() {
    return window.location.pathname
  }

  get authenticity_token() {
    return document.querySelector("meta[name='csrf-token']").getAttribute("content");
  }
}