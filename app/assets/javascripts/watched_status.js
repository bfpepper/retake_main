$(document).ready(function(){
  $('#movie-list').on('click', '.mark-watched', changeWatchedStatus)
  $('#movie-list').on('click', '.mark-unwatched', changeWatchedStatus)
  $('.search-watched').on('click', getWatchedMovies)
  $('.search-unwatched').on('click', getUnwatchedMovies)
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

function getWatchedMovies() {
  var movies = $.ajax({
    url: "/api/v1/movies",
    method: 'GET',
    data: {status: true},
  })

  redrawPage(movies)
};

function getUnwatchedMovies() {
  var movies = $.ajax({
    url: "/api/v1/movies",
    method: 'GET',
    data: {status: false},
  })

  redrawPage(movies)
};

function redrawPage(movies) {
//   debugger;
//   $()
//   '
//   <table>
//     <thead>
//       <tr>
//         <th>Title</th>
//         <th>Note</th>
//         <th>Watched?</th>
//         <th>Edit</th>
//         <th>Mark Watched Status</th>
//       </tr>
//     </thead>
//     <tbody id="movie-list">
//       <% if @movies %>
//         <% @movies.each do |movie| %>
//           <tr class=<%= color_output(movie.watched) %>><td><%= movie.title %></td>
//           <td><%= movie.note %></td>
//           <td id=<%= "watched-#{movie.id}" %>><%= movie.watched %></td>
//           <td><%= link_to "Edit", edit_movie_path(movie) %></td>
//           <% if movie.watched == false %>
//             <td><button type="button" class="mark-watched" id=<%= "#{movie.id}" %>>Mark as Watched</button></td></tr>
//           <% else %>
//             <td><button type="button" class="mark-watched" id=<%= "#{movie.id}" %>>Mark as Unwatched</button></td></tr>
//           <% end %>
//         <% end %>
//       <% end %>
//     </tbody>
//   </table>
// '
}
