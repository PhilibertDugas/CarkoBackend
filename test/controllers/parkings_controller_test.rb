require 'test_helper'

class ParkingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parking = parkings(:villeray)
  end

  test "should get index" do
    get parkings_url, headers: auth_headers, as: :json
    assert_response :success
  end

  test "should show parking" do
    get parking_url(@parking), headers: auth_headers, as: :json
    assert_response :success
  end
end
