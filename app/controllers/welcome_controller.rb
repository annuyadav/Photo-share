class WelcomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    redirect_to home_url and return unless current_user
    @albums = current_user.albums
  end

  def home
    @photos = Photo.limit(25).order('id desc')
  end
end
