class CreateCommentReportings < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_reportings do |t|

      t.integer :photo_id,null: false
      t.integer :reports_id,null: false
      
      t.timestamps
    end
  end
end
