class Public::HomesController < ApplicationController
  
  def top
    @photo = Photo.all
  end
  
end
