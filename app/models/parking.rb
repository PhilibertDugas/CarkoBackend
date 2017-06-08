class Parking < ApplicationRecord
  belongs_to :customer
  has_many :reservations

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude

  def available?(day_index)
    availability_info["days_available"][day_index] == 0
  end
end
