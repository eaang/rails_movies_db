import $ from 'jquery';

const apiCall = () => {
  const button = document.querySelector("#movie_button")
  const url = `http://www.omdbapi.com/?apikey=${gon.omdb}&t=`
  if (button) {
    // movie data fields
    const movieName = document.querySelector("#movie_name")
    const movieDescription = document.querySelector("#movie_description")
    const movieYear = document.querySelector("#movie_year")
    const movieImdb = document.querySelector("#movie_imdb")
    const movieDirector = document.querySelector("#movie_director")
    const movieWriter = document.querySelector("#movie_writer")
    const movieProduction = document.querySelector("#movie_production")
    const movieAwards = document.querySelector("#movie_awards")
    const movieActors = document.querySelector("#movie_actors")
    const movieImdbrating = document.querySelector("#movie_imdbrating")
    const movieMetascore = document.querySelector("#movie_metascore")
    const movieRuntime = document.querySelector("#movie_runtime")
    const movieRated = document.querySelector("#movie_rated")
    const movieLanguage = document.querySelector("#movie_language")
    const movieCountry = document.querySelector("#movie_country")
    const moviePoster = document.querySelector("#movie_poster")
    const movieGenres = document.querySelector("#movie_genres")
    const poster = document.querySelector("#poster")

    button.addEventListener("click", (e) => {
      e.preventDefault();
      const title = movieName.value.replace(/\s/g, '+').replace('&', '%26');
      $('#movie_title').popover('hide')
      fetch(url + title)
        .then(response => response.json())
        .then(data => {
          if (data.Response === 'False') {
            poster.innerHTML = `<span class="align-self-center text-muted">Movie poster</span>`
            movieDescription.value = ''
            $('#movie_title').popover({
              trigger: 'manual',
              placement: 'top'
            });
            $('#movie_title').attr("data-content", data.Error).popover('show');
          } else {
            poster.innerHTML = `<img src="${data.Poster}" class="img-fluid">`
            movieName.value = data.Title
            movieDescription.value = data.Plot
            movieYear.value = data.Year
            movieImdb.value = data.imdbID
            movieDirector.value = data.Director
            movieWriter.value = data.Writer
            movieProduction.value = data.Production
            movieAwards.value = data.Awards
            movieActors.value = data.Actors
            movieImdbrating.value = data.imdbRating
            movieMetascore.value = data.Metascore
            movieRuntime.value = data.Runtime.match(/\d+/g)
            movieRated.value = data.Rated
            movieLanguage.value = data.Language
            movieCountry.value = data.Country
            movieGenres.value = data.Genre
            moviePoster.value = data.Poster
          }
        })
    })
  }
};

export { apiCall };
