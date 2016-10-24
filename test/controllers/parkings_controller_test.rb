require 'test_helper'

class ParkingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parking = parkings(:one)
  end

  test "should get index" do
    get parkings_url, as: :json
    assert_response :success
  end

  test "should create parking" do
    assert_difference('Parking.count') do
      post parkings_url, params: {
        parking: {
          address: @parking.address,
          customer_id: @parking.customer_id,
          latitude: @parking.latitude,
          longitude: @parking.longitude,
          photourl: @parking.photourl,
          price: @parking.price
        }
      }, as: :json
    end

    assert_response 201
  end

  test "should show parking" do
    get parking_url(@parking), as: :json
    assert_response :success
  end

  test "should update parking" do
    patch parking_url(@parking), params: {
      parking: {
        address: @parking.address,
        customer_id: @parking.customer_id,
        latitude: @parking.latitude,
        longitude: @parking.longitude,
        photourl: @parking.photourl,
        price: @parking.price
      }
    }, as: :json
    assert_response 200
  end

  test "should destroy parking" do
    assert_difference('Parking.count', -1) do
      delete parking_url(@parking), as: :json
    end

    assert_response 204
  end
end