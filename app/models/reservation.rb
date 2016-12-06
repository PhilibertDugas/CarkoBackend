class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :parking
  has_one :vehicule
end
