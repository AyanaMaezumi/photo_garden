class Comment < ApplicationRecord

  belongs_to :customer
  
  has_many :comment_reports
  has_many :reports,through: :comment_reports
  
  has_many :photo_comments
  has_many :photos,through: :photo_comments

end
