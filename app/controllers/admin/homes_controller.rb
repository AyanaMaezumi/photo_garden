class Admin::HomesController < ApplicationController
  before_action :correct_user
  
  def top
    @photos = Photo.page(params[:page]).per(9)
  end
  
  private
  
  def correct_user
    redirect_to root_path unless current_admin
  end
end
