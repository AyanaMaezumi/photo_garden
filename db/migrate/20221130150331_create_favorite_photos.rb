class CreateFavoritePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_photos do |t|

      t.integer :photo_id,null: false

      t.timestamps
    end
  end
end
