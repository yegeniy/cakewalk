class Edge < ActiveRecord::Base
  belongs_to :point, :class_name => "Point"
  belongs_to :to_point, :class_name => "Point"
  validates_presence_of :to_point
    
end
