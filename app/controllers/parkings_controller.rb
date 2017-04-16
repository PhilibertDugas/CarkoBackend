class ParkingsController < ApplicationController
  before_action :set_parking, only: [:show, :update, :destroy]
  before_action :authenticate_customer

  def index
    @parkings = Parking.all
    render json: @parkings
  end

  def show
    render json: @parking
  end

  def create
    @parking = Parking.new(parking_params)
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
      :customer_id,
      :is_available,
      :is_complete,
      availability_info: [:stop_time, :start_time, :always_available, days_available: []]
    )
  end
end
