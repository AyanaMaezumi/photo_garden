class AddCustomerIdToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :customer_id, :integer 
  end
end