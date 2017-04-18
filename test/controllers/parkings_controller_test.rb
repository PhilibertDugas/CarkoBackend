require 'test_helper'

class ParkingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parking = parkings(:one)
  end

  test "should get index" do
    get parkings_url, as: :json
    assert_response :success
  end

  test "should show parking" do
    get parking_url(@parking), as: :json
    assert_response :success
  end
end
