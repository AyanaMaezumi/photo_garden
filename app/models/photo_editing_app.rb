class PhotoEditingApp < ApplicationRecord

  belongs_to :photo
  belongs_to :editing_app
  validates :photo_id, presence: true
  validates :editing_app_id, presence: true

end
