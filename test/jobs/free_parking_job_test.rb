require 'test_helper'

class FreeParkingJobTest < ActiveJob::TestCase
  test "#perform sets the parking as available" do
    @reservation = reservations(:active_reservation)
    assert_equal false, @reservation.parking.is_available
    assert_equal true, @reservation.is_active

    FreeParkingJob.perform_now(@reservation)
    @reservation.reload

    assert_equal true, @reservation.parking.is_available
    assert_equal false, @reservation.is_active
  end
end
