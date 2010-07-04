
class OperateMarkerController < ApplicationController
  #called from an AJAX Request
  def create
    # Point is created with the arguments passed in the request and saved to database
    point = Point.new(params[:point])
    point.save
    if point.save
      res={:success=>true,:content=>"<div><strong>name </strong>#{point.name}
        </div><div><strong>comment </strong>#{point.comment}</div>", :id => point.id}
    else
      res={:success=>false,:content=>"Could not save the marker"}
    end
    render :text => res.to_json
  end
  
  
  def create_edges 
      
	point_string=  params[:m]["point_ids"]
	edges_string = params[:m]["edge_descriptions"]
	puts point_string
	puts edges_string
	puts edges_string.class
	edges_description = edges_string.split("**,")
	puts edges_description
	
	#convert string into array of point_ids
	point_ids = point_string.split(",")
	
	path = Path.new(:name => params[:m]["path_name"], :description => params[:m]["path_description"])	
	path.save
	len =  point_ids.length
	edges =[]
	k = 0
	for i in point_ids[0..-2]
	    puts i
		j = i.to_i + 1
		puts i.class
		
		edge = Edge.new(:point_id => i, :endpoint_id => j, :direction => edges_description[k])
		edge.save
		k += 1
		edges.push(edge)
	end	
	path.edges << edges
	puts path.edges
	
    res ={:success =>true}
	respond_to do |format|
            
        #format.html { redirect_to(@path) }
        format.json  { render :json => res }
   end 
	
    
  end
end
