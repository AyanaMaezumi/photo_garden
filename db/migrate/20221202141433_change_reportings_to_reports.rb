class ChangeReportingsToReports < ActiveRecord::Migration[6.1]
  def change
    rename_table :reportings, :reports
  end
end
