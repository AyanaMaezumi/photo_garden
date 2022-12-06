class CreatePfotoShootingEquipments < ActiveRecord::Migration[6.1]
  def change
    create_table :pfoto_shooting_equipments do |t|

      t.integer :photo_id,null: false
      t.integer :shooting_equipments_id,null: false

      t.timestamps
    end
  end
end
