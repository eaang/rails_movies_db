class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :assign_env_variables

  def assign_env_variables
    gon.omdb = ENV['OMDB']
  end
end
