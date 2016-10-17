require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
  end

  test "should get index" do
    get customers_url, as: :json
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      Stripe::Customer.expects(:create).returns(stripe_customer)

      post customers_url, params: {
        customer: {
          email: @customer.email,
          firebase_id: @customer.firebase_id,
          first_name: @customer.first_name,
          last_name: @customer.last_name
        }
      }, as: :json
    end

    assert_response 201
  end

  test "#show retrieves the stripe information" do
    Stripe::Customer.expects(:retrieve).returns(stripe_customer)
    get customer_url(@customer.firebase_id), as: :json
    assert_response :success
  end

  test "#show return not found when stripe has an error" do
    Stripe::Customer.expects(:retrieve).raises(Stripe::StripeError.new('Customer invalid'))
    get customer_url(@customer.firebase_id), as: :sjon
    assert_response :not_found
  end

  test "should update customer" do
    patch customer_url(@customer.firebase_id), params: {
      customer: {
        email: @customer.email,
        firebase_id: @customer.firebase_id,
        first_name: @customer.first_name,
        last_name: @customer.last_name
      }
    }, as: :json
    assert_response 200
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete customer_url(@customer.firebase_id), as: :json
    end

    assert_response 204
  end

  private

  def stripe_customer
    customer = Stripe::Customer.new(id: '1')
  end
end
