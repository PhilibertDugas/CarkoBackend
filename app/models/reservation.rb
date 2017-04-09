class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :parking
  has_one :vehicule

  after_create :reserve_parking

  def create_charge(charge_params, parking_id:)
    raise StandardError.new errors unless valid?

    parking = Parking.find_by(id: parking_id)
    charge = Charge.new(charge_params, parking: parking)
    self.charge = charge.save
  end

  private

  def wait_time
    stop_hour = stop_time.split(':').first
    stop_minute = stop_time.split(':').last
    Time.now.change(hour: stop_hour, min: stop_minute)
  end

  def reserve_parking
    parking.update(is_available: false)
    FreeParkingJob.set(wait_until: wait_time).perform_later(parking.id)
  end
end
