class AddCommentToPoint < ActiveRecord::Migration
  def self.up
    add_column :points, :comment, :string
  end

  def self.down
    remove_column :points, :comment
  end
end
