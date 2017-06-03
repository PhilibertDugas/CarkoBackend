require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:authenticated_customer)
    @stripe_helper = StripeMock.create_test_helper
    StripeMock.start
  end

  teardown do
    StripeMock.stop
  end

  test "should create customer" do
    customer = Customer.new(
      email: "philibert.testing@gmail.com",
      first_name: "Philibert",
      last_name: "Testing",
      firebase_id: "2"
    )
    assert_difference("Customer.count") do
      post customers_url, params: {
        customer: {
          email: customer.email,
          firebase_id: customer.firebase_id,
          first_name: customer.first_name,
          last_name: customer.last_name
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

  test "#show return bad request when stripe has an error" do
    StripeMock.prepare_error(Stripe::StripeError.new("Customer not found"), :get_customer)
    get customer_url(@customer.id, type: "stripe")
    assert_response :bad_request
  end

  test "should update customer" do
    patch customer_url(@customer.id), params: {
      customer: {
        email: @customer.email,
        firebase_id: @customer.firebase_id,
        first_name: @customer.first_name,
        last_name: @customer.last_name
      }
    }, headers: auth_headers, as: :json
    assert_response 200
  end

  test "should destroy customer" do
    assert_difference("Customer.count", -1) do
      delete customer_url(@customer.id), headers: auth_headers, as: :json
    end

    assert_response 204
  end
end
