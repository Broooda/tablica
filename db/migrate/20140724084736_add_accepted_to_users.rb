class AddAcceptedToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :accepted, :boolean, :default => false
  end
end
