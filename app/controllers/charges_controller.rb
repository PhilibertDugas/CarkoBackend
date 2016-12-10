class ChargesController < ApplicationController
  def create
    begin
      charge = Stripe::Charge.create(charge_params)
      render json: charge, status: :created
    rescue Stripe::CardError => e
      render json: e.message, status: :bad_request
    end
  end

  private

  def charge_params
    params.require(:charge).permit(:amount, :customer, :currency)
  end
end
