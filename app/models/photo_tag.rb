class PhotoTag < ApplicationRecord

  belongs_to :photo
  belongs_to :tag
  
  # presenceは、指定された属性が空でないことを確認します。
  validates :photo_id, presence: true
  validates :tag_id, presence: true
end
