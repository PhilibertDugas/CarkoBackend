class EventParkingsController < ApplicationController
  # parkings for an event should be public
  skip_before_action :authenticate_customer
  before_action :set_event

  def index
    parkings = @event.available_parkings
    render json: parkings
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
