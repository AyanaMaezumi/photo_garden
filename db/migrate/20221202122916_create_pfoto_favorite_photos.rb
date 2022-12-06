class CreatePfotoFavoritePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :pfoto_favorite_photos do |t|

      t.integer :photo_id,null: false
      t.integer :favorite_photos_id,null: false

      t.timestamps
    end
  end
end
