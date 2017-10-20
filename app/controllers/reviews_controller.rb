class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = MovieBuilder.new(tmdb_id: params[:tmdb_id]).build!



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
