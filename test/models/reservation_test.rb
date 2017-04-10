require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  setup do
    @reservation = reservations(:one)
  end

  test '#create_charge raises an error when the reservation is not valid' do
    @reservation.customer = nil
    charge_params = { amount: 10.0, currency: 'CAD' }
    assert_raise StandardError do
      @reservation.create_charge(charge_params, parking_id: 1)
    end
  end

  test '#create_charge sets the charge on the reservation' do
    Charge.any_instance.expects(:save).returns('ch_19test')
    @reservation.charge = nil

    charge_params = { amount: 10.0, currency: 'CAD' }
    @reservation.create_charge(charge_params, parking_id: 1)

    assert_equal 'ch_19test', @reservation.charge
  end

  test 'new reservations queue a free parking job' do
    reservation = Reservation.new(
      is_active: true,
      start_time: '00:00',
      stop_time: '17:00',
      parking_id: parkings(:one).id,
      customer_id: customers(:one).id,
      total_cost: 65,
      vehicule_id: vehicules(:one).id
    )

    assert_enqueued_jobs 1, only: FreeParkingJob do
      reservation.save
    end
  end
end
