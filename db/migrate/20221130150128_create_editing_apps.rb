class CreateEditingApps < ActiveRecord::Migration[6.1]
  def change
    create_table :editing_apps do |t|

      t.string :name

      t.timestamps
    end
  end
end
