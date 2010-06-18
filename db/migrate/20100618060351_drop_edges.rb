class DropEdges < ActiveRecord::Migration
  def self.up
    drop_table :edges
  end

  def self.down
    create_table :edges do |t|
      t.string :from
      t.string :to
      t.string :direction

      t.timestamps
    end
    add_column :edges, :to_point_id, :integer
  end
end
