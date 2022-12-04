class CreateEditingApps < ActiveRecord::Migration[6.1]
  def change
    create_table :editing_apps do |t|

      t.integer :photo_id,null: false
      t.string :name,null: false

      t.timestamps
    end
  end
end
