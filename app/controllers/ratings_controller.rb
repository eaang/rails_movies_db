class RatingsController < ApplicationController
  def new
    @rating = Rating.new
    @movie = Movie.friendly.find(params[:id])
  end

  def create
    @rating = Rating.new(rating_params)
    if @rating.save
      redirect_to @movie
    else
      render :new
    end
  end
end
