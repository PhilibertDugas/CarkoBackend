class CustomerParkingsController < ApplicationController
  def index
    @customer = Customer.find_by(id: params[:customer_id])
    render json: @customer.parkings
  end
end
