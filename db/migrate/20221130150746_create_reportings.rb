class CreateReportings < ActiveRecord::Migration[6.1]
  def change
    create_table :reportings do |t|
      
      t.integer :comment_id,null: false
      t.timestamps
    end
  end
end
