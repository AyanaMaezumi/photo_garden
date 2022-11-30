class CreateShootingEquipments < ActiveRecord::Migration[6.1]
  def change
    create_table :shooting_equipments do |t|

      t.timestamps
    end
  end
end
