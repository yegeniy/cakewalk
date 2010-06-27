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


  def search(start, finish)
    puts start
	puts finish
	@path = Path.all
	available = []
	for p in @path	 
	  sample_path = []
	   if !p.edges.nil?
	        if start == p.edges.first.point.name 
				if finish == p.edges.last.endpoint.name 
					available.push(p.edges)
				  
			    else
				    sample_path.push(p.edges.first)
					for e in p.edges[1..-1]	
						if finish == e.endpoint.name
							sample_path.push(e)
							available.push(sample_path)
							break
						else 
							sample_path.push(e)						
							end
						end	
					end
						
			else
			    p.edges[1..-1].each_with_index  do |e,index| 
					if start == e.point.name 
					    if finish == e.endpoint.name 
						    sample_path.push(e)
							available.push(sample_path)
				        else
						   sample_path.push(e)
				  	       for e in p.edges[(index +2)..-1]	
								if finish == e.endpoint.name
									sample_path.push(e)
									available.push(sample_path)
									break
								else 
									sample_path.push(e)						
								end
							end	
						end	
					end	  
				end 
					
			end		
		end
    end
	#puts "available"
	#puts available 
	return available
  end
end
