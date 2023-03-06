class PhotoCamera < ApplicationRecord

  belongs_to :photo
  belongs_to :camera
  
  # presenceは、指定された属性が空でないことを確認します。
  validates :photo_id, presence: true
  validates :camera_id, presence: true

end
