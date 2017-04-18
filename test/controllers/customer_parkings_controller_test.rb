require 'test_helper'

class CustomerParkingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parking = parkings(:one)
    @customer = customers(:one)
  end

  test "should create parking" do
    assert_difference('Parking.count') do
      post customer_parkings_url(@customer), params: {
        parking: {
          address: @parking.address,
          customer_id: @parking.customer_id,
          latitude: @parking.latitude,
          longitude: @parking.longitude,
          photo_url: @parking.photo_url,
          price: @parking.price
        }
      }, headers: auth_headers, as: :json
    end

    assert_response 201
  end

  test "should update parking" do
    patch customer_parking_url(@customer, @parking), params: {
      parking: {
        address: @parking.address,
        customer_id: @parking.customer_id,
        latitude: @parking.latitude,
        longitude: @parking.longitude,
        photo_url: @parking.photo_url,
        price: @parking.price
      }
    }, headers: auth_headers, as: :json
    assert_response 200
  end

  test "should destroy parking" do
    assert_difference('Parking.count', -1) do
      delete customer_parking_url(@customer, @parking), headers: auth_headers, as: :json
    end

    assert_response 204
  end
end
