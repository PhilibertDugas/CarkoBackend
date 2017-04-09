require 'test_helper'

class VehiculesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vehicule = vehicules(:one)
    @customer = @vehicule.customer
  end

  test "should create vehicule" do
    assert_difference('Vehicule.count') do
      post customer_vehicules_url(@customer), params: {
        vehicule: {
          license_plate: 'JXJXJX',
          make: 'Honda',
          model: 'Civic',
          year: 2010,
          province: 'QC'
        }
      }
    end

    assert_response 201
  end

  test "should show vehicule" do
    get customer_vehicule_url @vehicule, customer_id: @customer
    assert_response :success
  end

  test "should update vehicule" do
    patch customer_vehicule_url @vehicule, customer_id: @customer, params: { vehicule: { color: 'red'  } }
    assert_response 200
  end

  test "should destroy vehicule" do
    assert_difference('Vehicule.count', -1) do
      delete customer_vehicule_url @vehicule, customer_id: @customer
    end

    assert_response 204
  end
end
