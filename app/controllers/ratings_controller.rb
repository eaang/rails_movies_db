class RatingsController < ApplicationController
  def update
    @rating = Rating.find(params[:id])
    @movie = @rating.movie
    if @rating.update(rating_params)
      redirect_to @movie, notice: "Rating successfully updated."
    else
      render @movie
    end
  end
end
