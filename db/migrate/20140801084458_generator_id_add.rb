class GeneratorIdAdd < ActiveRecord::Migration
  def change
     add_column :raports, :generator_id, :integer
  end
end
