class PathsController < ApplicationController

  before_filter :requirelogin, :except => ["show", "search_path"]

  # GET /paths
  # GET /paths.xml
  def index
    @paths = Path.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @paths }
    end
  end

  # GET /paths/1
  # GET /paths/1.xml
  def show
    @path = Path.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @path }
    end
  end

  #N_EDGES = 2;
  # GET /paths/new
  # GET /paths/new.xml
  def new
    @path = Path.new

    # Adds edges to @path

    #N_EDGES.times{ @path.edges.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @path }
    end
  end

  # GET /paths/1/edit
  def edit
    @path = Path.find(params[:id])
  end

  def search_path
    # What is :m? What is a?

    a =  params[:m]

    result = []
    @path = Path.new
    available_paths = @path.search(a["start"],a["finish"])
    for edge in available_paths
      dir = []
      for i in edge
        puts i.class
        dir.push("From #{i.point.name} #{i.direction} To  #{i.endpoint.name}")

      end
      result.push(dir)
      #puts "From #{edge[1].point.name} #{edge[1].direction} To  #{edge[1].endpoint.name}"
    end

    respond_to do |format|

      #format.html { redirect_to(@path) }
      format.json  { render :json => result }
    end

  end

  # POST /paths
  # POST /paths.xml
  def create

    path = Path.new(params[:path])
    path.save
    if path.save
      res={:success=>true,
        :content=>"<div><strong>name </strong>#{path.name}
        </div><div><strong>description </strong>#{path.description}</div>",
        :id => path.id}
    else
      res={:success=>false,
        :content=>"Could not save the path"}
    end
    render :text => res.to_json

=begin
    @path = Path.new(params[:path])
        respond_to do |format|
      if @path.save
        flash[:notice] = 'Path was successfully created.'
        format.html { redirect_to(@path) }
        format.xml  { render :xml => @path, :status => :created, :location => @path }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @path.errors, :status => :unprocessable_entity }
      end
    end
=end
  end

  # GET /paths/add_point
  def add_point
    #Handle points: TODO: Should be in the points controller, right?
    puts "about to create a point!"
    point = Point.new(params[:point])
    point.save
    puts "created a point!"

  end

  # PUT /paths/1
  # PUT /paths/1.xml
  def update
    @path = Path.find(params[:id])

    respond_to do |format|
      if @path.update_attributes(params[:path])
        flash[:notice] = 'Path was successfully updated.'
        format.html { redirect_to(@path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @path.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /paths/1
  # DELETE /paths/1.xml
  def destroy
    @path = Path.find(params[:id])
    @path.destroy

    respond_to do |format|
      format.html { redirect_to(paths_url) }
      format.xml  { head :ok }
    end
  end
end
