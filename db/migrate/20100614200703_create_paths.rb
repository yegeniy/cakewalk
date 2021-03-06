class CreatePaths < ActiveRecord::Migration
  def self.up
    create_table :paths do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :paths
  end
end
