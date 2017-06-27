class CustomerReservationsController < CustomerAreaController
  before_action :set_reservation, only: [:show, :update, :destroy]

  def index
    @reservations = Reservation.where(customer_id: @customer.id)
    render json: @reservations
  end

  def show
    render json: @reservation
  end

  def create
    reservation = Reservation.new(reservation_params)
    charge = Charge.new(
      amount: reservation_params[:charge][:amount],
      customer: reservation_params[:charge][:customer],
      currency: reservation_params[:charge][:currency],
      parking: reservation.parking,
    )
    if ReservationCreator.process(reservation, charge: charge)
      render json: reservation, status: :created
    else
      render json: reservation.errors, status: :unprocessable_entity
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
      :event_id,
      charge: [:amount, :customer, :currency, :parking_id]
    )
  end
end
