class ChargesController < ApplicationController
  def create
		begin
			Stripe::Charge.create(
				amount: charge_params[:amount],
				currency: charge_params[:currency],
				source: charge_params[:source]
			)
		rescue Stripe::CardError => e
			render json: e.message, status: :bad_request
		end
  end

  private

  def charge_params
    params.require(:charge).permit(:amount, :source, :currency)
  end
end
