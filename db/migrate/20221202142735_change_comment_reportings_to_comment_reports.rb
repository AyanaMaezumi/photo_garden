class ChangeCommentReportingsToCommentReports < ActiveRecord::Migration[6.1]
  def change
   rename_table :comment_reportings, :comment_reports
  end
end
