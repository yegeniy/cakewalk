class HomeController < ApplicationController
  def index
    @point_names = []
    @points = Point.all
    @points.each { |point| if point.name then @point_names << point.name end }
    puts @points
  end

  def authorize
  end
end
