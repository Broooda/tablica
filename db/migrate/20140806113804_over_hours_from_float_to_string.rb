class OverHoursFromFloatToString < ActiveRecord::Migration
  def change
   change_column :raports, :over_hours, :string
  end
end
