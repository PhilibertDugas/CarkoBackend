class EventsController < ApplicationController
  # events should be public
  skip_before_action :authenticate_customer
  before_action :set_event, only: [:show, :update, :destroy]

  def index
    @events = Event.ordered_events
    render json: @events
  end

  def show
    render json: @event
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :label,
      :latitude,
      :longitude,
      :range,
      :price,
      :start_time,
      :end_time,
      :photo_url,
      :target_audience
    )
  end
end
