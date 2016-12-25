class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]

  def show
    render json: @reservation
  end

  def create
    begin
      @reservation = Reservation.new(reservation_params)
      raise StandardError.new @reservation.errors.full_messages.to_sentence unless @reservation.valid?

      parking = Parking.find_by(id: reservation_params[:parking_id])
      charge = Charge.new(reservation_params[:charge].to_h, parking: parking)
      stripe_charge = charge.save
      @reservation.charge = stripe_charge.id

      if @reservation.save_with_parking
        @reservation.free_parking_later
        render json: @reservation, status: :created, location: @reservation
      else
        render json: @reservation.errors, status: :unprocessable_entity
      end
    rescue Stripe::CardError => e
      render json: e.message, status: :bad_request
    rescue StandardError => e
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
