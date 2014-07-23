class AddedBelongsToUserInDefaultWorkTime < ActiveRecord::Migration
  def change
    add_column :default_work_times, :user_id, :integer
  end
end
