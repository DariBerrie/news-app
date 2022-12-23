import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comments"
export default class extends Controller {
  static targets = ["form", "comments", "test"]
  connect() {
    console.log("Comments controller connected.")
    this.csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
  }

  update(event) {
    event.preventDefault()
    const url = this.formTarget.action
    fetch(url, {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-Token": this.csrfToken },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)

        if (data.inserted_comment) {
          const alert = `
          <div id="comment-alert" class="alert alert-success alert-dismissible fade show" role="alert"
               style="margin-top:8px;">
            <strong>Thanks for sharing!</strong> Your comment posted successfully.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
          </div>
          `
          this.commentsTarget.insertAdjacentHTML('beforeend', data.inserted_comment)
          this.commentsTarget.insertAdjacentHTML('afterend', alert )
        }
        this.testTarget.innerHTML = data.form
        this.testTarget.scrollIntoView();
      })
  }
}
