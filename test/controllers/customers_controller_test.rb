require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
    @stripe_helper = StripeMock.create_test_helper
    StripeMock.start
  end

  teardown do
    StripeMock.stop
  end

  test "should get index" do
    get customers_url, as: :json
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
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
    id = Stripe::Customer.create(email: @customer.email).id
    @customer.update!(stripe_id: id)
    get customer_url(@customer.firebase_id), as: :json
    assert_response :success
  end

  test "#show return not found when stripe has an error" do
    StripeMock.prepare_error(Stripe::StripeError.new("Customer not found"), :get_customer)
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

  test "#sources adds a source to the customer" do
    id = Stripe::Customer.create(email: @customer.email).id
    @customer.update!(stripe_id: id)
    post sources_customer_url(@customer.firebase_id), params: {
      customer: { source: @stripe_helper.generate_card_token }
    }
    assert_response :created
  end

  test "#sources returns bad request when there is a invalid card token" do
    id = Stripe::Customer.create(email: @customer.email).id
    @customer.update!(stripe_id: id)
    StripeMock.prepare_error(Stripe::StripeError.new("Invalid source"), :create_source)
    post sources_customer_url(@customer.firebase_id), params: {
      customer: { source: @stripe_helper.generate_card_token }
    }
    assert_response :bad_request
  end

  test "#default_source adds the default source to the customer" do
    id = Stripe::Customer.create(email: @customer.email).id
    @customer.update!(stripe_id: id)
    post default_source_customer_url(@customer.firebase_id), params: {
      customer: { default_source: @stripe_helper.generate_card_token }
    }
    assert_response :ok
  end

  test "#default_source returns bad request when there is a invalid card token" do
    id = Stripe::Customer.create(email: @customer.email).id
    @customer.update!(stripe_id: id)
    StripeMock.prepare_error(Stripe::StripeError.new("Invalid default source"), :update_customer)
    post default_source_customer_url(@customer.firebase_id), params: {
      customer: { source: @stripe_helper.generate_card_token }
    }
    assert_response :bad_request
  end
end
