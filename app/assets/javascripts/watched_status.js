$(document).ready(function(){
  $('#movie-list').on('click', '.mark-watched', changeWatchedStatus)
  $('#movie-list').on('click', '.mark-unwatched', changeWatchedStatus)
  $('.search-watched').on('click', getWatchedMovies)
  $('.search-unwatched').on('click', getUnwatchedMovies)
  $('#movie-search').on('keyup', filterResults)
  $('.search-alpha').on('click', filterAlpha)
});

function filterAlpha() {
  return $.ajax({
    url: "/api/v1/movies/",
    method: 'GET'
  }).done(function(data){
    $('#movie-list').html('')
    for (var i = 0; i < data.length; i++) {
      var status = null
      var button = null
      if(data[i].watched == false) {
        viewStatus = "watched"
        status = "mark-watched btn btn-warning"
      } else {
        viewStatus = "unwatched"
        status = "mark-unwatched btn btn-primary"
      }
      $('#movie-list').append('<tr id=' + data[i].id + ' class=' + data[i].watched +
                              '><td class="movie-title">' + data[i].title + '</td>' +
                              '<td class="movie-note">' + data[i].note + '</td>' +
                              '<td id=watched-' + data[i].id + '>' + data[i].watched + '</td>' +
                              '<td><a href="/movies/' + data[i].id + '/edit">Edit</a></td>' +
                              '<td><button type="button" class=' + status + " " + 'id=' + data[i].id +
                              '>Mark as ' + viewStatus + '</button></td>');
    }
  }).fail(function(error){
    console.error(err);
  })
}


function filterResults(e) {
  e.preventDefault();
  var filter = $( "#movie-search" ).val().toLowerCase();
  $("#movie-list").children().each(function(){

    var title = $(this).find('.movie-title').text().toLowerCase();
    var note = $(this).find('.movie-note').text().toLowerCase();

    if (title.includes(filter) || note.includes(filter)) {
      $(this).show()
    } else {
      $(this).hide()
    };
  });
}

function getWatchedMovies() {
    $('#movie-list').children().children().each(function() {
    var readStatus = $(this).siblings().siblings()[4].innerText;
    if (readStatus.includes("Mark as unwatched")) {
      $(this).show()
    }  else {
      $(this).hide()
    };
  });
}

function getUnwatchedMovies() {
  $('#movie-list').children().children().each(function() {
    var readStatus = $(this).siblings().siblings()[4].innerText;
    if (readStatus.includes("Mark as watched")) {
      $(this).show()
    }  else {
      $(this).hide()
    };
  });
}
function changeWatchedStatus() {
  var movieId = $(this).parent().parent()[0].id
  var currentStatus = $( '#watched-' + movieId )[0].innerText
  var that = this
  var title = $(this).parent().parent().find('.movie-title').text()
  var note = $(this).parent().parent().find('.movie-note').text()
  if(currentStatus == "false"){
    changeButtonToWatched(movieId, that, note, title)
  } else {
    changeButtonToUnwatched(movieId, that, note, title)
  }

  changeDbStatus(movieId, currentStatus)
}

function changeButtonToWatched(movieId, that, note, title) {
  $(that).parent().parent().html(null)
  $('#movie-list').append('<tr id=' + movieId +
                          ' class=true><td class="movie-title">' + title +'</td>' +
                          '<td class="movie-note">' + note + '</td>' +
                          '<td id=watched-' + movieId + '>true</td>' +
                          '<td><a href="/movies/' + movieId + '/edit">Edit</a></td>' +
                          '<td><button type="button" class="mark-unwatched btn btn-primary" id=' + movieId + '>Mark as unwatched</button></td>')
}

function changeButtonToUnwatched(movieId, that, note, title) {
  $(that).parent().parent().html(null)
  $('#movie-list').append('<tr id=' + movieId +
                          ' class=false><td class="movie-title">' + title +'</td>' +
                          '<td class="movie-note">' + note + '</td>' +
                          '<td id=watched-' + movieId + '>false</td>' +
                          '<td><a href="/movies/' + movieId + '/edit">Edit</a></td>' +
                          '<td><button type="button" class="mark-watched btn btn-warning" id=' + movieId + '>Mark as watched</button></td>')
}

function changeDbStatus(movieId, currentStatus) {
  var status = null
  if(currentStatus == "false") {
    status = true
  } else {
    status = false
  }

  $.ajax({
    url: "/api/v1/movies/" + movieId,
    method: 'PATCH',
    data: { watched: status },
  })
};
