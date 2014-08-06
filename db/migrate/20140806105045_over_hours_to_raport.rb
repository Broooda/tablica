class OverHoursToRaport < ActiveRecord::Migration
  def change
    add_column :raports, :over_hours, :float
    change_column :over_hours, :hours, :float
  end
end
