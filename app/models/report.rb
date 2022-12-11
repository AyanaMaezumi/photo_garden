class Report < ApplicationRecord

  has_many :comment_reports
  has_many :comments,through: :comment_reports
  
end
