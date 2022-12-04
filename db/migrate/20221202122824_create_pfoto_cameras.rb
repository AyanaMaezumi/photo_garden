class CreatePfotoCameras < ActiveRecord::Migration[6.1]
  def change
    create_table :pfoto_cameras do |t|

      t.integer :photo_id,null: false
      t.integer :cameras_id,null: false

      t.timestamps
    end
  end
end
