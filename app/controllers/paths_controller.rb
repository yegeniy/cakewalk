class PathsController < ApplicationController
#layout "app"
#layout "paths", :only => 'new'
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
  
  N_EDGES = 2;
  # GET /paths/new
  # GET /paths/new.xml
  def new
    @path = Path.new
    
    # Adds edges to @path

    N_EDGES.times{ @path.edges.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @path }
    end
  end

  # GET /paths/1/edit
  def edit
    @path = Path.find(params[:id])
  end

  # POST /paths
  # POST /paths.xml
  def create
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
