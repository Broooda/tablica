class AddOverHouersToHoursPlan < ActiveRecord::Migration
  def change
    add_column :hours_plans, :over_houers, :integer
  end
end
