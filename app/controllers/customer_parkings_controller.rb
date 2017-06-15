class CustomerParkingsController < CustomerAreaController
  before_action :set_parking, only: [:show, :update, :destroy]

  def index
    @customer = Customer.find_by(id: params[:customer_id])
    render json: @customer.parkings.where(is_delete: false)
  end

  def show
    render json: @parking
  end

  def create
    @parking = Parking.new(parking_params)
    @parking.customer = @customer
    if @parking.save
      render json: @parking, status: :created, location: @parking
    else
      render json: @parking.errors, status: :unprocessable_entity
    end
  end

  def update
    if @parking.update(parking_params)
      render json: @parking
    else
      render json: @parking.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @parking.destroy
  end

  private

  def set_parking
    @parking = Parking.find(params[:id])
  end

  def parking_params
    params.require(:parking).permit(
      :latitude,
      :longitude,
      :photo_url,
      :description,
      :price,
      :address,
      :is_available,
      :is_complete,
      :is_deleted,
      :multiple_photo_urls => [],
      availability_info: [:stop_time, :start_time, :always_available, days_available: []]
    )
  end
end
