class CreateCameras < ActiveRecord::Migration[6.1]
  def change
    create_table :cameras do |t|
      
      t.integer :photo_id,null: false
      t.string :name,null: false
      t.timestamps
    end
  end
end
