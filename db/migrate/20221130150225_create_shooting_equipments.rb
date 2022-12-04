class CreateShootingEquipments < ActiveRecord::Migration[6.1]
  def change
    create_table :shooting_equipments do |t|

      t.integer :photo_id,null: false
      t.string :name,null: false
      t.timestamps
    end
  end
end
