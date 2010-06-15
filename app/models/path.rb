class Path < ActiveRecord::Base
  has_many :edges

  # Append an edge to the calling path
  def add_edge(edge)
    edges << edge
  end

end
