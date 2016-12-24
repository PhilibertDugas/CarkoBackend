require 'test_helper'

class FreeParkingJobTest < ActiveJob::TestCase
  test "#perform sets the parking as available" do
    @parking = parkings(:busy_parking)
    assert_equal false, @parking.is_available
    FreeParkingJob.perform_now(@parking.id)
    @parking.reload
    assert_equal true, @parking.is_available
  end
end
