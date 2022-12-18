class Public::RelationshipsController < ApplicationController
  
  #フォローするとき
  def create
    current_customer.follow(params[:customer_id])
    redirect_back(fallback_location: root_url)
  end
  #フォロー外すとき
  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_back(fallback_location: root_url)
  end
end
