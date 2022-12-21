class Admin::ReportsController < ApplicationController
  
  def index
    @reports = reports.all
  end

end
