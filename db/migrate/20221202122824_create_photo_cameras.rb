class CreatePhotoCameras < ActiveRecord::Migration[6.1]
  def change
    create_table :photo_cameras do |t|

      t.references :photo, foreign_key: true
      t.references :camera, foreign_key: true

      t.timestamps
    end
    
    add_index :photo_cameras, [:photo_id, :camera_id], unique: true
  end
end
