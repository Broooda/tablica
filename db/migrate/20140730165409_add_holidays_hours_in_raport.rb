class AddHolidaysHoursInRaport < ActiveRecord::Migration
  def change
    add_column :raports, :holiday_hours, :string
    remove_column :raports, :hours_worked
    add_column :raports, :work_hours, :string
  end
end
