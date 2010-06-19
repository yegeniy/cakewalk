class RenameOrderToPositionInEdge < ActiveRecord::Migration
  def self.up
    rename_column( :edges, :order, :position)
  end

  def self.down
    rename_column( :edges, :position, :order)
  end
end
