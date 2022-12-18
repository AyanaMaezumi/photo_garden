class Public::CustomersController < ApplicationController

  def show
    # customerテーブルを参照して一致するIDのcustomerを取得する
    @customer = Customer.find(params[:id])
    # customerテーブルを参照して一致するIDのcustomerを取得する それの紐づく画像情報を取得
    @photos = @customer.photos.page(params[:page]).per(10)
    # customerテーブルを参照して一致するIDのcustomerを取得する それの紐づくいいね情報を取得
    @favorite_photos = @customer.likes
  end

  #フォロー一覧
  def followings
    customer = Customer.find(params[:id])
    @followings = customer.followings
  end

  #フォロワー一覧
  def followers
    customer = Customer.find(params[:id])
    @followers = customer.followers
  end
end
