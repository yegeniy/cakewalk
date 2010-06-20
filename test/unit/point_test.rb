require 'test_helper'

class PointTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "adding an empty point" do
    point = Point.new
    point.save!

    assert point.valid?
  end

  test "adding a single point" do
    params = {  :name =>        "Sherman Hall, Brandeis University",
                :address =>     "415 South St.",
                :city =>        "Waltham",
                :state =>       "MA",
                :zip =>         "02453"}
    point = Point.new(params)
    assert point.valid?
  end

end
