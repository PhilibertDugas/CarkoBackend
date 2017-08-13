require 'test_helper'

class CustomerParkingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parking = parkings(:villeray)
    @customer = customers(:authenticated_customer)
  end

  test "#show should return the total_revenue for the parking" do
    get customer_parking_url(@customer, @parking), headers: auth_headers, as: :json
    assert_response :ok
    assert_equal 8.0, JSON.parse(body)["total_revenue"]
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

  test "#create should accept an array of photo urls" do
    assert_difference('Parking.count') do
      post customer_parkings_url(@customer), params: {
        parking: {
          address: 'Super Unique Address',
          customer_id: @parking.customer_id,
          latitude: @parking.latitude,
          longitude: @parking.longitude,
          photo_url: @parking.photo_url,
          price: @parking.price,
          multiple_photo_urls: ['hey', 'hueh', 'hueeh']
        }
      }, headers: auth_headers, as: :json
    end

    assert_response 201
    inserted_parking = Parking.find_by(address: 'Super Unique Address')
    assert_equal 3, inserted_parking.multiple_photo_urls.count
  end

  test "#create should accept an array of availability infos" do
    availability_info = {
      sunday_available: true,
      monday_available: false,
      tuesday_available: false,
      wednesday_available: false,
      thursday_available: false,
      friday_available: false,
      saturday_available: false,
      start_hour: '00:00',
      stop_hour: '11:17',
    }
    assert_difference('Parking.count') do
      post customer_parkings_url(@customer), params: {
        parking: {
          address: 'Super Unique Address',
          customer_id: @parking.customer_id,
          latitude: @parking.latitude,
          longitude: @parking.longitude,
          photo_url: @parking.photo_url,
          price: @parking.price,
          parking_availability_infos: [availability_info]
        }
      }, headers: auth_headers, as: :json
    end

    assert_response 201
    inserted_parking = Parking.find_by(address: 'Super Unique Address')
    assert_equal 1, inserted_parking.parking_availability_infos.count
    assert_equal true, inserted_parking.parking_availability_infos.first.sunday_available
    assert_equal '00:00', inserted_parking.parking_availability_infos.first.start_hour
    assert_equal '11:17', inserted_parking.parking_availability_infos.first.stop_hour
  end

  test "should update parking" do
    patch customer_parking_url(@customer, @parking), params: {
      parking: {
        address: @parking.address,
        customer_id: @parking.customer_id,
        latitude: @parking.latitude,
        longitude: @parking.longitude,
        photo_url: @parking.photo_url,
        price: @parking.price,
        is_deleted: false
      }
    }, headers: auth_headers, as: :json
    assert_response 200
  end

  test "update accepts an array of parking availability info" do
    patch customer_parking_url(@customer, @parking), params: {
      parking: {
        parking_availability_infos: [
          {
            sunday_available: true,
            monday_available: true,
            tuesday_available: false,
            wednesday_available: false,
            thursday_available: false,
            friday_available: false,
            saturday_available: true,
            start_hour: "00:01",
            stop_hour: "01:00",
            price: 2.00
          }
        ]
      }
    }, headers: auth_headers, as: :json
    assert_response 200

    @parking.reload
    info = @parking.parking_availability_infos.first
    assert_equal true, info.sunday_available
    assert_equal true, info.monday_available
    assert_equal false, info.tuesday_available
    assert_equal false, info.wednesday_available
    assert_equal false, info.thursday_available
    assert_equal false, info.friday_available
    assert_equal true, info.saturday_available
    assert_equal "00:01", info.start_hour
    assert_equal "01:00", info.stop_hour
    assert_equal 2.00, info.price
  end

  test "should destroy parking" do
    assert_difference('Parking.count', -1) do
      delete customer_parking_url(@customer, @parking), headers: auth_headers, as: :json
    end

    assert_response 204
  end
end
