require_relative "test_helper"

class TestHightop < Minitest::Test

  def setup
    Visit.delete_all
  end

  def test_top
    create("San Francisco", 3)
    create("Chicago", 2)
    expected = {
      "San Francisco" => 3,
      "Chicago" => 2
    }
    assert_equal expected, Visit.top(:city)
  end

  def test_limit
    create("San Francisco", 3)
    create("Chicago", 2)
    create("Boston", 1)
    expected = {
      "San Francisco" => 3,
      "Chicago" => 2
    }
    assert_equal expected, Visit.top(:city, 2)
    assert_equal expected, Visit.limit(2).top(:city)
  end

  def create(city, count = 1)
    count.times{ Visit.create!(city: city) }
  end

end
