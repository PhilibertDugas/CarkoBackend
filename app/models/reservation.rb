class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :parking
  belongs_to :event
  has_one :vehicule

  def as_json(options = {})
    super(include: [:parking, :event])
  end
end
