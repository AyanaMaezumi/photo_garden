class Public::CommentsController < ApplicationController

  def create
    photo = Photo.find(params[:photo_id])
    comment = current_customer.comments.new(comment_params)
    comment.photo_id = photo.id
    comment.save
    redirect_to photo_path(photo)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to photo_path(params[:photo_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
