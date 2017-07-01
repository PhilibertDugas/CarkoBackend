require 'test_helper'

class ReservationCreatorTest < ActiveSupport::TestCase
  setup do
    @reservation = reservations(:one)
    @charge = Charge.new(amount: 10.0, currency: 'CAD', customer: 'cus_123', parking: parkings(:villeray))
  end

  test '#process returns false when the reservation is invalid' do
    @reservation.customer = nil
    assert_equal false, ReservationCreator.process(@reservation, charge: @charge)
  end

  test '#process sets a charge on the reservation' do
    @reservation.charge = nil

    Charge.any_instance.expects(:save).returns('ch_19test')

    result = ReservationCreator.process(@reservation, charge: @charge)
    assert_equal true, result
    @reservation.reload

    assert_equal 'ch_19test', @reservation.charge
  end

  test '#process sets the application_fee and customer_revenue on the reservation' do
    @reservation.charge = nil
    Charge.any_instance.expects(:save).returns('ch_19test')

    result = ReservationCreator.process(@reservation, charge: @charge)
    assert_equal true, result
    @reservation.reload

    assert_equal 2.4, @reservation.application_fee
    assert_equal 7.6, @reservation.customer_revenue
  end

  test '#process returns false when the parking is not available' do
    @reservation.parking = parkings(:busy_parking)
    assert_equal false, ReservationCreator.process(@reservation, charge: @charge)
  end

  test '#process queues a free parking job when successful' do
    Charge.any_instance.expects(:save).returns('ch_19test')

    assert_enqueued_with(job: FreeParkingJob, args: [@reservation]) do
      result = ReservationCreator.process(@reservation, charge: @charge)
      assert_equal true, result
    end
  end

  test '#process queues all the notifications when successful' do
    Charge.any_instance.expects(:save).returns('ch_19test')

    assert_enqueued_jobs 4 do
      result = ReservationCreator.process(@reservation, charge: @charge)
      assert_equal true, result
    end
  end
end
