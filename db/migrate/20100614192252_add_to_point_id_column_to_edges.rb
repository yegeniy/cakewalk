class AddToPointIdColumnToEdges < ActiveRecord::Migration
  def self.up
    add_column :edges, :to_point_id, :integer
  end

  def self.down
    remove_column :edges, :to_point_id
  end
end
