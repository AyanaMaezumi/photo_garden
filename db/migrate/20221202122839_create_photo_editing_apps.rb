class CreatePhotoEditingApps < ActiveRecord::Migration[6.1]
  def change
    create_table :photo_editing_apps do |t|

      t.references :photo, foreign_key: true
      t.references :editing_app, foreign_key: true

      t.timestamps
    end
    # 同じタグを２回保存するのは出来ないようになる
    add_index :photo_editing_apps, [:photo_id, :editing_app_id], unique: true
  end
end
