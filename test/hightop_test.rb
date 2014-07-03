require_relative "test_helper"

class TestHightop < Minitest::Test

  def setup
    Visit.delete_all
  end

  def test_top
    Visit.create!(city: "San Francisco")
    expected = {
      "San Francisco" => 1
    }
    assert_equal expected, Visit.top(:city)
  end

end
