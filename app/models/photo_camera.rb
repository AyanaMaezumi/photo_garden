class PhotoCamera < ApplicationRecord

  belongs_to :photo
  belongs_to :camera
  validates :photo_id, presence: true
  validates :camera_id, presence: true

end
