=begin
Author:Charu Jain
Homework 11
Description: Use jquery and AJAX 
Usage: run localhost:3000/categories
=end


class OperateMarkerController < ApplicationController

#called from an AJAX Rresuest
def create
   # Point is created with the arguments passed in the request and saved to database
	point = Point.new(params[:point])
	point.save
	if point.save
		res={:success=>true,:content=>"<div><strong>name </strong>#{point.name}
		</div><div><strong>comment </strong>#{point.comment}</div>, :id => point.id"}
	else
		res={:success=>false,:content=>"Could not save the marker"}
	end
	render :text=>res.to_json
end
end
