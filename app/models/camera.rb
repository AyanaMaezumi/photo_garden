class Camera < ApplicationRecord

  has_many :photo_cameras,dependent: :destroy, foreign_key: 'camera_id'
  # カメラは複数の写真を持つ　それは、photo_camerasを通じて参照できる
  has_many :photos,through: :photo_cameras
  
  validates :name, presence: true

end
