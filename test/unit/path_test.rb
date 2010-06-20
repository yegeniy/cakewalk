require 'test_helper'

class PathTest < ActiveSupport::TestCase
  
  fixtures :points


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
