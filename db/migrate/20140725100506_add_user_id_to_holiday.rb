class AddUserIdToHoliday < ActiveRecord::Migration
  def change
    add_column :holidays, :user_id, :integer
  end
end
