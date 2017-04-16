class CustomersController < ApplicationController
  before_action :set_customer, except: [:create]

  def show
    if params[:type] == 'stripe'
      stripe_customer = Stripe::Customer.retrieve(@customer.stripe_id)
      render json: stripe_customer.to_json, status: :ok
    else
      render json: @customer.to_json
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

  private

  def set_customer
    @customer = Customer.find_by(id: params[:id])
  end

  def customer_params
    params.require(:customer).permit(:email, :first_name, :last_name, :firebase_id)
  end
end
