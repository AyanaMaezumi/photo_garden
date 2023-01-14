class Public::FavoritesController < ApplicationController

  def create
    photo = Photo.find(params[:photo_id])
    favorite = current_customer.favorites.new(photo_id: photo.id)
    favorite.save
    redirect_to photo_path(photo)
  end

  def destroy
    photo = Photo.find(params[:photo_id])
    favorite = current_customer.favorites.find_by(photo_id: photo.id)
    favorite.destroy
    #destroyアクションの後のページ飛び先分岐
    #favorites/index.htmlの削除ボタンを押した場合
    if params[:name]
      redirect_to favorite_photos_path
    else
      redirect_to photo_path(photo)
    end
  end

  def index
     #customerモデルで、likesを定義している。
    @photos = current_customer.likes.left_joins(:customer).where('customers.is_deleted = ?', false).page(params[:page]).per(10)
  end

end
