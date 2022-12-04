class CreateFollowMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_members do |t|

      t.integer :customer_id,null: false

      t.timestamps
    end
  end
end
