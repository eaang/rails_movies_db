class RatingsController < ApplicationController
  def new
    @movie = Movie.friendly.find(params[:movie_id])
    @user = current_user
    @partner = User.where.not(id: @user.id).first
  end

  def create
    movie = Movie.friendly.find(params[:movie_id])
    me = current_user
    partner = User.where.not(id: me.id).first
    my_score = params[:ratings][:mine]
    partner_score = params[:ratings][:partner]
    Rating.create({ score: my_score, user: me, movie: movie })
    Rating.create({ score: partner_score, user: partner, movie: movie })
    redirect_to movie
  end
end
