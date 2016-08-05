class PhotosController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :fetch_album
  before_action :fetch_photo, only: [:edit, :show, :update, :destroy]

  def new
    @photo = @album.photos.build
  end

  def create
    @photo = @album.photos.new(photos_params)
    if @photo.save
      redirect_to @album, notice: 'Photo added.'
    else
      render :edit
    end
  end

  def index
    @photos = @album.photos
  end

  def edit
  end

  def show
  end

  def update
    if @photo.update(photos_params)
      redirect_to @album, notice: 'Album updated.'
    else
      render :edit
    end
  end

  def destroy
    _notice = @photo.destroy ? 'Photo was successfully destroyed.' : 'Unable to destroy Photo'
    redirect_to @album, notice: _notice
  end

  private

  def fetch_album
    @album = Album.where(id: params[:album_id]).first
  end

  def fetch_photo
    @photo = @album.photos.where(id: params[:id]).first
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def photos_params
    params.require(:photo).permit(:image, :tag_line)
  end

end
