require_relative "test_helper"

class EnumerableTest < Minitest::Test
  def test_array
    top = [:a, :b, :b].top
    expected = {
      b: 2,
      a: 1
    }
    assert_equal expected, top
    assert_equal top.keys, expected.keys
  end

  def test_hash
    top = {
      a: "a",
      b: "b",
      c: "b"
    }.top
    # same as methods like tally
    expected = {
      [:a, "a"] => 1,
      [:b, "b"] => 1,
      [:c, "b"] => 1
    }
    assert_equal expected, top
    assert_equal top.keys, expected.keys
  end

  def test_array_block
    top = [:a, :b, :b].top { |v| "#{v}!" }
    expected = {
      "b!" => 2,
      "a!" => 1
    }
    assert_equal expected, top
    assert_equal top.keys, expected.keys
  end

  def test_hash_block
    top = {
      a: "a",
      b: "b",
      c: "b"
    }.top { |k, v| "#{v}!" }
    expected = {
      "b!" => 2,
      "a!" => 1
    }
    assert_equal expected, top
    assert_equal top.keys, expected.keys
  end

  def test_limit
    top = [:a, :b, :b].top(1)
    expected = {
      b: 2
    }
    assert_equal expected, top
  end

  def test_limit_order
    top = [:b, :c].top(1)
    expected = {
      b: 1
    }
    assert_equal expected, top

    top = [:c, :b].top(1)
    expected = {
      c: 1
    }
    assert_equal expected, top
  end

  def test_nil_values
    top = [:a, nil, nil].top
    expected = {
      a: 1
    }
    assert_equal expected, top
    assert_equal top.keys, expected.keys
  end

  def test_nil_option
    top = [:a, nil, nil].top(nil: true)
    expected = {
      nil => 2,
      a: 1
    }
    assert_equal expected, top
    assert_equal top.keys, expected.keys
  end

  def test_multiple_groups
    top = [:a, :b, :b].top { |v| [v, :z] }
    expected = {
      [:b, :z] => 2,
      [:a, :z] => 1
    }
    assert_equal expected, top
  end

  def test_min
    top = [:a, :b, :b].top(min: 2)
    expected = {
      b: 2
    }
    assert_equal expected, top
  end

  def test_too_many_arguments
    assert_raises(ArgumentError) do
      [].top(1, 2)
    end
  end
end
