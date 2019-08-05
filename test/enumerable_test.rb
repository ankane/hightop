require_relative "test_helper"
require "hightop/enumerable"

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
    }.top { |k, v| v.to_sym }
    expected = {
      b: 2,
      a: 1
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
end
