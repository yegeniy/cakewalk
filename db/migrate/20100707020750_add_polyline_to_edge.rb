class AddPolylineToEdge < ActiveRecord::Migration
  def self.up
    add_column :edges, :polyline, :string
  end

  def self.down
    remove_column :edges, :polyline
  end
end
