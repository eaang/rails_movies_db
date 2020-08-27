class RatingsController < ApplicationController
  def change
    @rating = Rating.find_or_create_by(rating_params)
    @movie = @rating.movie
    if @rating.save
      current_user.id == 1 ? (@my_score = @movie.evan_rating) : (@my_score = @movie.case_rating)
      fail
      redirect_to @movie, notice: "Rating successfully updated."
    else
      render @movie
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def rating_params
    params.require(:rating).permit(
      :movie_id, :user_id, :score
    )
  end
end
