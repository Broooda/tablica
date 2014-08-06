class RemoveOverHoursFromHoursPlan < ActiveRecord::Migration
  def change
    remove_column :hours_plans, :over_hours
  end
end
