require 'test_helper'

class ParkingTest < ActiveSupport::TestCase
  setup do
    @monday = Date.new(2017, 06, 05)
  end
  test "#available? returns true for the index 0 when monday is available" do
    parking = parkings(:alouette_parking)
    assert_equal true, parking.available?(@monday)
  end

  test "#available? returns false for the index 0 when monday is not available" do
    parking = parkings(:alouette_unavailable_on_monday)
    assert_equal false, parking.available?(@monday)
  end
end
