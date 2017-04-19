class ApplicationController < ActionController::API
  include Authorizable

  before_action :authenticate_customer

  rescue_from Stripe::StripeError, with: :stripe_error
  rescue_from StandardError, with: :general_error

  private

  def stripe_error(error)
    render json: { error: error.message }, status: :bad_request
  end

  def general_error(error)
    logger.error "Reservation is not valid: #{error.message}"
    render json: { error: error.message }, status: :bad_request
  end
end
