class CustomersController < ApplicationController
  before_action :set_customer, except: [:index, :create]

  def index
    @customers = Customer.all

    render json: @customers
  end

  def show
    begin
      stripe_customer = Stripe::Customer.retrieve(@customer.stripe_id)
      render json: stripe_customer.to_json, status: :ok
    rescue Stripe::StripeError => e
      render json: e.message, status: :not_found
    end
  end

  def create
    stripe_customer = Stripe::Customer.create(email: customer_params[:email])
    new_customer_params = customer_params.merge(stripe_id: stripe_customer.id)
    @customer = Customer.new(new_customer_params)
    if @customer.save
      render json: @customer, status: :created, location: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @customer.update(customer_params)
      render json: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
  end

  def sources
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
      stripe_customer.default_source = params[:default_source]
      stripe_customer.save
      render status: :ok
    rescue Stripe::StripeError => e
      render json: e.message, status: :bad_request
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find_by(firebase_id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def customer_params
      params.require(:customer).permit(:email, :first_name, :last_name, :firebase_id, :source)
    end
end
