class CreatePfotoEditingApps < ActiveRecord::Migration[6.1]
  def change
    create_table :pfoto_editing_apps do |t|

      t.integer :photo_id,null: false
      t.integer :editing_apps_id,null: false

      t.timestamps
    end
  end
end
