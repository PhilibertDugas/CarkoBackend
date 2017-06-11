require 'test_helper'

class CustomerReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reservation = reservations(:one)
    @customer = @reservation.customer
    @stripe_helper = StripeMock.create_test_helper
    StripeMock.start
  end

  teardown do
    StripeMock.stop
  end

  test "should create reservation" do
    stripe_customer = Stripe::Customer.create(email: @customer.email).id
    payload = {
      reservation: {
        is_active: @reservation.is_active,
        start_time: @reservation.start_time,
        stop_time: @reservation.stop_time,
        parking_id: @reservation.parking_id,
        vehicule_id: @reservation.vehicule_id,
        total_cost: @reservation.total_cost,
        charge: { amount: 65, currency: 'CAD', customer: stripe_customer },
        event_id: events(:canadien).id
      }
    }
    assert_difference('Reservation.count') do
      post customer_reservations_url(@customer), params: payload, headers: auth_headers, as: :json
      assert_response 201
    end

  end

  test "#index should show all reservations for a given customer" do
    get customer_reservations_url(@customer), headers: auth_headers, as: :json
    assert_response :ok
    assert_equal 2, JSON.parse(body).count
  end

  test "should show reservation" do
    get customer_reservation_url(@customer, @reservation), headers: auth_headers, as: :json
    assert_response :success
  end

  test "should update reservation" do
    patch customer_reservation_url(@customer, @reservation), headers: auth_headers, params: { reservation: { is_active: false } }, as: :json
    assert_response 200
  end

  test "should destroy reservation" do
    assert_difference('Reservation.count', -1) do
      delete customer_reservation_url(@customer, @reservation), headers: auth_headers, as: :json
    end

    assert_response 204
  end
end
