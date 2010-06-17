class AddColumnToEdge < ActiveRecord::Migration
  def self.up
    add_column :edges, :path_id, :integer
  end

  def self.down
    remove_column :edges, :path_id
  end
end
