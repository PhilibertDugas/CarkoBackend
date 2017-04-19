class CustomerReservationsController < CustomerAreaController
  before_action :set_reservation, only: [:show, :update, :destroy]

  def show
    render json: @reservation
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.customer = @customer
    @reservation.create_charge(reservation_params[:charge].to_h, parking_id: reservation_params[:parking_id])
    if @reservation.reserve_with_parking
      render json: @reservation, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
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
