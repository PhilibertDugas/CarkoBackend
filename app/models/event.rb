class Event < ApplicationRecord
  has_many :reservations

  def self.ordered_events
    Event.where("start_time > ?", Time.zone.today).sort_by(&:start_time)
  end

  def available_parkings
    parkings = Parking.near([latitude, longitude], range / 1000.0, units: :km)
    parkings.select { |parking| parking.available?(start_time) }
  end
end
