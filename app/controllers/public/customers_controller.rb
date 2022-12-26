class Public::CustomersController < ApplicationController

  def show
    # customerテーブルを参照して一致するIDのcustomerを取得する
    @customer = Customer.find(params[:id])
    # customerテーブルを参照して一致するIDのcustomerを取得する それの紐づく画像情報を取得
    @photos = @customer.photos.page(params[:page]).per(10)
    # customerテーブルを参照して一致するIDのcustomerを取得する それの紐づくいいね情報を取得
    @favorite_photos = @customer.likes
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = current_customer
    @customer.update!(customer_params)
    redirect_to customer_path
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

  def unsubscribe
    @customer = current_customer
  end

  def withdrawal
    customer = current_customer
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:nickname, :introduction, :email, :image)
  end


end
