class Public::HomesController < ApplicationController
  before_action :correct_user

  def top
    @photos = Photo.page(params[:page]).per(6)
  end
  
  private
  
  def correct_user
    redirect_to admin_root_path if current_admin
  end
end
