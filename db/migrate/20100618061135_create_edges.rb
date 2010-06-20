class CreateEdges < ActiveRecord::Migration
  def self.up
    create_table :edges do |t|
      t.integer :path_id
      t.integer :point_id
      t.integer :endpoint_id
      t.integer :order

      t.timestamps
    end
  end

  def self.down
    drop_table :edges
  end
end
