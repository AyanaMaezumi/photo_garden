class Tag < ApplicationRecord

  has_many :photo_tags,dependent: :destroy, foreign_key: 'tag_id'
  # タグは複数の写真を持つ　それは、photo_tagsを通じて参照できる
  has_many :photos,through: :photo_tags

  validates :name, uniqueness: true, presence: true

end
