class SourcesController < ApplicationController
  before_action :set_customer

  def create
    begin
      stripe_customer = Stripe::Customer.retrieve(@customer.stripe_id)
      stripe_customer.sources.create(source: customer_params[:source])
      render status: :created
    rescue Stripe::StripeError => e
      render json: e.message, status: :bad_request
    end
  end

  def default_source
    begin
      stripe_customer = Stripe::Customer.retrieve(@customer.stripe_id)
      stripe_customer.default_source = customer_params[:default_source]
      stripe_customer.save
      render status: :ok
    rescue Stripe::StripeError => e
      render json: e.message, status: :bad_request
    end
  end

  private

  def set_customer
    @customer = Customer.find_by(firebase_id: params[:customer_id])
  end

  def customer_params
    params.require(:customer).permit(:firebase_id, :source, :default_source)
  end
end
