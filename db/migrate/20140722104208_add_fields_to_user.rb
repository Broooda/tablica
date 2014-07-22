class AddFieldsToUser < ActiveRecord::Migration
  def change
        add_column :users, :name, :string
        add_column :users, :surname, :string
        add_column :users, :defaultWorkTime_id, :integer
        add_column :users, :admin, :boolean
  end
end
