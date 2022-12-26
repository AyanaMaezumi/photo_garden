class Public::HomesController < ApplicationController

  def top
    @photos = Photo.page(params[:page]).per(6)
  end

end
