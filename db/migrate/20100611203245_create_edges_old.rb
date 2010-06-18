class CreateEdges < ActiveRecord::Migration
  def self.up
    create_table :edges do |t|
      t.string :from
      t.string :to
      t.string :direction

      t.timestamps
    end
  end

  def self.down
    drop_table :edges
  end
end
