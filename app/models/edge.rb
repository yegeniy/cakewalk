class Edge < ActiveRecord::Base

  belongs_to :path, :class_name => "Path"
  belongs_to :point, :class_name => "Point"#, :dependent => :destroy
  belongs_to :endpoint, :class_name => "Point"#, :dependent => :destroy

#  belongs_to :to_point, :class_name => "Point"
  validates_presence_of :point, :endpoint
end
