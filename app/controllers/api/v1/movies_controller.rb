class Api::V1::MoviesController < Api::V1::ApiController

  def update
    movie = Movie.find(params[:id])
    movie.update(watched: params[:watched])
    render json: movie, status: 204
  end

  def index
    binding.pry
    @movies = Movie.where(user_id: current_user.id).order('title')
    render json: @movies
  end

end
