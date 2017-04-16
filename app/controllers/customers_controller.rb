class CustomersController < ApplicationController
  before_action :set_customer, except: [:create, :show]
  before_action :authenticate_customer, :authorize_customer, except: [:show, :create]

  def show
    current_customer = Customer.find_by(firebase_id: params[:id])
    if params[:type] == 'stripe'
      stripe_customer = Stripe::Customer.retrieve(current_customer.stripe_id)
      render json: stripe_customer.to_json, status: :ok
    else
      render json: current_customer.to_json
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
