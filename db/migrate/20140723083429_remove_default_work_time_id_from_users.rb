class RemoveDefaultWorkTimeIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :defaultWorkTime_id
  end
end
