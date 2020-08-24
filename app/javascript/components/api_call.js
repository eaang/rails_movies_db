const apiCall = () => {
  const input = document.querySelector("#movie-test-input")
  const button = document.querySelector("#movie-test-button")
  const url = `http://www.omdbapi.com/?apikey=${gon.omdb}&t=`
  button.addEventListener("click", (e) => {
    e.preventDefault();
    const title = input.value.replace(/\s/g, '+');
    console.log(url);
  })
};

export { apiCall };
