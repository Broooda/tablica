class DefaultWorkTime < ActiveRecord::Migration
  def change
      create_table :default_work_times do |t|
      t.string :week, array: true,  default: [], length: 5
    end
  end
end

