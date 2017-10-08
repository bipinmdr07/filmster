$(function(){
  $.ajax({
    url: 'https://api.themoviedb.org/3/search/movie?api_key=269682043d85ac69d89cdca6988cb2b9',
    data: {"query" : "superman"}
  })
  .done(function(data){
    displayMovies(data);
  });

  function displayMovies(data){
    let container = $("#movies");

    container.empty();
    let htmlString = "";
    let imageUrl = getBaseImageUrl();

    data['results'].forEach(function(movie){
      htmlString +=   `<img src= ${movie["poster_path"] == null? "assets/movie-poster.jpg" : imageUrl + "/" + movie["poster_path"]}>
                      <p>${movie["title"]}</p>
                      <p>${movie["overview"]}</p>`;
    });

    container.append(htmlString);
  }

  function getBaseImageUrl(){
    var url = "";
    var settings = {
      "async": false,
      "crossDomain": true,
      "url": "https://api.themoviedb.org/3/configuration?api_key=269682043d85ac69d89cdca6988cb2b9",
      "method": "GET",
      "headers": {},
      "data": "{}"
    }

    $.ajax(settings).done(function(response){
      url = response["images"]["base_url"] + response["images"]["poster_sizes"][3];
    });
    return url;
  }

  // searching movie feature
  let form = $("#movie-search");
  form.submit(function(e){
    e.preventDefault();

    $.ajax({
      url: "https://api.themoviedb.org/3/search/movie?api_key=269682043d85ac69d89cdca6988cb2b9",
      data: form.serialize()
    })
    .done(function(data){
      displayMovies(data);
    });
  });
})