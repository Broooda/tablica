class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.datetime :StartDate
      t.datetime :EndDate
      t.text :Description
      t.string :Status
      t.text :Reason

      t.timestamps
    end
  end
end
