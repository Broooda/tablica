class CreateOverHoursModel < ActiveRecord::Migration
  def change
    create_table :over_hours do |t|
      t.integer :user_id
      t.datetime :date
      t.integer :hours
      t.string :description
      t.string :status
    end
  end
end
