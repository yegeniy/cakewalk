require 'test_helper'

class EdgeTest < ActiveSupport::TestCase
  fixtures :points

  def setup
    @point_sherman = points(:point_sherman)
    @point_rose = points(:point_rose)

    @s_r = Edge.new(:point_id    => @point_sherman.id,
                   :endpoint_id => @point_rose.id)
  end

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "invalid without point/endpoint" do
    edge = Edge.new
    assert !edge.valid?
    assert edge.errors.invalid?(:point)
    assert edge.errors.invalid?(:endpoint)
  end

  test "valid with point/endpoint" do
    assert @s_r.valid?
  end

  #TODO: shouldn't it not be passing
  test "adding nonexistant path_id to edge" do
    invalid_path_id = -101234
    @s_r.path_id = invalid_path_id

    assert_equal invalid_path_id, @s_r.path_id
  end
end
