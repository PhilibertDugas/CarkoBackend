require 'test_helper'

class CustomerParkingRevenuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parking = parkings(:villeray)
    @customer = customers(:authenticated_customer)
  end

  test "#show should return the total revenue of the parking" do
    get customer_parking_revenues_url(customer_id: @customer.id, parking_id: @parking.id), headers: auth_headers, as: :json
    assert_response :ok
    expected_result = { "total" => 65.0 }
    assert_equal expected_result, JSON.parse(body)
  end
end
