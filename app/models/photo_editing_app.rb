class PhotoEditingApp < ApplicationRecord

  belongs_to :photo
  belongs_to :editing_app
  
  # presenceは、指定された属性が空でないことを確認します。
  validates :photo_id, presence: true
  validates :editing_app_id, presence: true

end
