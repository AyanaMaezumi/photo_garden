class Public::PhotosController < ApplicationController
  
  def index
    @photos = Photo.page(params[:page]).per(10)
  end
  
  def show
    @photo = Photo.find(params[:id])
  end

end
