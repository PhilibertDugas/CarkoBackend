class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]

  def show
    render json: @reservation
  end

  def create
    begin
      parking = Parking.find_by(id: reservation_params[:parking_id])
      charge = Charge.new(
        amount: reservation_params[:charge][:amount],
        currency: reservation_params[:charge][:currency],
        customer: reservation_params[:charge][:customer],
        parking: parking
      )
      stripe_charge = charge.save
      @reservation = Reservation.new(reservation_params.merge(charge: stripe_charge.id))

      if @reservation.save && @reservation.parking.update(is_available: false)
        render json: @reservation, status: :created, location: @reservation
      else
        render json: @reservation.errors, status: :unprocessable_entity
      end
    rescue Stripe::CardError => e
      render json: e.message, status: :bad_request
    end
  end

  def update
    if @reservation.update(reservation_params)
      render json: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(
      :is_active,
      :start_time,
      :stop_time,
      :parking_id,
      :customer_id,
      :vehicule_id,
      :total_cost,
      charge: [:amount, :customer, :currency, :parking_id]
    )
  end
end
