class CustomerActiveReservationsController < CustomerAreaController
  def index
    @reservations = Reservation.where(customer_id: @customer.id, is_active: true)
    render json: @reservations
  end
end
