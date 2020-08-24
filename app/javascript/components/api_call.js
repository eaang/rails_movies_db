const apiCall = () => {
  const input = document.querySelector("#movie-test-input")
  const button = document.querySelector("#movie-test-button")
  const check = document.querySelector("#movie-test-result")
  const url = `http://www.omdbapi.com/?apikey=${gon.omdb}&t=`
  button.addEventListener("click", (e) => {
    e.preventDefault();
    const title = input.value.replace(/\s/g, '+');
    fetch(url + title)
      .then(response => response.json())
      .then(data => {
        check.innerHTML = ""
        check.innerHTML = `
          <strong>Title:</strong> ${data.Title}<br>
          <strong>Plot:</strong> ${data.Plot}
        `
      })
  })
};

export { apiCall };
