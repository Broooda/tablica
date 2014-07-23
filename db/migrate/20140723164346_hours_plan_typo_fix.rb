class HoursPlanTypoFix < ActiveRecord::Migration
  def change
    rename_column :hours_plans, :over_houers, :over_hours
  end
end
