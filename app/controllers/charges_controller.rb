class ChargesController < ApplicationController
  def create
    begin
      parking_owner = Parking.find_by(id: charge_params[:parking_id]).customer
      application_fee = (0.2 * charge_params[:amount]).round
      charge = Stripe::Charge.create(
        amount: charge_params[:amount],
        customer: charge_params[:customer],
        currency: charge_params[:currency],
        destination: parking_owner.account_id,
        application_fee: application_fee
      )

      render json: charge, status: :created
    rescue Stripe::CardError => e
      render json: e.message, status: :bad_request
    end
  end

  private

  def charge_params
    params.require(:charge).permit(:amount, :customer, :currency, :parking_id)
  end
end
