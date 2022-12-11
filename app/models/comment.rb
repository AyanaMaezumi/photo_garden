class Comment < ApplicationRecord

  belongs_to :customer

  has_many :comment_reports
  has_many :reports,through: :comment_reports

  belongs_to :photo

end
