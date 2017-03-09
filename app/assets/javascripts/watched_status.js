$(document).ready(function(){
  $('#movie-list').on('click', '.mark-watched', changeWatchedStatus)
  $('#movie-list').on('click', '.mark-unwatched', changeWatchedStatus)
});

function changeWatchedStatus() {
  var movieId = $(this).parent().parent()[0].rowIndex
  var currentStatus = $( '#watched-' + movieId )[0].innerText
  var that = this
  if(currentStatus == "false"){
    changeButtonToWatched(movieId, that)
  } else {
    changeButtonToUnwatched(movieId, that)
  }

  changeDbStatus(movieId, currentStatus)
}

function changeButtonToWatched(movieId, that) {
  $(that)[0].innerText = "Mark as Unwatched"
  $( '#watched-' + movieId )[0].innerText = "true"
  $(that).parent().parent().removeClass('false').addClass('true')
}

function changeButtonToUnwatched(movieId, that) {
  $(that)[0].innerText = "Mark as Watched"
  $( '#watched-' + movieId )[0].innerText = "false"
  $(that).parent().parent().removeClass('true').addClass('false')
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