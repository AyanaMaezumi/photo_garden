class EditingApp < ApplicationRecord

  has_many :photo_editing_apps,dependent: :destroy, foreign_key: 'editing_app_id'
  # 加工アプリは複数の写真を持つ　それは、photo_editing_appsを通じて参照できる
  has_many :photos,through: :photo_editing_apps

  validates :name, uniqueness: true, presence: true

end
