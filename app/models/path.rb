class Path < ActiveRecord::Base
  has_many :edges
#  has_many :legs, :through => :edges, :source => :point
  has_many :points, :through => :edges
end
