class FavoritePhoto < ApplicationRecord

  has_many :photo_favorite_photos,dependent: :destroy
  has_many :photos,through: :photo_favorite_photos

end
