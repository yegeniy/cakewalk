class Edge < ActiveRecord::Base
  belongs_to :point
  validates_presence_of :point
    
end
