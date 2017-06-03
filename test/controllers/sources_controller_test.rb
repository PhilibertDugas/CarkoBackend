require 'test_helper'

class SourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:authenticated_customer)
    @stripe_helper = StripeMock.create_test_helper
    StripeMock.start
  end

  teardown do
    StripeMock.stop
  end

  test "#sources adds a source to the customer" do
    id = Stripe::Customer.create(email: @customer.email).id
    @customer.update!(stripe_id: id)
    post customer_sources_url(@customer), params: {
      customer: { source: @stripe_helper.generate_card_token }
    }, headers: auth_headers
    assert_response :created
  end

  test "#sources returns bad request when there is a invalid card token" do
    id = Stripe::Customer.create(email: @customer.email).id
    @customer.update!(stripe_id: id)
    StripeMock.prepare_error(Stripe::StripeError.new("Invalid source"), :create_source)
    post customer_sources_url(@customer), params: {
      customer: { source: @stripe_helper.generate_card_token }
    }, headers: auth_headers
    assert_response :bad_request
  end

  test "#default_source adds the default source to the customer" do
    id = Stripe::Customer.create(email: @customer.email).id
    @customer.update!(stripe_id: id)
    post customer_default_source_url(@customer), params: {
      customer: { default_source: @stripe_helper.generate_card_token }
    }, headers: auth_headers
    assert_response :ok
  end

  test "#default_source returns bad request when there is a invalid card token" do
    id = Stripe::Customer.create(email: @customer.email).id
    @customer.update!(stripe_id: id)
    StripeMock.prepare_error(Stripe::StripeError.new("Invalid default source"), :update_customer)
    post customer_default_source_url(@customer), params: {
      customer: { source: @stripe_helper.generate_card_token }
    }, headers: auth_headers
    assert_response :bad_request
  end
end
