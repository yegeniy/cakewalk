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
	  sample_path = []
	   if !p.edges.nil?
	       check_start = false
	       #if check_start == false
				if start == p.edges.first.point.name 
					check_start = true
						if finish == p.edges.last.endpoint.name 
							#sample_path.push(p.edges)
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
						#for e in p.edges[1..-1]
						    puts " ***"
						    puts e.point.name
							puts "****"
							if start == e.point.name 
							    if finish == e.endpoint.name 
							    sample_path.push(e)
								available.push(sample_path)
						        else
								   sample_path.push(e)
							       for e in p.edges[(index +1)..-1]	
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

#	else 
#			    for i in p.edges(
#				p.each_with_index do |e,index|
				
 
			 
	return available
  end
end
