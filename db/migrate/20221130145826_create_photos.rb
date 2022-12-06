class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|

      t.integer :customer_id,null: false
      t.text :introduction,null: false

      t.timestamps
    end
  end
end
