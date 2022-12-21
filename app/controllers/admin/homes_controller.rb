class Admin::HomesController < ApplicationController
  
  def top
    @photos = Photo.page(params[:page]).per(5)
  end

end
