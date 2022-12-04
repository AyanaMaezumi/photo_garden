class Comment < ApplicationRecord

  belongs_to :customer
  has_many :comment_reports
  has_many :photo_comments

end
