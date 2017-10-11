class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = Movie.find_or_initialize_by(tmdb_id: params[:tmdb_id])

    if @movie.new_record?
      # fetch movie data from api
      # debugger
      @fetched_movie = Tmdb::Movie.detail(params[:tmdb_id])

      # create a new movie Record
      @movie.title = @fetched_movie.title
      @movie.plot = @fetched_movie.overview
      @movie.release_date = @fetched_movie.release_date
      @movie.released = true if (@fetched_movie.release_date[0...4].to_i <= Time.now.year)
      @movie.runtime = @fetched_movie.runtime
      @movie.popularity = @fetched_movie.popularity
      @fetched_movie.genres.each do |x|
        @movie.genre += (x.name + ' ')
      end
      @movie.language = @fetched_movie.original_language
      @movie.budget = @fetched_movie.budget
      @movie.average_vote = @fetched_movie.vote_average
      @movie.vote_count = @fetched_movie.vote_count
      @movie.poster = @fetched_movie.poster_path
      @movie.homepage = @fetched_movie.homepage
      @movie.tmdb_id = @fetched_movie.id
      @movie.imdb_id = @fetched_movie.imdb_id

      @movie.save!
    end

    # create a new review and connect it to the current user and movie
    @review = current_user.reviews.new(review_params.merge(movie_id: @movie.id))

    if @review.save
      flash[:success] = "Review saved!"
      redirect_to root_path
    else
      flash[:danger] = "Woops! It seems there was an error."
      redirect_to root_path
    end

  end
end

private
def review_params
  params.require(:review).permit(:comment)
end
