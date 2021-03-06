require 'test_helper'

class PathTest < ActiveSupport::TestCase
  
  #fixtures :points


  def setup
    @point_sherman = points(:point_sherman)
    @point_rose = points(:point_rose)
    @point_golding = points(:point_golding)

    @s_r = Edge.new(:point_id    => @point_sherman.id,
                    :endpoint_id => @point_rose.id)
    
    @r_g = Edge.new(:point_id    => @point_rose.id,
                    :endpoint_id => @point_golding.id)
  end

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "adding empty path" do
    path = Path.new
    path.save!
    assert path.valid?
  end
  
  test "searching paths" do 
	p1 = Point.new(:name => "moo")
	p2 = Point.new(:name => "Bob")
	p3 = Point.new(:name => "Joe")
	p1.save!
	p2.save!
	p3.save!
	assert 3, Point.all
	e1 = Edge.new(:id => 1, :point_id => p1.id,:endpoint_id => p2.id);
	e1.save
	e2 = Edge.new(:id => 2, :point_id => p2.id,:endpoint_id => p3.id);
	e2.save
	assert 2,Edge.count
	
 end
 
 test "checking " do 
    p1 = Point.new(:name => "moo")
	p2 = Point.new(:name => "Bob")
	p3 = Point.new(:name => "Joe")
	p1.save!
	p2.save!
	p3.save!
	path1 = Path.new(:name => "test1", :description => "blah");
	path1.save();
	e1 = Edge.new(:id => 1, :point_id => p1.id,:endpoint_id => p2.id);
	e1.save
	e2 = Edge.new(:id => 2, :point_id => p2.id,:endpoint_id => p3.id);
	e2.save
	path1.edges << e1;
	path1.edges << e2;
	assert 2, path1.edges
	
end
 test "search multiple paths" do 
 
	   p1 = Point.new(:name => "Rose Art Museum")
       p2 = Point.new(:name => "Sherman Hall")
       p3 = Point.new(:name => "Volen Center")
       p4 = Point.new(:name => "Usdan Center")
	   p5 = Point.new(:name => "Goldfarb Library")
       p1.save!
       p2.save!
       p3.save!
       p4.save!
	   p5.save!

       path1 = Path.new(:name => "Volen to Usdan", :description => "moo")
       path1.save()

       e1 = Edge.new(:point_id => p3.id, :endpoint_id => p5.id, :direction => "Go Straight")
       e1.save()
	   
       e2 = Edge.new(:point_id => p5.id, :endpoint_id => p4.id, :direction => "Go Straight")
       e2.save()
	   

       path1.edges << e1
	   path1.edges << e2

       path2= Path.new(:name=> "Volen Center to Usdan", :description => "via Rose art museum")
       path2.save()

       e1 = Edge.new(:point_id => p3.id,:endpoint_id => p2.id, :direction => "Go Straight")
       e1.save()

       e2= Edge.new(:point_id => p2.id, :endpoint_id => p1.id, :direction => "Go Left")
       e2.save()

	   e3= Edge.new(:point_id => p1.id, :endpoint_id => p4.id, :direction => "Go Right")
       e3.save()
	   
       path2.edges << e1
       path2.edges << e2
	   path2.edges << e3
   
	   path3 = Path.new(:name => "Volen to Usdan", :description => "moo")
       path3.save()

       e1 = Edge.new(:point_id => p3.id, :endpoint_id => p5.id, :direction => "Go Straight")
       e1.save()
	   
       e2 = Edge.new(:point_id => p5.id, :endpoint_id => p4.id, :direction => "Go Straight")
       e2.save()
	   path3.edges << e1
	   path3.edges << e2
	  

       path4 = Path.new(:name => "Goldfarb to sherman ", :description => "moo")
       path4.save()

       e1 = Edge.new(:point_id => p5.id, :endpoint_id => p1.id, :direction => "Go Straight")
       e1.save()
	   
       e2 = Edge.new(:point_id => p1.id, :endpoint_id => p3.id, :direction => "Go Straight")
       e2.save()
	   
	   e3 = Edge.new(:point_id => p3.id, :endpoint_id => p4.id, :direction => "Go Straight")
       e3.save()
	   
	   e4 = Edge.new(:point_id => p4.id, :endpoint_id => p2.id, :direction => "Go Straight")
       e4.save()
	   
	   
	   path4.edges << e1
	   path4.edges << e2
	   path4.edges << e3
	   path4.edges << e4
     	  
	   
	   
       #assert 2, path1.edges.length
       #assert 2, Path.all.length

       #assert nil, path1.edges.first
       available_paths = path4.search_path(p4.name, p2.name)
	   puts "Available Paths TEST" 
	   puts available_paths
	   #assert 2, available_paths.length
	   for edge in available_paths
	       puts edge.class  
	       puts "pATH *****"
	        for i in edge
			  puts i.class
			puts "From #{i.point.name} #{i.direction} To  #{i.endpoint.name}"
			end
			#puts "From #{edge[1].point.name} #{edge[1].direction} To  #{edge[1].endpoint.name}"
	   end
	  
   assert !available_paths.empty?

end




=begin
  #FIXME: Error: ActiveRecord::RecordInvalid: Validation failed: Endpoint can't be blank
  test "illegally adding point to path directly" do
    path = Path.new
    path.save!
    assert path.valid?
    
    point_sherman = points(:point_sherman)
    assert !(path.points << point_sherman)
    #point_sherman.belongs_to path
  end
  
=end

  #FIXME: Add as edge, not point
  test "adding path with single edge" do
    path = Path.new
    path.save!
    assert path.valid?

    assert path.edges << @s_r

    # assert that edge is associated with path
    assert path.id && @s_r.path_id #check that neither is nil
    assert_equal path.id, @s_r.path_id
    assert_equal 1, path.edges.size
  end

  test "adding path with two edges" do
    path = Path.new
    path.save!
    assert path.valid?

    assert path.edges << @s_r
    assert path.edges << @r_g

    # assert that each of the edges is actually associated with path
    assert path.id && @s_r.path_id #check that neither is nil
    assert_equal path.id, @s_r.path_id

    assert path.id && @r_g.path_id #check that neither is nil
    assert_equal path.id, @r_g.path_id

    assert_equal 2, path.edges.size
    
    #puts path.edges.inspect
  end

end
