class Admin::PhotosController < ApplicationController

  def destroy
    @photo = Photo.find(params[:id])
    # Photoモデルのcustomer_idカラムを取得する
    customer_id = @photo.customer_id
    # customer_nickname = @photo.customer_nickname # これはニックネームを取得できない

    # Photoモデルにアソシエーションcustomerモデルのidカラムを取得する
    # customer_id = @photo.customer.id
    # customer_nickname = @photo.customer.nickname # これはニックネームを取得できる
    @photo.destroy
    redirect_to admin_customer_path(customer_id)
  end

end
