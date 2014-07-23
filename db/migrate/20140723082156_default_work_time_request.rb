class DefaultWorkTimeRequest < ActiveRecord::Migration
  def change
      create_table :default_work_time_requests do |t|
      t.string :week, array: true,  default: [], length: 5
      t.string :description
      t.string :status
      t.integer :user_id
    end
  end
end
