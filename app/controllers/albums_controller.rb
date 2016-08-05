class AlbumsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :fetch_album, except: [:new, :create]

  def new
    @album = Album.new
  end

  def create
    @album = current_user.albums.new(album_params)
    if @album.save
      redirect_to @album, notice: 'Album successfully created!'
    else
      render :edit
    end
  end

  def index
    @albums = current_user.albums
  end

  def edit
  end

  def show
  end

  def update
    if @album.update(album_params)
      redirect_to @album, notice: 'Album updated.'
    else
      render :edit
    end
  end

  def destroy
    _notice = @album.destroy ? 'Album was successfully destroyed.' : 'Unable to destroy Album'
    redirect_to albums_url, notice: _notice
  end

  private

  def fetch_album
    @album = Album.where(id: params[:id]).first
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def album_params
    params.require(:album).permit(:name)
  end

end