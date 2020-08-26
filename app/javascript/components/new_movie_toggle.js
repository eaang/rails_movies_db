const toggler = () => {
  const toggle = document.querySelector("#new-movie-toggle")

  const changeField = () => {
    const fields = document.querySelector("#movieFields")
    if (fields.classList.contains('show')) {
      toggle.innerHTML = 'show all fields'
    } else {
      toggle.innerHTML = 'hide all fields'
    }
  }

  if (toggle) {
    toggle.addEventListener("click", () => {
      changeField()
      const closeToggle = document.querySelector("#new-movie-close")
      closeToggle.addEventListener("click", () => {
        changeField()
      })
    })
  }
}

export { toggler };