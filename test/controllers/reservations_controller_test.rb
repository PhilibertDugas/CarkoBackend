require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reservation = reservations(:one)
    @stripe_helper = StripeMock.create_test_helper
    StripeMock.start
  end

  teardown do
    StripeMock.stop
  end

  test "should create reservation" do
    customer = Stripe::Customer.create(email: @reservation.customer.email).id
    payload = {
      is_active: @reservation.is_active,
      start_time: @reservation.start_time,
      stop_time: @reservation.stop_time,
      parking_id: @reservation.parking_id,
      vehicule_id: @reservation.vehicule_id,
      total_cost: @reservation.total_cost,
      customer_id: @reservation.customer_id,
      charge: { amount: 65, currency: 'CAD', customer: customer }
    }
    assert_difference('Reservation.count') do
      post reservations_url, params: payload, as: :json
      assert_response 201
    end

  end

  test "should show reservation" do
    get reservation_url(@reservation), as: :json
    assert_response :success
  end

  test "should update reservation" do
    patch reservation_url(@reservation), params: { reservation: { is_active: false } }, as: :json
    assert_response 200
  end

  test "should destroy reservation" do
    assert_difference('Reservation.count', -1) do
      delete reservation_url(@reservation), as: :json
    end

    assert_response 204
  end
end
