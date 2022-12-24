class Public::ReportsController < ApplicationController

  def create
    @report = Report.new
    @comment = Comment.find(params[:comment_id])
    @report.comment_id = @comment.id
    @report.customer_id = current_customer.id
    @report.save!
    redirect_to photo_path(@comment.photo_id)
  end

end

