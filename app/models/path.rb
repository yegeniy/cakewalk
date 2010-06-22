class Path < ActiveRecord::Base
  has_many :edges
#  has_many :legs, :through => :edges, :source => :point
  has_many :points, :through => :edges

  accepts_nested_attributes_for :edges, :allow_destroy => true
=begin
  def edge_attributes=(edge_attributes)
    edge_attributes.each do |attributes|
      edges.build(attributes)
    end
  end
=end

end
