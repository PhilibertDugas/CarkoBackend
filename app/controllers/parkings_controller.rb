class ParkingsController < ApplicationController
  def index
    @parkings = Parking.all
    render json: @parkings
  end

  def show
    @parking = Parking.find(params[:id])
    render json: @parking
  end
end
