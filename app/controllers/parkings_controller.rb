class ParkingsController < ApplicationController
  # parkings should be public
  skip_before_action :authenticate_customer

  def index
    @parkings = Parking.all
    render json: @parkings
  end

  def show
    @parking = Parking.find(params[:id])
    render json: @parking
  end
end
