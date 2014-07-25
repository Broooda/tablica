class AddDefaulValueToHorsPlan < ActiveRecord::Migration
  def change
    change_column :hours_plans, :over_hours, :integer, :default => 0
  end
end
