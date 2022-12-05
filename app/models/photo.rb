class Photo < ApplicationRecord

  has_one_attached :image

  belongs_to :customer
  belongs_to :camera

  has_many :photo_tags
  has_many :photo_editing_apps
  has_many :photo_shooting_equipments
  has_many :photo_favorite_photos, dependent: :destroy
  has_many :photo_comments, dependent: :destroy

end
