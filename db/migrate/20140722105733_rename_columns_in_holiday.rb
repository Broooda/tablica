class RenameColumnsInHoliday < ActiveRecord::Migration
  def self.up
    rename_column :holidays, :StartDate, :startdate
    rename_column :holidays, :EndDate, :enddate
    rename_column :holidays, :Description, :description
    rename_column :holidays, :Status, :status
    rename_column :holidays, :Reason, :reason
  end
end
