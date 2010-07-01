class HomeController < ApplicationController
  def index
    @point_names = []
    @points = Point.all
    @points.each { |point| @point_names << point.name }
    puts @points
  end

  def authorize
  end
end
