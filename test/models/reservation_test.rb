require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  setup do
    @reservation = reservations(:one)
  end

  test '#create_charge raises an error when the reservation is not valid' do
    @reservation.customer = nil
    charge_params = { amount: 10.0, currency: 'CAD' }
    assert_raise StandardError do
      @reservation.create_charge(charge_params, parking_id: parkings(:villeray).id)
    end
  end

  test '#create_charge sets the charge on the reservation' do
    Charge.any_instance.expects(:save).returns('ch_19test')
    @reservation.charge = nil

    charge_params = { amount: 10.0, currency: 'CAD' }
    @reservation.create_charge(charge_params, parking_id: parkings(:villeray).id)

    assert_equal 'ch_19test', @reservation.charge
  end

  test '#create_charge raises an error when the parking is not available' do
    charge_params = { amount: 10.0, currency: 'CAD' }
    assert_raise StandardError do
      @reservation.create_charge(charge_params, parking_id: parkings(:busy_parking).id)
    end
  end

  test '#reserve_with_parking queues a free parking job' do
    reservation = Reservation.new(
      is_active: true,
      start_time: '2017-06-06 00:00',
      stop_time: '2017-06-06 17:00',
      parking_id: parkings(:villeray).id,
      customer_id: customers(:authenticated_customer).id,
      total_cost: 65,
      event: events(:canadien)
    )

    assert_enqueued_jobs 1, only: FreeParkingJob do
      reservation.reserve_with_parking
    end
  end
end
