class Path < ActiveRecord::Base
  has_many :edges
#  has_many :legs, :through => :edges, :source => :point
  has_many :points, :through => :edges

  accepts_nested_attributes_for :edges
=begin
  def edge_attributes=(edge_attributes)
    edge_attributes.each do |attributes|
      edges.build(attributes)
    end
  end
=end


  def search_path(start, finish)
	@path = Path.all
	available = []
	#p = @path.last
    for p in @path	 
	   if !p.edges.nil?
	      #puts p.edges.length
		  #puts p.edges.first.point.name
		if start == p.edges.first.point.name && finish == p.edges.last.endpoint.name 
			available.push(p.edges)
		end
	 end
	end		
	
	return available
  end
end
