class AddUserIdToHoursPlan < ActiveRecord::Migration
  def change
    add_column :hours_plans, :user_id, :integer
  end
end
