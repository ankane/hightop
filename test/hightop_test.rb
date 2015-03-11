require_relative "test_helper"

class TestHightop < Minitest::Test
  def setup
    Visit.delete_all
  end

  def test_top
    create_city("San Francisco", 3)
    create_city("Chicago", 2)
    expected = {
      "San Francisco" => 3,
      "Chicago" => 2
    }
    assert_equal expected, Visit.top(:city)
  end

  def test_limit
    create_city("San Francisco", 3)
    create_city("Chicago", 2)
    create_city("Boston", 1)
    expected = {
      "San Francisco" => 3,
      "Chicago" => 2
    }
    assert_equal expected, Visit.top(:city, 2)
    assert_equal expected, Visit.limit(2).top(:city)
  end

  def test_nil_values
    create_city("San Francisco", 3)
    create_city(nil, 2)
    expected = {
      "San Francisco" => 3
    }
    assert_equal expected, Visit.top(:city)
  end

  def test_nil_option
    create_city("San Francisco", 3)
    create_city(nil, 2)
    expected = {
      "San Francisco" => 3,
      nil => 2
    }
    assert_equal expected, Visit.top(:city, nil: true)
  end

  def test_multiple_groups
    create_city("San Francisco")
    expected = {
      ["San Francisco", "San Francisco"] => 1
    }
    assert_equal expected, Visit.top([:city, :city])
  end

  def test_expressions
    create_city("San Francisco")
    expected = {
      "san francisco" => 1
    }
    assert_equal expected, Visit.top("LOWER(city)")
  end

  def test_uniq
    create(city: "San Francisco", user_id: 1)
    create(city: "San Francisco", user_id: 1)
    expected = {
      "San Francisco" => 1
    }
    assert_equal expected, Visit.top(:city, uniq: :user_id)
  end

  def test_min
    create_city("San Francisco", 3)
    create_city("Chicago", 2)
    expected = {
      "San Francisco" => 3
    }
    assert_equal expected, Visit.top(:city, min: 3)
  end

  def create_city(city, count = 1)
    create({city: city}, count)
  end

  def create(attributes, count = 1)
    count.times { Visit.create!(attributes) }
  end
end
