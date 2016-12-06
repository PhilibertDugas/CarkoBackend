class VehiculesController < ApplicationController
  before_action :set_vehicule, only: [:show, :update, :destroy]

  def index
    @vehicules = Vehicule.all

    render json: @vehicules
  end

  def show
    render json: @vehicule
  end

  def create
    @vehicule = Vehicule.new(vehicule_params)

    if @vehicule.save
      render json: @vehicule, status: :created, location: @vehicule
    else
      render json: @vehicule.errors, status: :unprocessable_entity
    end
  end

  def update
    if @vehicule.update(vehicule_params)
      render json: @vehicule
    else
      render json: @vehicule.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @vehicule.destroy
  end

  private

  def set_vehicule
    @vehicule = Vehicule.find(params[:id])
  end

  def vehicule_params
    params.require(:vehicule).permit(:license_plate, :make, :model, :year, :color, :province, :customer_id)
  end
end
