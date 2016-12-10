require 'test_helper'

class VehiculesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vehicule = vehicules(:one)
  end

  test "should get index" do
    get vehicules_url, as: :json
    assert_response :success
  end

  test "should create vehicule" do
    assert_difference('Vehicule.count') do
      post vehicules_url, params: @vehicule, as: :json
    end

    assert_response 201
  end

  test "should show vehicule" do
    get vehicule_url(@vehicule), as: :json
    assert_response :success
  end

  test "should update vehicule" do
    patch vehicule_url(@vehicule), params: { vehicule: { color: 'red'  } }, as: :json
    assert_response 200
  end

  test "should destroy vehicule" do
    assert_difference('Vehicule.count', -1) do
      delete vehicule_url(@vehicule), as: :json
    end

    assert_response 204
  end
end
