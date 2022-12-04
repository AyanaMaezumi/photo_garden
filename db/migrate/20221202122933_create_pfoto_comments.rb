class CreatePfotoComments < ActiveRecord::Migration[6.1]
  def change
    create_table :pfoto_comments do |t|

      t.integer :photo_id,null: false
      t.integer :comments_id,null: false

      t.timestamps
    end
  end
end
