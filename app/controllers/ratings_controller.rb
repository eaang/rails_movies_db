class RatingsController < ApplicationController
  def change
    @rating = Rating.find_or_create_by(movie_id: rating_params[:movie_id], user_id: rating_params[:user_id])
    @movie = @rating.movie
    if rating_params[:score] == 'N/A'
      @rating.destroy
    else
      @rating.score = rating_params[:score]
      @rating.save
    end
    current_user.id == 1 ? (@my_score = @movie.evan_rating) : (@my_score = @movie.case_rating)
    redirect_to @movie
  end

  private

  # Only allow a list of trusted parameters through.
  def rating_params
    params.require(:rating).permit(
      :movie_id, :user_id, :score
    )
  end
end
