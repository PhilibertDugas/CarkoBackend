class Parking < ApplicationRecord
  belongs_to :customer
  has_many :reservations

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude

  def available?(day)
    day_index = convert_day_to_index(day)
    availability_info["days_available"][day_index] == 0
  end

  private

  def convert_day_to_index(day)
    # converting days to our own system. a parking has availability in the forms of an array of 7 boolean
    # indice 0 represents monday, indice 6 represent sunday
    # the implementation of date has indice 0 has sunday and indice 6 as saturday
    # this method shifts the day to our own system
    initial_index = day.wday
    case initial_index
    when 0
      6
    else
      initial_index - 1
    end
  end
end
