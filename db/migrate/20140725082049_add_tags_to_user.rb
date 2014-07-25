class AddTagsToUser < ActiveRecord::Migration
  def change
    add_column :users, :tags, :string, :default => ""
  end
end
