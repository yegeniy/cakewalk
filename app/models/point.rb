class Point < ActiveRecord::Base
  has_many :edges
  has_many :paths, :through => :edges
end
