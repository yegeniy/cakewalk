class OperateMarkerController < ApplicationController

def create
puts params
point = Point.new(params[:m])
point.save
if point.save
res={:success=>true,:content=>"<div><strong>name </strong>#{point.name}
</div><div><strong>comment </strong>#{point.comment}</div>"}
else
res={:success=>false,:content=>"Could not save the marker"}
end
render :text=>res.to_json
end
end
