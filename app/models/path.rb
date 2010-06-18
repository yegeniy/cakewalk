class Path < ActiveRecord::Base
  has_many :edges
  has_many :points, :through => :edges
end
