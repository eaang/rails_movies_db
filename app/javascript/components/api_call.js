const apiCall = () => {
  const input = document.querySelector("#movie-test-input")
  input.addEventListener("click", () => {
    console.log("I'm clicked!")
  })
};

export { apiCall };
