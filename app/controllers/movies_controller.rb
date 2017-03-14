class MoviesController < ApplicationController

  def index
    @movie = Movie.new
    if current_user
      @movies = Movie.where(user_id: current_user.id).order(:id)
    end
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user_id = current_user.id
    if @movie.title.include?("\\cc:") && @movie.save
      @movie.title = params[:movie][:title].split(" \\cc: ")[0].capitalize
      @movie.note = params[:movie][:note].capitalize
      @movie.save
      email = params[:movie][:title].split(" \\cc: ")[1]
      MovieNotifierMailer.movie_email(email, @movie.title).deliver_now
      redirect_to root_path
    elsif @movie.save
      @movie.title = params[:movie][:title].capitalize
      @movie.note = params[:movie][:note].capitalize
      @movie.save
      redirect_to root_path
    else
      render file: 'public/404.html'
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to root_path
    else
      redirect_to edit_movie_path(@movie)
      flash[:notice] = "Sorry, you need to have a title"
    end
  end


  private

  def movie_params
    params.require(:movie).permit(:title, :note, :user_id, :watched)
  end

end
