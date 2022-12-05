class Public::PhotosController < ApplicationController

  def new
    @photo = Photo.new
  end

  def create
    photo = Photo.new(photo_params)
    photo.save
    redirect_to photo_path(photo.id)
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    photo = Photo.find(params[:id])
    photo.update(photo_params)
    redirect_to photo_path(photo.id)
  end

  def index
    @photos = Photo.page(params[:page]).per(10)
  end

  def show
    @photo = Photo.find(params[:id])
    @comment = Comment.new
  end

  def edit
  end

private
  def photo_params
    params.require(:photo).permit(:image, :camera, :editing_app, :shooting_equipment, :introduction, :tag)
  end

end
