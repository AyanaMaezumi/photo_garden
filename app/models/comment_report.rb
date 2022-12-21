class CommentReport < ApplicationRecord

  belongs_to :report
  belongs_to :comment

end
