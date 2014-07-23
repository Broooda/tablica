class CreateHoursPlans < ActiveRecord::Migration
  def change
    create_table :hours_plans do |t|
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
