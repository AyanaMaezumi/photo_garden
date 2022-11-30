class CreateFollowMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_members do |t|

      t.timestamps
    end
  end
end
