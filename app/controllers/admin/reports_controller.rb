class Admin::ReportsController < ApplicationController

  def index
    @reports = Report.page(params[:page]).per(10)
  end

  def destroy
    @report = Report.find(params[:id])
    @report.comment.destroy
    redirect_to admin_reports_path
  end

end
