class AddedReasonToDefaultWorkTimeRequest < ActiveRecord::Migration
  def change
    add_column :default_work_time_requests, :reason, :string
  end
end
