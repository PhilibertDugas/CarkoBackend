class CustomerParkingRevenuesController < CustomerAreaController
  def index
    @parking = Parking.find(params[:parking_id])
    render json: { total: @parking.total_revenue }
  end
end
