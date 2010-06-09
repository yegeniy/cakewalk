class SearchController < ApplicationController
  def index

  end
  
  def result
    if request.post?
      @start = params[:start]
      @end = params[:end]
      str = ""
      start_arr = @start.split
      end_arr = @end.split
      start_arr.each {|word| str << word + "+"}
      str << "to+"
      end_arr.each {|word| str << word + "+"}
      redirect_to ("http://maps.google.com/maps?q=" + str[0..-2])
    end
  end
end
