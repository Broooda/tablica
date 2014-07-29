class CreateRaports < ActiveRecord::Migration
  def change
    create_table :raports do |t|
      t.string :user_id
      t.date :date_begin
      t.date :date_end
      t.integer :hours_worked

      t.timestamps
    end
  end
end
