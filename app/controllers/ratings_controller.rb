class RatingsController < ApplicationController
  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(rating_params)
    @movie = Movie.friendly.find(params[:id])
    if @rating.save
      redirect_to @movie
    else
      render :new
    end
  end
end
