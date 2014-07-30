class HolidaysPlan < ActiveRecord::Migration
  def change
    create_table :holidays_plans do |t|
      t.integer :user_id
      t.float :hours
      t.datetime :holiday_date
    end
  end
end
