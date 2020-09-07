require_relative "test_helper"

class HightopTest < Minitest::Test
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
    assert_equal expected, Visit.limit(2).top(:city) unless mongoid?
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
    create(city: "San Francisco", user_id: "123")
    expected = {
      ["San Francisco", "123"] => 1
    }
    assert_equal expected, Visit.top([:city, :user_id])
  end

  def test_expression
    create_city("San Francisco")
    expected = {
      "san francisco" => 1
    }

    if mongoid?
      assert_equal expected, Visit.all.project(city: {"$toLower" => "$city"}).top(:city)
    else
      assert_equal expected, Visit.top(Arel.sql("LOWER(city)"))
    end
  end

  def test_expression_no_arel
    skip if mongoid?

    message = "[hightop] Non-attribute argument: LOWER(city). Use Arel.sql() for known-safe values. This will raise an error in Hightop 0.3.0\n"
    _, stderr = capture_io do
      Visit.top("LOWER(city)")
    end
    assert_match message, stderr
  end

  def test_distinct
    create(city: "San Francisco", user_id: 1)
    create(city: "San Francisco", user_id: 1)
    expected = {
      "San Francisco" => 1
    }
    assert_equal expected, Visit.top(:city, distinct: :user_id)
  end

  def test_distinct_expression
    skip if mongoid?

    create(city: "San Francisco", user_id: 1)
    create(city: "San Francisco", user_id: 1)
    expected = {
      "San Francisco" => 1
    }
    assert_equal expected, Visit.top(:city, distinct: Arel.sql("(user_id)"))
  end

  def test_distinct_expression_no_arel
    skip if mongoid?

    message = "[hightop] Non-attribute argument: (user_id). Use Arel.sql() for known-safe values. This will raise an error in Hightop 0.3.0\n"
    _, stderr = capture_io do
      Visit.top(:city, distinct: "(user_id)")
    end
    assert_match message, stderr
  end

  def test_uniq
    create(city: "San Francisco", user_id: 1)
    create(city: "San Francisco", user_id: 1)
    expected = {
      "San Francisco" => 1
    }
    assert_equal expected, Visit.top(:city, uniq: :user_id)
  end

  def test_uniq_expression
    skip if mongoid?

    create(city: "San Francisco", user_id: 1)
    create(city: "San Francisco", user_id: 1)
    expected = {
      "San Francisco" => 1
    }
    assert_equal expected, Visit.top(:city, uniq: Arel.sql("(user_id)"))
  end

  def test_uniq_expression_no_arel
    skip if mongoid?

    message = "[hightop] uniq is deprecated. Use distinct instead\n[hightop] Non-attribute argument: (user_id). Use Arel.sql() for known-safe values. This will raise an error in Hightop 0.3.0\n"
    _, stderr = capture_io do
      Visit.top(:city, uniq: "(user_id)")
    end
    assert_match message, stderr
  end

  def test_min
    create_city("San Francisco", 3)
    create_city("Chicago", 2)
    expected = {
      "San Francisco" => 3
    }
    assert_equal expected, Visit.top(:city, min: 3)
  end

  def test_min_distinct
    create(city: "San Francisco", user_id: 1)
    create(city: "San Francisco", user_id: 1)
    create(city: "San Francisco", user_id: 2)
    create(city: "Chicago", user_id: 1)
    create(city: "Chicago", user_id: 1)
    expected = {
      "San Francisco" => 2
    }
    assert_equal expected, Visit.top(:city, min: 2, distinct: :user_id)
  end

  def test_where
    create_city("San Francisco")
    create_city("Chicago")
    expected = {
      "San Francisco" => 1
    }
    assert_equal expected, Visit.where(city: "San Francisco").top(:city)
  end

  def test_where_options
    create(city: "San Francisco", user_id: 1)
    create(city: "San Francisco", user_id: 1)
    create(city: "San Francisco", user_id: 2)
    create(city: "Chicago", user_id: 1)
    expected = {
      "San Francisco" => 2
    }
    assert_equal expected, Visit.where(city: "San Francisco").top(:city, distinct: :user_id)
  end

  def test_relation_block
    skip if defined?(ActiveRecord) && ActiveRecord::VERSION::MAJOR < 5

    create_city("San Francisco", 3)
    create_city("Chicago", 2)
    expected = {
      "San Francisco" => 3,
      "Chicago" => 2
    }
    assert_equal expected, Visit.all.top { |v| v.city }

    # TODO maybe support
    # assert_equal expected, Visit.top { |v| v.city }
  end

  def test_bad_argument
    assert_raises(ArgumentError) do
      Visit.top(:city, boom: true)
    end
  end

  private

  def create_city(city, count = 1)
    create({city: city}, count)
  end

  def create(attributes, count = 1)
    count.times { Visit.create!(attributes) }
  end

  def mongoid?
    defined?(Mongoid)
  end
end
