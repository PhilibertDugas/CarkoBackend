class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :parking
  has_one :vehicule

  def as_json(options = {})
    super(include: [:parking])
  end

  def create_charge(charge_params, parking_id:)
    raise StandardError.new errors.messages unless valid?

    parking = Parking.find_by(id: parking_id)
    charge = Charge.new(
      charge_params[:amount],
      customer: charge_params[:customer],
      currency: charge_params[:currency],
      parking: parking
    )
    self.charge = charge.save
  end

  def reserve_with_parking
    ActiveRecord::Base.transaction do
      parking.update(is_available: false)
      save
    end
    FreeParkingJob.set(wait_until: stop_time).perform_later(self)
  end
end
