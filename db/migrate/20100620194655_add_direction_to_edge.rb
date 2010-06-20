class AddDirectionToEdge < ActiveRecord::Migration
  def self.up
    add_column :edges, :direction, :string
  end

  def self.down
    remove_column :edges, :direction
  end
end
