class Event < ApplicationRecord
  def self.ordered_events
    Event.all.sort_by(&:start_time)
  end

  def available_parkings
    parkings = Parking.near([latitude, longitude], range / 1000.0, units: :km)

    event_index = convert_day_to_array_index(start_time)
    parkings.select { |parking| parking.available?(event_index) }
  end

  private

  def convert_day_to_array_index(day)
    # converting days to our own system. a parking has availability in the forms of an array of 7 boolean
    # indice 0 represents monday, indice 6 represent sunday
    # the implementation of date has indice 0 has sunday and indice 6 as saturday
    # this method shifts the day to our own system
    initial_indice = day.wday
    case initial_indice
    when 0
      6
    else
      initial_indice - 1
    end
  end
end
