class PhotoComment < ApplicationRecord

  belongs_to :photo
  belongs_to :comment

end
