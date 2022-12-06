class CreatePfotoTags < ActiveRecord::Migration[6.1]
  def change
    create_table :pfoto_tags do |t|

      t.integer :photo_id,null: false
      t.integer :tag_id,null: false
      t.timestamps
    end
  end
end
